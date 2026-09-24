"""Export the kept metrics as the data files for the Metric Periodic Table (site/).

Reads data/metrics.json, drops the metrics listed in data/portfolio_exclude.json,
filters every edge list to the kept metrics, gives each metric a 1-3 letter
element-case symbol (overridable in data/portfolio_symbols.json), works out the
table's reading order, and writes:

- <out>/metrics.portfolio.json: meta, label maps and the metrics in layout order;
- <out>/formulas/<domain>.json: raw formulaYaml/formulaSql per metric, which the
  site's prebuild step highlights in place.

The export fails when a kept non-North-Star has no kept parent, a kept North Star
has no kept child, an exclusion or symbol override names an unknown metric, or
the symbols are not unique 1-3 letter element-case strings.

Run: python3 scripts/export_portfolio.py [--out DIR] [--check]
"""
import argparse, gzip, itertools, json, re, subprocess, sys
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DEFAULT_OUT = ROOT / "site/public/data"
EDGES = ("parentMetrics", "childMetrics", "correlatedMetrics", "formulaInputs")
FIELDS = ("metricId", "symbol", "label", "shortLabel", "unit", "domain", "tier", "industry",
          "shortDescription", "numerator", "denominator", "dimensions", "dataSources") + EDGES
TIERS = ("north_star", "kpi", "input")
STOPWORDS = {"a", "an", "and", "by", "for", "from", "in", "of", "on", "per", "the", "to", "vs", "with"}
SYMBOL = re.compile(r"^[A-Z][a-z0-9]{0,2}$")
INDUSTRY_LABELS = {"cross_industry": "Cross-industry", "saas": "SaaS"}


class ExportError(Exception):
    """The export cannot run; `issues` lists every problem found."""

    def __init__(self, issues):
        super().__init__("\n".join(issues))
        self.issues = issues


def apply_exclusion(metrics, exclude):
    """The metrics not in `exclude` (a {metricId: reason} map), with edge lists filtered to kept metrics."""
    ids = {m["metricId"] for m in metrics}
    unknown = [f"data/portfolio_exclude.json: {mid!r} is not a metricId in data/metrics.json"
               for mid in exclude if mid not in ids]
    if unknown:
        raise ExportError(unknown)
    kept_ids = ids - set(exclude)
    return [{**m, **{e: [x for x in m[e] if x in kept_ids] for e in EDGES}}
            for m in metrics if m["metricId"] in kept_ids]


def orphan_issues(kept):
    """Kept metrics the cut strands: non-North-Stars with no kept parent, North Stars with no kept child."""
    issues = []
    for m in kept:
        if m["tier"] == "north_star" and not m["childMetrics"]:
            issues.append(f"{m['metricId']}: north_star has no kept child")
        elif m["tier"] != "north_star" and not m["parentMetrics"]:
            issues.append(f"{m['metricId']}: {m['tier']} has no kept parent")
    return issues


def _descendants(by, mid):
    seen, stack = set(), list(by[mid]["childMetrics"])
    while stack:
        c = stack.pop()
        if c not in seen:
            seen.add(c)
            stack.extend(by[c]["childMetrics"])
    seen.discard(mid)
    return seen


def _first_parent_children(by, node, tier):
    """Metrics of `tier` whose first parent is `node`: node's childMetrics order, then any others by id."""
    listed = [c for c in by[node]["childMetrics"]
              if by[c]["tier"] == tier and by[c]["parentMetrics"][:1] == [node]]
    rest = sorted(mid for mid, m in by.items()
                  if m["tier"] == tier and m["parentMetrics"][:1] == [node] and mid not in listed)
    return listed + rest


def _preorder(by, root, tier, domain):
    """`tier` metrics of `domain` under `root` in the first-parent tree, preorder, children in childMetrics order."""
    out, stack = [], list(reversed(_first_parent_children(by, root, tier)))
    while stack:
        mid = stack.pop()
        if by[mid]["domain"] == domain:
            out.append(mid)
        stack.extend(reversed(_first_parent_children(by, mid, tier)))
    return out


def layout(kept, domain_labels):
    """Kept metrics in reading order (CONTRACT.md rules 1-5), each with its `group`, and the band order.

    Returns (ordered metric dicts, [(domainId, count), ...]). Assumes orphan_issues(kept) is empty.
    """
    by = {m["metricId"]: m for m in kept}
    counts = Counter(m["domain"] for m in kept)
    bands = sorted(counts, key=lambda d: (-counts[d], domain_labels.get(d, d)))

    ns = {d: sorted((m["metricId"] for m in kept if m["domain"] == d and m["tier"] == "north_star"),
                    key=lambda mid: (-len(_descendants(by, mid)), by[mid]["label"], mid)) for d in bands}
    ns_order = [mid for d in bands for mid in ns[d]]

    kpis = {}
    for d in bands:
        roots = ns[d] + [mid for mid in ns_order if by[mid]["domain"] != d]
        kpis[d] = [(mid, root) for root in roots for mid in _preorder(by, root, "kpi", d)]
    anchors = ns_order + [mid for d in bands for mid, _ in kpis[d]]

    inputs = {d: [(mid, by[mid]["parentMetrics"][0]) for a in anchors for mid in _preorder(by, a, "input", d)]
              for d in bands}

    order = []
    for d in bands:
        order += [(mid, mid) for mid in ns[d]] + kpis[d] + inputs[d]
    placed = {mid for mid, _ in order}
    unplaced = sorted(set(by) - placed)
    if unplaced:
        raise ExportError([f"{mid}: first-parent chain never reaches a North Star" for mid in unplaced])
    return [{**by[mid], "group": group} for mid, group in order], [(d, counts[d]) for d in bands]


def _element_case(s):
    return s[:1].upper() + s[1:].lower()


def _words(text):
    return [w for w in re.findall(r"[A-Za-z0-9]+", text) if w.lower() not in STOPWORDS]


def _prefix_candidates(words):
    """Symbols built from word prefixes: 3 letters spread over the first words, then 2, word 1 always leading."""
    words = words[:3]
    out = []
    for size in (3, 2):
        for alloc in itertools.product(range(size + 1), repeat=len(words)):
            if sum(alloc) == size and alloc[0] >= 1 and all(k <= len(w) for k, w in zip(alloc, words)):
                out.append("".join(w[:k] for k, w in zip(alloc, words)))
    return sorted(out, key=lambda s: -len(s))


def _combo_candidates(text):
    """Last resort: the first letter of `text` plus any 1-2 later letters, in order."""
    letters = "".join(_words(text))
    return [letters[0] + "".join(c) for n in (1, 2) for c in itertools.combinations(letters[1:], n)] if letters else []


def symbol_candidates(m):
    """Symbols to try for metric `m`, best first, all valid element-case strings of 1-3 characters."""
    words = _words(m["label"])
    raw = [words[0][:3]] if len(words) == 1 else []  # "ARR" -> "Arr", "Billings" -> "Bil"
    raw.append("".join(w[0] for w in words)[:3])
    raw += _prefix_candidates(words)
    raw.append("".join(w[0] for w in _words(m["shortLabel"]))[:3])
    raw.append("".join(p[0] for p in m["metricId"].split("_") if p)[:3])
    raw += _combo_candidates(m["label"]) + _combo_candidates(m["metricId"].replace("_", " "))
    seen, out = set(), []
    for s in map(_element_case, raw):
        if SYMBOL.match(s) and s not in seen:
            seen.add(s)
            out.append(s)
    return out


def assign_symbols(ordered, overrides):
    """{metricId: symbol} for `ordered` metrics (earlier ones get the better symbol); overrides win.

    Generated symbols avoid every override's symbol, so a collision can only come from
    the overrides themselves.
    """
    ids = [m["metricId"] for m in ordered]
    issues = [f"data/portfolio_symbols.json: {mid!r} is not a kept metric" for mid in overrides if mid not in ids]
    issues += [f"data/portfolio_symbols.json: {mid}: symbol {s!r} is not 1-3 characters in element case"
               for mid, s in overrides.items() if not SYMBOL.match(s)]
    taken, symbols = set(overrides.values()), {}
    for m in ordered:
        mid = m["metricId"]
        if mid in overrides:
            continue
        s = next((c for c in symbol_candidates(m) if c not in taken), None)
        if s is None:
            issues.append(f"{mid}: no unique symbol can be generated; add one to data/portfolio_symbols.json")
            continue
        taken.add(s)
        symbols[mid] = s
    symbols.update((mid, s) for mid, s in overrides.items() if mid in ids)
    for s, n in Counter(symbols.values()).items():
        if n > 1:
            issues.append(f"symbol {s!r} is used by " + ", ".join(sorted(mid for mid, x in symbols.items() if x == s)))
    if issues:
        raise ExportError(issues)
    return {mid: symbols[mid] for mid in ids}


def industry_label(industry):
    return INDUSTRY_LABELS.get(industry, industry.replace("_", " ").capitalize())


def _labelled(catalog, used):
    return {k: {"label": v["label"], "desc": v["desc"]} for k, v in catalog.items() if k in used}


def build(metrics, taxonomy, dimensions, sources, exclude, overrides, commit="", built_at=""):
    """(metrics.portfolio.json content, {domain: formulas file content}) from the parsed data files."""
    kept = apply_exclusion(metrics, exclude)
    orphans = orphan_issues(kept)
    if orphans:
        raise ExportError(orphans)
    domain_labels = {d: v["label"] for d, v in taxonomy["domains"].items()}
    ordered, bands = layout(kept, domain_labels)
    symbols = assign_symbols(ordered, overrides)

    out = []
    for n, m in enumerate(ordered, 1):
        row = {"number": n, **{f: m.get(f, "") for f in FIELDS}, "group": m["group"]}
        row["symbol"] = symbols[m["metricId"]]
        out.append(row)
    units = Counter(m["unit"] for m in ordered)
    tiers = Counter(m["tier"] for m in ordered)
    portfolio = {
        "meta": {
            "count": len(ordered),
            "libraryCount": len(metrics),
            "domains": [{"id": d, "label": domain_labels.get(d, d), "count": c} for d, c in bands],
            "tiers": {t: tiers[t] for t in TIERS},
            "units": dict(sorted(units.items(), key=lambda kv: (-kv[1], kv[0]))),
            "commit": commit,
            "builtAt": built_at,
        },
        "tierLabels": {t: v["label"] for t, v in taxonomy["tiers"].items()},
        "domainLabels": domain_labels,
        "industryLabels": {i: industry_label(i) for i in taxonomy["industries"]},
        "dimensions": _labelled(dimensions, {d for m in ordered for d in m["dimensions"]}),
        "sources": _labelled(sources, {s for m in ordered for s in m["dataSources"]}),
        "metrics": out,
    }
    formulas = {}
    for m in ordered:
        formulas.setdefault(m["domain"], {})[m["metricId"]] = {"yaml": m["formulaYaml"], "sql": m["formulaSql"]}
    return portfolio, formulas


def _compact(obj):
    return json.dumps(obj, separators=(",", ":"), ensure_ascii=False).encode()


def _commit():
    try:
        return subprocess.run(["git", "rev-parse", "--short", "HEAD"], cwd=ROOT, capture_output=True,
                              text=True, check=True).stdout.strip()
    except (OSError, subprocess.CalledProcessError):
        return ""


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--out", type=Path, default=DEFAULT_OUT, help="output directory (default site/public/data)")
    ap.add_argument("--check", action="store_true", help="run every check but write nothing")
    args = ap.parse_args(argv)

    load = lambda name: json.loads((ROOT / "data" / name).read_text())
    metrics = load("metrics.json")
    exclude = load("portfolio_exclude.json")
    try:
        portfolio, formulas = build(metrics, load("taxonomy.json"), load("dimensions.json"), load("sources.json"),
                                    exclude, load("portfolio_symbols.json"), commit=_commit(),
                                    built_at=datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"))
    except ExportError as e:
        print("\n".join(e.issues))
        print(f"\nexport_portfolio: {len(e.issues)} issues", file=sys.stderr)
        return 1

    data = _compact(portfolio)
    if not args.check:
        (args.out / "formulas").mkdir(parents=True, exist_ok=True)
        (args.out / "metrics.portfolio.json").write_bytes(data)
        for domain, f in formulas.items():
            (args.out / "formulas" / f"{domain}.json").write_bytes(_compact(f))
    print(f"export_portfolio: kept {portfolio['meta']['count']}, dropped {len(exclude)}; "
          f"metrics.portfolio.json {len(data)} B ({len(gzip.compress(data))} B gzipped)"
          + (" [check only, nothing written]" if args.check else ""))
    return 0


if __name__ == "__main__":
    sys.exit(main())
