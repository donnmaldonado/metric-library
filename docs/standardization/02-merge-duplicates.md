# 02 — Merge duplicates

Read [README.md](README.md) first for the shared workflow and done gate. Runs after 01.

## Goal

One metric per concept, with no alias metrics left. The library currently chains duplicates as MetricFlow aliases (`type: derived`, `expr: <canonical>`, single input), e.g. `return_on_equity` → `roe`, `attendance_rate` → `student_attendance_rate`. Merge them outright: the duplicate's entry is deleted and everything that pointed at it points at the canonical metric.

## Find the candidates

Two sources, both required:

1. **Chained aliases**: every metric whose `formulaYaml` is `type: derived` with exactly one input metric and `expr` equal to that input's name.
2. **Unchained near-duplicates**: pairs with no alias link that name the same concept. Scan IDs and labels for plural/singular, word-order, prefix and abbreviation variants. Known ones: `backlink_count`/`backlinks_count`, `school_climate_score`/`school_culture_score`, `customer_health_score`/`account_health_score`, `customer_ltv`/`clv`, `attendance_rate`/`student_attendance_rate`/`average_daily_attendance`.

## Classify each candidate

- **merge** — same concept, same formula. Delete the duplicate.
- **slice** — the canonical metric cut by a dimension (`gross_margin_by_segment`, `revenue_by_channel`, `headcount_by_dept`, `sales_cycle_by_segment`). Delete it; make sure the dimension is listed in the canonical metric's `dimensions`.
- **variant** — the alias carries an `offset_window`, `filter` or different grain (`prior_year_revenue` has `offset_window: 1 year`), or its description names a different quantity. Keep it as a real metric: write out its own `formulaYaml`/`formulaSql` so it no longer reads as an alias.
- **distinct** — different concepts that happen to be linked (`backlink_count` is referring domains, `backlinks_count` is backlinks; `payback_ratio`'s description says LTV/CAC). Un-alias it and give it a correct definition, or propose retiring it.

The description, numerator and denominator decide the class, not the ID. Where they conflict (the README's Known issues list several), flag the row.

## Choosing the canonical ID

Keep the current canonical by default. Propose swapping to the duplicate's ID only when the canonical is an unclear abbreviation and the duplicate is the standard name (`otd_rate` vs `on_time_delivery_rate`); widely used acronyms stay (`nrr`, `arr`, `cac`, `roe`). Choose the higher tier and the richer description, dimensions and graph edges from the pair when they differ.

## Merge mechanics

- Union the duplicate's `parentMetrics`, `childMetrics`, `correlatedMetrics`, `formulaInputs` and `dimensions` into the canonical metric, dropping self-references and edges that would violate the tier rule or create a cycle.
- Replace the duplicate's ID in every other metric's edges and `formulaYaml`.
- Add `retiredIds: [...]` (placed after `metricId`) to the canonical metric, listing every ID merged into it, so old references can be traced. Present on every metric, empty by default.

## Review table

`review/02-merge-duplicates.csv`: `metricId, label, class (merge|slice|variant|distinct), canonical_id, swap_canonical (y/n), reason, flags`.

## Validation to add

In `scripts/validate.py`:
- no metric is a bare alias (derived, one input, `expr` == input name, no offset or filter);
- no ID in any `retiredIds` is also a live `metricId`, and each retired ID appears once across the library.

## Done when

- The alias detector above finds zero metrics.
- Every row of the approved CSV is applied, and `retiredIds` accounts for every deleted ID.
- README: the "Duplicates have one canonical metric…" convention now describes `retiredIds`; the Known issues entries for chained duplicates, `payback_ratio`, `average_daily_attendance`, `customer_health_score` merge, and the `backlink_count`/`backlinks_count`/`customer_ltv` labels are resolved or rewritten to what remains.
