"""Check each metric's `dataSources` against the controlled list in data/sources.json.

Every entry must be a source ID (a key of sources.json), no metric lists a source
twice, and every source in the list is used by at least one metric.
"""
from collections import Counter


def source_issues(metrics, sources):
    """Problems with `dataSources` across `metrics` (the parsed data/metrics.json), given the parsed sources.json."""
    issues, used = [], set()
    for m in metrics:
        mid = m["metricId"]
        for s, n in Counter(m["dataSources"]).items():
            if s not in sources:
                issues.append(f"{mid}: dataSources {s!r} is not a key of data/sources.json")
            if n > 1:
                issues.append(f"{mid}: dataSources lists {s!r} twice")
        used.update(m["dataSources"])
    issues += [f"data/sources.json: {s!r} is not used by any metric" for s in sources if s not in used]
    return issues
