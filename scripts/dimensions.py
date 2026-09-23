"""Check each metric's `dimensions` against the controlled list in data/dimensions.json.

Every entry must be a dimension ID (a key of dimensions.json), no metric lists a
dimension twice, and every dimension in the list is used by at least one metric.
"""
from collections import Counter


def dimension_issues(metrics, dimensions):
    """Problems with `dimensions` across `metrics` (the parsed data/metrics.json), given the parsed dimensions.json."""
    issues, used = [], set()
    for m in metrics:
        mid = m["metricId"]
        for d, n in Counter(m["dimensions"]).items():
            if d not in dimensions:
                issues.append(f"{mid}: dimensions {d!r} is not a key of data/dimensions.json")
            if n > 1:
                issues.append(f"{mid}: dimensions lists {d!r} twice")
        used.update(m["dimensions"])
    issues += [f"data/dimensions.json: {d!r} is not used by any metric" for d in dimensions if d not in used]
    return issues
