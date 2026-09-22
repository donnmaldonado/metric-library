#!/usr/bin/env python3
"""List the metrics whose primary dbt model lives in the given mart domains.

A metric belongs to the domain (dbt/models/marts/<domain>/) of the semantic
model behind its first measure, following ratio/derived inputs through other
metrics. The `vertical` field is not used because it is unreliable.

Usage: python3 scripts/owned_metrics.py finance saas ...
"""
import json, sys
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


def owners():
    measure_domain, metrics = {}, {}
    for f in MARTS.glob("*/*.yml"):
        doc = yaml.safe_load(f.read_text()) or {}
        for sm in doc.get("semantic_models", []):
            for ms in sm.get("measures", []):
                measure_domain[ms["name"]] = f.parent.name
        for m in doc.get("metrics", []):
            metrics[m["name"]] = m
    library = json.load(open(ROOT / "data/metrics.json"))
    for m in library:
        metrics[m["metricId"]] = yaml.safe_load(m["formulaYaml"])["metrics"][0]

    def domain(name, seen=()):
        if name in seen or name not in metrics:
            return None
        for kind, ref in _inputs(metrics[name]):
            d = measure_domain.get(ref) if kind == "measure" else domain(ref, seen + (name,))
            if d:
                return d
        return None

    return {m["metricId"]: domain(m["metricId"]) for m in library}


if __name__ == "__main__":
    wanted = set(sys.argv[1:])
    for mid, d in owners().items():
        if not wanted or d in wanted:
            print(f"{d}\t{mid}")
