"""Derive each metric's `formulaInputs` from its formulaYaml, and check the stored list against it.

Metric B is a formula input of metric A when A's formula reads B:

- by name: B is a library metric named in a derived metric's `metrics`, or as a
  ratio's numerator/denominator;
- by measure: A reads (directly, or through metrics defined in the marts) the
  measure a library `simple` metric B is defined on, and B has no filter or A
  applies the same one. When the filters differ, A reads a different quantity
  than B, and B is not listed. If no library metric (A included) matches that
  measure read, B is `flagged` as a possible formula bug (e.g. a per-employee
  ratio that counts all employees where `headcount` counts full-time ones).

B is dropped when it is already a driver edge (in A's childMetrics or
parentMetrics). Inputs keep the order the formula names them.
"""
from collections import namedtuple
from pathlib import Path

import yaml

from domains import MARTS, _name

FormulaInputs = namedtuple("FormulaInputs", "inputs flagged")


def _filters(ref):
    """The filters a metric or metric reference applies, as a comparable set."""
    f = ref.get("filter") if isinstance(ref, dict) else None
    if not f:
        return frozenset()
    return frozenset(" ".join(s.split()) for s in ([f] if isinstance(f, str) else f))


def _refs(metric):
    """Metric references a ratio or derived metric reads, in declaration order."""
    tp = metric.get("type_params") or {}
    if metric["type"] == "ratio":
        return [tp["numerator"], tp["denominator"]]
    if metric["type"] == "derived":
        return tp.get("metrics", [])
    return []


def derived_formula_inputs(library, marts=MARTS):
    """{metricId: FormulaInputs(inputs, flagged)} for every metric in `library` (the parsed data/metrics.json)."""
    mart_metrics = {}
    for f in Path(marts).glob("*/*.yml"):
        for m in (yaml.safe_load(f.read_text()) or {}).get("metrics", []):
            mart_metrics[m["name"]] = m
    formulas = {}
    for m in library:
        try:  # validate.py reports unparsable formulaYaml; here it just has no inputs
            formulas[m["metricId"]] = yaml.safe_load(m["formulaYaml"])["metrics"][0]
        except Exception:
            pass
    by_measure = {}  # measure -> [(library simple metric, its filters)]
    for mid, f in formulas.items():
        if f["type"] == "simple":
            by_measure.setdefault(_name(f["type_params"]["measure"]), []).append((mid, _filters(f)))

    def reads(metric, applied, seen):
        """(kind, name, filters) for each library metric or measure `metric` reads, through mart metrics."""
        applied = applied | _filters(metric)
        if metric["type"] in ("simple", "cumulative"):
            yield "measure", _name(metric["type_params"]["measure"]), applied
            return
        for ref in _refs(metric):
            name = _name(ref)
            if name in formulas:
                yield "metric", name, None
            elif name in mart_metrics and name not in seen:
                yield from reads(mart_metrics[name], applied | _filters(ref), seen | {name})

    result = {}
    for m in library:
        mid, inputs, flagged = m["metricId"], [], []
        for kind, name, applied in reads(formulas[mid], frozenset(), frozenset()) if mid in formulas else ():
            if kind == "metric":
                inputs.append(name)
                continue
            matches, others = [], []
            for b, b_filters in by_measure.get(name, []):
                (matches if not b_filters or b_filters == applied else others).append(b)
            inputs += matches
            # A simple or cumulative A defines the quantity it reads, so only flag reads no library metric matches
            if not matches and formulas[mid]["type"] not in ("simple", "cumulative"):
                flagged += others
        edges = {mid, *m.get("childMetrics", []), *m.get("parentMetrics", [])}
        inputs = list(dict.fromkeys(b for b in inputs if b not in edges))
        flagged = list(dict.fromkeys(b for b in flagged if b not in edges and b not in inputs))
        result[mid] = FormulaInputs(inputs, flagged)
    return result


def formula_input_issues(m, derived):
    """Problems with metric `m`'s formulaInputs, given the derived list."""
    stored = m.get("formulaInputs", [])
    if stored == derived:
        return []
    missing = [b for b in derived if b not in stored]
    extra = [b for b in stored if b not in derived]
    detail = f"missing {missing}, extra {extra}" if missing or extra else "wrong order"
    return [f"{m['metricId']}: formulaInputs is {stored} but derives as {derived} ({detail})"]
