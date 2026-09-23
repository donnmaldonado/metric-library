# 07 — Queryable dimensions

Read [README.md](README.md) first for the shared workflow and done gate. Runs after 06, in parallel with 08.

## Goal

Every dimension a metric lists can be grouped by in MetricFlow. 06 mapped `dimensions` to `data/dimensions.json` and reported, in [review/06-queryability.csv](review/06-queryability.csv), that 47 of 913 metric × dimension pairs can't be (`queryable = n`). This task closes each of those 47 one of three ways.

| dimension_id | pairs | typical metrics |
|---|---|---|
| `segment` | 12 | finance/SaaS ratios: `ebitda`, `nrr`, `grr`, `churn_rate`, `clv`, `cac_payback`, `dso`, … |
| `school_year` | 5 | education ratios across models |
| `channel` | 5 | cross-model ratios |
| `grade_level` | 3 | education ratios |
| `department`, `product_line`, `plan_tier`, `geography`, `cohort` | 2–3 each | cross-model ratios |
| `fund`, `function_code` | 1 each | `per_pupil_expenditure`; no model has them |
| 11 others | 1 each | see the CSV |

## Fixes, in order of preference

1. **model**: make it reachable. The usual cause is a ratio or derived metric whose inputs sit on different semantic models, where one input's model has no entity path to the dimension. Add the missing foreign-key entity (and its column to the stub model's SQL) to the semantic model in `dbt/models/marts/**/*.yml`, so every input measure reaches the dimension. Only do this where the column genuinely belongs on that grain (an invoice carries its customer, and so its customer's segment; a GL line doesn't).
2. **drop**: the dimension doesn't make sense for the metric (`segment` on company-wide `ebitda`). Remove it from the metric's `dimensions`.
3. **gap**: it makes sense but needs a model that doesn't exist (a line-grain finance model for `fund`/`function_code`, a school-year grain for cross-model education ratios). Leave it listed and record it under Model gaps in `README.md`. Don't build new models in this task.

Judge per pair, not per dimension: `segment` may be a model fix for `nrr` and a drop for `ebitda`. `mf list dimensions --metrics <id>` from the dbt venv checks a fix.

## Review table

`review/07-queryability.csv`: `metricId, dimension_id, input_models, cause, fix (model|drop|gap), change, notes`, one row per `n` pair from `06-queryability.csv`. `input_models` lists the semantic models behind the metric's input measures; `change` names the entity or column to add for `model` rows.

## Wiring

- A dimension that no metric uses any more is removed from `data/dimensions.json` (`validate.py` requires every entry to be used). A dimension a `model` fix now provides gets its `semantic` filled in.
- The queryability CSV is regenerated after the fixes as `review/07-queryability-after.csv` (same columns as 06), so the result can be checked.
- README: rewrite the "47 of 913" Model gaps entry to cover only the `gap` rows, or delete it if there are none.

## Done when

- Every row in `07-queryability-after.csv` is `y`, apart from the approved `gap` rows.
- `check_dbt.sh` passes with the new entities and columns, and the Model gaps entry lists exactly the `gap` rows.
