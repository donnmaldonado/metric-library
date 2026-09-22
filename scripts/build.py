"""Regenerate derived artifacts from data/metrics.json + data/taxonomy.json.

  data/relationships.csv                            one row per edge
  dbt/models/metrics/<vertical>/<metric_id>.yml     MetricFlow metric (formulaYaml, meta refreshed)
  dbt/analyses/metrics/<vertical>/<metric_id>.sql   SQL formula (formulaSql)
  CATALOG.md                                        human-readable index

Never edit those outputs by hand; edit data/metrics.json and re-run.
The semantic models under dbt/models/marts/ are maintained by hand (see dbt/CONVENTIONS.md).
"""
import csv, json, shutil, sys
from collections import OrderedDict, defaultdict
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parent.parent
TAXONOMY = json.loads((ROOT / "data/taxonomy.json").read_text())
YML_DIR = "dbt/models/metrics"
SQL_DIR = "dbt/analyses/metrics"


class _Dumper(yaml.SafeDumper):
    def increase_indent(self, flow=False, indentless=False):  # indent list items under their key
        return super().increase_indent(flow, False)


def _str(dumper, s):
    style = '"' if "{{" in s else ("|" if "\n" in s else None)
    return dumper.represent_scalar("tag:yaml.org,2002:str", s, style=style)


_Dumper.add_representer(str, _str)
_Dumper.add_representer(OrderedDict, lambda d, v: d.represent_dict(v.items()))


def dump_yaml(obj):
    """The one YAML style for everything generated under dbt/ (and formulaYaml)."""
    return yaml.dump(obj, Dumper=_Dumper, sort_keys=False, allow_unicode=True, width=120)


def metric_meta(m, **extra):
    return OrderedDict([("metricId", m["metricId"]), ("tier", m["tier"]), ("vertical", m["vertical"]),
                        ("industry", m["industry"])] + list(extra.items()))


def metric_yaml(m):
    """formulaYaml with config.meta refreshed from the metric's current tier/vertical/industry."""
    doc = yaml.safe_load(m["formulaYaml"])
    metric = doc["metrics"][0]
    old = (metric.get("config") or {}).get("meta") or {}
    extra = {k: v for k, v in old.items() if k not in ("metricId", "tier", "vertical", "industry")}
    metric.setdefault("config", {})["meta"] = metric_meta(m, **extra)
    return dump_yaml(doc)


def main():
    metrics = json.loads((ROOT / "data/metrics.json").read_text())
    by_id = {m["metricId"]: m for m in metrics}

    with open(ROOT / "data/relationships.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["from_metric", "to_metric", "relationship", "declared_on", "to_exists"])
        for m in metrics:
            for p in m["parentMetrics"]:
                w.writerow([p, m["metricId"], "parent_of", m["metricId"], p in by_id])
            for c in m["childMetrics"]:
                w.writerow([m["metricId"], c, "parent_of", m["metricId"], c in by_id])
            for c in m["correlatedMetrics"]:
                w.writerow([m["metricId"], c, "correlated_with", m["metricId"], c in by_id])
            # "<input> formula_input <metric>": metric is computed from input
            for f in m.get("formulaInputs", []):
                w.writerow([f, m["metricId"], "formula_input", m["metricId"], f in by_id])

    yml_root, sql_root = ROOT / YML_DIR, ROOT / SQL_DIR
    shutil.rmtree(yml_root, ignore_errors=True)
    shutil.rmtree(sql_root, ignore_errors=True)
    for m in metrics:
        for root, ext, text in ((yml_root, "yml", metric_yaml(m)), (sql_root, "sql", m["formulaSql"].rstrip() + "\n")):
            d = root / m["vertical"]
            d.mkdir(parents=True, exist_ok=True)
            (d / f"{m['metricId']}.{ext}").write_text(text)

    write_catalog(sorted(metrics, key=lambda m: (TAXONOMY["tiers"][m["tier"]]["rank"], m["vertical"], m["metricId"])), by_id)
    print(f"built {len(metrics)} metrics", file=sys.stderr)


def write_catalog(metrics, by_id):
    link = lambda i: f"[`{i}`](#{i})" if i in by_id else f"`{i}` (missing)"
    out = ["# Metric Catalog", "", f"{len(metrics)} metrics.", ""]
    groups = defaultdict(list)
    for m in metrics:
        groups[m["tier"]].append(m)
    for tier, t in TAXONOMY["tiers"].items():
        out += [f"## {t['label']} ({len(groups[tier])})", ""]
        for m in groups[tier]:
            v = TAXONOMY["verticals"][m["vertical"]]["label"]
            out += [
                f'<a id="{m["metricId"]}"></a>',
                f"### {m['label']} — `{m['metricId']}`",
                "",
                m["shortDescription"],
                "",
                f"- **Vertical:** {v} · **Industry:** {m['industry']}",
                f"- **Files:** [yml]({YML_DIR}/{m['vertical']}/{m['metricId']}.yml) · [sql]({SQL_DIR}/{m['vertical']}/{m['metricId']}.sql)",
            ]
            if m["numerator"]: out.append(f"- **Numerator:** {m['numerator']}")
            if m["denominator"]: out.append(f"- **Denominator:** {m['denominator']}")
            if m["dimensions"]: out.append(f"- **Dimensions:** {', '.join(m['dimensions'])}")
            if m["dataSources"]: out.append(f"- **Data sources:** {', '.join(m['dataSources'])}")
            for key, lbl in [("parentMetrics", "Parents"), ("childMetrics", "Children"),
                             ("formulaInputs", "Formula inputs"), ("correlatedMetrics", "Correlated")]:
                if m.get(key): out.append(f"- **{lbl}:** {', '.join(link(x) for x in m[key])}")
            out.append("")
    (ROOT / "CATALOG.md").write_text("\n".join(out))



if __name__ == "__main__":
    main()
