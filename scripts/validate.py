"""Check data/metrics.json for integrity problems. Run after editing."""
import json, re, sys
from collections import defaultdict
from pathlib import Path
import yaml

from dimensions import dimension_issues
from domains import derived_domains, domain_issues
from formula_inputs import derived_formula_inputs, formula_input_issues
from labels import label_issues
from sources import source_issues

ROOT = Path(__file__).resolve().parent.parent
RANK = {"north_star": 0, "kpi": 1, "input": 2}
MF_TYPES = {"simple", "ratio", "derived", "cumulative", "conversion"}
ms = json.loads((ROOT / "data/metrics.json").read_text())
by = {m["metricId"]: m for m in ms}
taxonomy = json.loads((ROOT / "data/taxonomy.json").read_text())
sources = json.loads((ROOT / "data/sources.json").read_text())
dimensions = json.loads((ROOT / "data/dimensions.json").read_text())
derived_domain = derived_domains(ms)
derived_inputs = derived_formula_inputs(ms)


def bare_alias_of(d):
    """The input a derived metric merely renames (one input, expr is that input, no offset or filter), else None."""
    tp = d.get("type_params") or {}
    inputs = tp.get("metrics") or []
    if d.get("type") != "derived" or len(inputs) != 1 or d.get("filter"):
        return None
    i = inputs[0]
    if any(k in i for k in ("offset_window", "offset_to_grain", "filter")):
        return None
    return i.get("name") if str(tp.get("expr", "")).strip() in (i.get("name"), i.get("alias")) else None


issues = []
retired_on = defaultdict(list)  # retired id -> metrics listing it

if len(by) != len(ms):
    issues.append("duplicate metricIds")
for m in ms:
    mid = m["metricId"]
    if re.search(r"^stg_|_stg$", mid):
        issues.append(f"{mid}: staging metricId (stg_ prefix or _stg suffix); the library holds business metrics only")
    issues += domain_issues(m, derived_domain[mid], taxonomy)
    if m.get("industry") not in taxonomy["industries"]:
        issues.append(f"{mid}: industry {m.get('industry')!r} is not in taxonomy.industries")
    try:
        d = yaml.safe_load(m["formulaYaml"])["metrics"][0]
        if d.get("name") != mid:
            issues.append(f"{mid}: yaml name is {d.get('name')!r}")
        for yaml_key, key in (("label", "label"), ("description", "shortDescription")):
            if d.get(yaml_key) != m[key]:
                issues.append(f"{mid}: yaml {yaml_key} is {d.get(yaml_key)!r}, not the {key} {m[key]!r}; run build.py")
        if d.get("type") not in MF_TYPES:  # MetricFlow shape; run scripts/check_dbt.sh for dbt parse
            issues.append(f"{mid}: yaml is not a MetricFlow metric (type {d.get('type')!r})")
    except Exception as e:
        issues.append(f"{mid}: invalid yaml ({str(e).splitlines()[0]})")
        d = {}
    if bare_alias_of(d):
        issues.append(f"{mid}: bare alias of {bare_alias_of(d)}; merge it and list {mid} in retiredIds")
    for key in ("parentMetrics", "childMetrics", "correlatedMetrics"):
        for ref in m[key]:
            if ref not in by:
                issues.append(f"{mid}: {key} -> unknown metric {ref!r}")
    for c in m["childMetrics"]:
        if c in by and mid not in by[c]["parentMetrics"]:
            issues.append(f"{mid}: lists child {c} but {c} doesn't list it as parent")
        if c in by and RANK[by[c]["tier"]] < RANK[m["tier"]]:
            issues.append(f"{mid} ({m['tier']}): child {c} is higher tier ({by[c]['tier']})")
    for p in m["parentMetrics"]:
        if p in by and mid not in by[p]["childMetrics"]:
            issues.append(f"{mid}: lists parent {p} but {p} doesn't list it as child")

    for c in m["correlatedMetrics"]:
        if c in by and mid not in by[c]["correlatedMetrics"]:
            issues.append(f"{mid}: correlated with {c} but {c} doesn't list it back")
    for key in ("formulaInputs", "retiredIds"):
        if key not in m:
            issues.append(f"{mid}: missing {key} field")
    for r in m.get("retiredIds", []):
        if r in by:
            issues.append(f"{mid}: retiredIds lists {r}, which is a live metricId")
        retired_on[r].append(mid)
    for f in m.get("formulaInputs", []):
        if f == mid:
            issues.append(f"{mid}: formulaInputs references itself")
        elif f not in by:
            issues.append(f"{mid}: formulaInputs -> unknown metric {f!r}")
    issues += formula_input_issues(m, derived_inputs[mid].inputs)
    for key in ("parentMetrics", "childMetrics", "correlatedMetrics"):
        if mid in m[key]:
            issues.append(f"{mid}: {key} references itself")

    if not (m["parentMetrics"] or m["childMetrics"]):
        issues.append(f"{mid}: orphan (no parent or child metrics)")
    elif m["tier"] == "north_star" and m["parentMetrics"]:
        issues.append(f"{mid}: north star has parents {m['parentMetrics']}")
    elif m["tier"] == "north_star" and not m["childMetrics"]:
        issues.append(f"{mid}: north star has no children")
    elif m["tier"] != "north_star" and not m["parentMetrics"]:
        issues.append(f"{mid}: {m['tier']} doesn't roll up to any parent")

issues += source_issues(ms, sources)
issues += dimension_issues(ms, dimensions)
issues += label_issues(ms, taxonomy)

for r, owners in retired_on.items():
    if len(owners) > 1:
        issues.append(f"retired id {r} is listed {len(owners)} times ({', '.join(owners)})")

# cycles in the parent -> child graph (iterative DFS, reports each cycle once)
WHITE, GREY, BLACK = 0, 1, 2
color = {mid: WHITE for mid in by}
for root in by:
    if color[root] != WHITE:
        continue
    stack = [(root, iter(by[root]["childMetrics"]))]
    path = [root]
    color[root] = GREY
    while stack:
        node, it = stack[-1]
        nxt = next((c for c in it if c in by), None)
        if nxt is None:
            color[node] = BLACK
            stack.pop()
            path.pop()
        elif color[nxt] == GREY:
            issues.append("cycle in parent/child graph: " + " -> ".join(path[path.index(nxt):] + [nxt]))
        elif color[nxt] == WHITE:
            color[nxt] = GREY
            stack.append((nxt, iter(by[nxt]["childMetrics"])))
            path.append(nxt)

print("\n".join(issues))
print(f"\n{len(issues)} issues across {len(ms)} metrics", file=sys.stderr)
sys.exit(1 if issues else 0)
