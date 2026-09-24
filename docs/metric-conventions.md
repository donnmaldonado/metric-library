# Metric conventions

The rules every metric in `data/metrics.json` follows. `scripts/validate.py` enforces most of them. For the dbt and MetricFlow side, see [dbt/CONVENTIONS.md](../dbt/CONVENTIONS.md).

## Definitions

- **`formulaYaml` is a MetricFlow metric** (`type: simple | ratio | derived | cumulative`) over the semantic models in `dbt/models/marts/`.
- **`formulaSql` is runnable dbt SQL**: `{{ ref() }}` against the models, monthly by default (`date_trunc('month', …)`), consistent with the MetricFlow definition. `check_dbt.sh` runs all 375 against the stubs.
- **Rates are fractions (0–1)**, not percentages; score scales such as NPS/eNPS (−100 to 100) keep their native range.
- **Balances are never summed over time.** Snapshot models use `non_additive_dimension`; opening balances come from the prior period's close.
- **One metric per concept.** Duplicates are merged, not aliased: the surviving metric lists the IDs merged into it in `retiredIds` (present on every metric, empty by default), so old references can be traced. A slice of a metric (`revenue_by_region`) is a dimension on it, not a separate metric. `validate.py` rejects bare aliases (`type: derived`, one input, `expr` equal to the input) and retired IDs that are live or listed twice.
- **`domain` follows the data.** It is the mart domain (`dbt/models/marts/<domain>/`) of the semantic model behind the metric's first measure, following ratio/derived inputs through other metrics (`scripts/domains.py`). It is stored in the JSON, and `validate.py` checks it against the derivation. Where a reader of another domain would clearly look for a cross-domain metric, `domainOverride: {domain, reason}` sets it instead (e.g. `ltv_cac` → finance). Use overrides sparingly.
- **`dataSources` names source systems**, as IDs from `data/sources.json`: the kind of system a data team would connect (`crm`, `erp`, `billing`, …). Vendors go in that source's `vendors`, never in a metric. Tables aren't listed; a metric's `ref()`s already show which models it reads. `validate.py` checks that every entry is a known ID, that no metric lists a source twice and that every source is used.
- **`dimensions` are IDs from `data/dimensions.json`**, named after the semantic models (`school`, `grade_level`, `segment`, `rep`), so a listed dimension is meant to be one you can group by (the exceptions are under [Model gaps](known-issues.md#model-gaps)). Time is always `metric_time`; the grain (`date`, `month`, `quarter`, fiscal period) is a query choice, not a dimension. `validate.py` checks that every entry is a known ID, that no metric lists a dimension twice and that every dimension is used.
- **`label` is the full Title Case name** of the quantity, in words: `Average` not `Avg`, `Rate`/`Share`/`Margin` not `%`, `to` not `→` or `/`, and no `#`, unit or parenthesized qualifier ("Grade 3 Reading Proficiency Rate", "Trial-to-Paid Conversion Rate"). Acronyms are spelled out unless they are the everyday name and listed in `acronyms` in `data/taxonomy.json` (ARR, EBITDA, SLA, R&D, …). Labels are unique. `build.py` writes it to the MetricFlow `label`.
- **`shortLabel`** follows `label`: at most 24 characters for dashboard tiles and chart axes, where abbreviations, acronyms and `%` are welcome (`Gr3 Reading %`, `NRR`, `Avg Teacher Exp`). It equals `label` when the label already fits. Unique across the library.
- **`unit`** follows `shortLabel`, one of `units` in `data/taxonomy.json`: `rate` (a 0–1 fraction shown as %), `ratio` (a multiple or per-item quantity), `currency`, `count`, `score` (a native scale), or a duration (`days`, `months`, `years`, `hours`, `minutes`, `seconds`, `milliseconds`). It comes from the formula, not the label.
- **`shortDescription`** is one sentence ending in a period.
- **`industry`** is `cross_industry` unless the metric only makes sense for one industry (`saas`, `education`, …); the allowed values are listed in `data/taxonomy.json`.
- `config.meta` carries `metricId`, `tier`, `domain`, `industry`, `shortLabel` and `unit`, refreshed from the JSON by `build.py`, which also sets the MetricFlow `label`. `validate.py` checks that the YAML `label` matches.
- The dbt models are zero-row stubs with the right columns and types; wiring them to real sources is the next step for a live deployment.

## Graph

- **Parent/child is the driver tree.** A child drives its parent (`new_arr` → `arr`). Both sides always list the edge (`childMetrics` on the parent, `parentMetrics` on the child), and there are no cycles.
- **Tiers only flow downward.** A child's tier rank is ≥ its parent's (North Star 0 → KPI 1 → Input 2; equal is allowed).
- **North Stars are roots.** They have children and no parent. Every KPI and Input rolls up to at least one parent.
- **`formulaInputs`** lists the metrics a metric is *computed from* that aren't already driver edges, usually because the dependency would run up the tree (`gross_margin_pct` is computed from `revenue`). It is derived from `formulaYaml` (`scripts/formula_inputs.py`), in the order the formula names them: library metrics named as ratio or derived inputs, plus any unfiltered `simple` metric whose measure the formula reads (directly or through metrics defined in the marts), or a filtered one when the formula applies the same filter. Metrics in `parentMetrics`/`childMetrics` are left out. It is present on every metric (empty by default), and `validate.py` checks it against the derivation.
- **`correlatedMetrics` is symmetric.**
- When you change the graph in `data/metrics.json`, update both sides of every edge, then run `build.py` and `validate.py`, which enforce all of the above.
