"""Check each metric's `label`, `shortLabel`, `unit` and `shortDescription` against docs/metric-conventions.md.

`label` is a Title Case name in words: no symbols, and any all-caps term is in
taxonomy.json `acronyms`. `shortLabel` (for tiles) is at most SHORT_LABEL_MAX characters. Labels
and short labels are each unique, `unit` is one of taxonomy.json `units`, and
`shortDescription` is one sentence ending in a period.
"""
import re
from collections import defaultdict

SYMBOLS = ("%", "#", "→", "/")
SHORT_LABEL_MAX = 24


def label_issues(metrics, taxonomy):
    """Problems with the label fields across `metrics` (the parsed data/metrics.json), given the parsed taxonomy.json."""
    issues, acronyms = [], set(taxonomy["acronyms"])
    users = {"label": defaultdict(list), "shortLabel": defaultdict(list)}  # value -> metricIds
    for m in metrics:
        mid, label, short = m["metricId"], m["label"], m["shortLabel"]
        for key in users:
            users[key][m[key]].append(mid)
        issues += [f"{mid}: label {label!r} contains {s!r}; use words" for s in SYMBOLS if s in label]
        if re.search(r"\bAvg\b", label):
            issues.append(f"{mid}: label {label!r} abbreviates 'Avg'; write 'Average'")
        if "(" in label:
            issues.append(f"{mid}: label {label!r} has a parenthesized qualifier; use words, and put units in `unit`")
        for word in re.findall(r"[A-Za-z&]+", label):
            if sum(c.isalpha() for c in word) >= 2 and word.isupper() and word not in acronyms:
                issues.append(f"{mid}: label {label!r} uses acronym {word!r}, not in taxonomy.acronyms; spell it out")
        if len(short) > SHORT_LABEL_MAX:
            issues.append(f"{mid}: shortLabel {short!r} is {len(short)} characters; the limit is {SHORT_LABEL_MAX}")
        desc = m["shortDescription"]
        if not desc.endswith("."):
            issues.append(f"{mid}: shortDescription doesn't end in a period")
        if re.search(r"[.!?]\s+[A-Z]", desc):
            issues.append(f"{mid}: shortDescription is more than one sentence")
        if m["unit"] not in taxonomy["units"]:
            issues.append(f"{mid}: unit {m['unit']!r} is not in taxonomy.units")
    for key, by_value in users.items():
        issues += [f"{key} {v!r} is used by {len(ids)} metrics ({', '.join(ids)})" for v, ids in by_value.items() if len(ids) > 1]
    return issues
