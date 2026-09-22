"""Check data/metrics.json for integrity problems. Run after editing."""
import json, sys
from pathlib import Path
import yaml

ROOT = Path(__file__).resolve().parent.parent
RANK = {"north_star": 0, "kpi": 1, "input": 2}
MF_TYPES = {"simple", "ratio", "derived", "cumulative", "conversion"}
ms = json.loads((ROOT / "data/metrics.json").read_text())
by = {m["metricId"]: m for m in ms}
issues = []

if len(by) != len(ms):
    issues.append("duplicate metricIds")
for m in ms:
    mid = m["metricId"]
    try:
        d = yaml.safe_load(m["formulaYaml"])["metrics"][0]
        if d.get("name") != mid:
            issues.append(f"{mid}: yaml name is {d.get('name')!r}")
        if d.get("type") not in MF_TYPES:  # MetricFlow shape; run scripts/check_dbt.sh for dbt parse
            issues.append(f"{mid}: yaml is not a MetricFlow metric (type {d.get('type')!r})")
    except Exception as e:
        issues.append(f"{mid}: invalid yaml ({str(e).splitlines()[0]})")
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
    if "formulaInputs" not in m:
        issues.append(f"{mid}: missing formulaInputs field")
    for f in m.get("formulaInputs", []):
        if f == mid:
            issues.append(f"{mid}: formulaInputs references itself")
        elif f not in by:
            issues.append(f"{mid}: formulaInputs -> unknown metric {f!r}")
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
