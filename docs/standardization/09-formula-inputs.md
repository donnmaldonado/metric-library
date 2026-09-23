# 09 — formulaInputs follows the formulas

Read [README.md](README.md) first for the shared workflow and done gate. Runs after 07 merges. Both edit `data/metrics.json` (07 may drop dimensions), so 09 waits for 07. It doesn't need 08.

## Goal

`formulaInputs` lists exactly the metrics a metric is computed from that aren't already driver edges, and `validate.py` keeps it that way. Today 37 metrics set it by hand, and some entries have drifted from the definitions. `absenteeism_rate`, `turnover_rate` and `span_of_control` list `headcount`, but their formulas read `unplanned_absence_days`/`available_working_days`, `separations`/`avg_headcount` and neither. Other metrics read an input they don't list.

## The rule

Metric B is a formula input of metric A when A's `formulaYaml` reads B:

- **by name**: B appears under `type_params.metrics` of a derived metric, or as `numerator`/`denominator` of a ratio where that name is a metric;
- **by measure**: A reads, as a measure, the measure a `simple` metric B is defined on. Count it only if B has no `filter`, or A applies the same filter. Otherwise A reads a different quantity (e.g. all employees vs B's full-time `headcount`), and it's flagged, not listed.

Then remove the edges already in the driver tree: B is not listed if B is in A's `childMetrics` or `parentMetrics`. What's left is A's `formulaInputs`, in the order the formula names them.

Put the derivation in a new `scripts/formula_inputs.py`, as `domains.py` does for domain (a function per metric, plus unittest cases in `scripts/test_formula_inputs.py` for each rule above).

## Review table

`review/09-formula-inputs.csv`: `metricId, current, derived, added, removed, flagged, notes`, one row per metric where `current` ≠ `derived` or `flagged` is non-empty. `flagged` lists by-measure matches whose filters differ. Say in `notes` which of those looks like a formula bug (e.g. a per-employee ratio that means `headcount` but counts all employees). Don't change formulas here: a bug found goes into README Known issues.

## Wiring

- `scripts/validate.py`: every metric's `formulaInputs` equals the derivation (import from `formula_inputs.py`).
- README: the `formulaInputs` graph convention says it is derived from `formulaYaml` and checked. Delete the "`formulaInputs` is out of step" Known issues entry, and add any flagged formula bugs.
- `relationships.csv` `formula_input` rows follow from `build.py`; nothing to change there.

## Done when

- `validate.py` passes with the new check, and every approved CSV row is applied.
- `python3 -m unittest discover -s scripts` passes.
