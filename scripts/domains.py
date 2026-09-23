"""Derive each metric's domain from the dbt marts, and check the stored `domain` against it.

A metric's domain is the mart domain (dbt/models/marts/<domain>/) of the semantic
model behind its first measure, following ratio/derived inputs through other
metrics (library metrics and metrics defined in the marts). Inputs whose domain
can't be resolved (unknown, unparsable or cyclic) are skipped. A metric may carry
`domainOverride: {"domain", "reason"}` where a reader of another domain would
clearly look for it.
"""
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parent.parent
MARTS = ROOT / "dbt/models/marts"


def _name(ref):
    return ref["name"] if isinstance(ref, dict) else ref


def _inputs(metric):
    """Measures and metrics a MetricFlow metric reads, in declaration order."""
    tp = metric.get("type_params") or {}
    if metric["type"] in ("simple", "cumulative"):
        return [("measure", _name(tp["measure"]))]
    if metric["type"] == "ratio":
        return [("metric", _name(tp["numerator"])), ("metric", _name(tp["denominator"]))]
    return [("metric", _name(m)) for m in tp.get("metrics", [])]


def derived_domains(library, marts=MARTS):
    """{metricId: domain or None} for every metric in `library` (the parsed data/metrics.json)."""
    measure_domain, metrics = {}, {}
    for f in Path(marts).glob("*/*.yml"):
        doc = yaml.safe_load(f.read_text()) or {}
        for sm in doc.get("semantic_models", []):
            for ms in sm.get("measures", []):
                measure_domain[ms["name"]] = f.parent.name
        for m in doc.get("metrics", []):
            metrics[m["name"]] = m
    for m in library:
        try:  # validate.py reports unparsable formulaYaml; here it just has no domain
            metrics[m["metricId"]] = yaml.safe_load(m["formulaYaml"])["metrics"][0]
        except Exception:
            metrics.pop(m["metricId"], None)

    def domain(name, seen=()):
        if name in seen or name not in metrics:
            return None
        for kind, ref in _inputs(metrics[name]):
            d = measure_domain.get(ref) if kind == "measure" else domain(ref, seen + (name,))
            if d:
                return d
        return None

    return {m["metricId"]: domain(m["metricId"]) for m in library}


def domain_issues(m, derived, taxonomy):
    """Problems with metric `m`'s domain and domainOverride, given its derived domain."""
    mid, dom, override = m["metricId"], m.get("domain"), m.get("domainOverride")
    issues = []
    if dom not in taxonomy["domains"]:
        issues.append(f"{mid}: domain {dom!r} is not in taxonomy.domains")
    if override:
        override_dom = override.get("domain")
        if dom != override_dom:
            issues.append(f"{mid}: domain is {dom!r} but domainOverride.domain is {override_dom!r}")
        if not str(override.get("reason") or "").strip():
            issues.append(f"{mid}: domainOverride has no reason")
        if override_dom == derived:
            issues.append(f"{mid}: domainOverride.domain equals the derived domain {derived!r}; drop the override")
    elif derived is None:
        issues.append(f"{mid}: domain is {dom!r} but no domain derives from its inputs; add a domainOverride")
    elif dom != derived:
        issues.append(f"{mid}: domain is {dom!r} but derives as {derived!r}; fix it or add a domainOverride")
    return issues
