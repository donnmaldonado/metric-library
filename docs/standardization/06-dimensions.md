# 06 — Dimensions

Read [README.md](README.md) first for the shared workflow and done gate. Runs after 03, in parallel with 04 and 05.

## Goal

`dimensions` uses one vocabulary tied to the dbt semantic models. Today the same concept has several names: `date`/`period`/`month`/`created_date`, `school`/`school_id`, `grade`/`grade_level`, `school_year`/`academic_year`, `segment`/`customer_segment`/`user_segment`, `sales_rep`/`rep_id`.

## The dimension list

Create `data/dimensions.json`, keyed by canonical ID, each with `label`, a one-line `desc`, and `semantic` — the MetricFlow name(s) it corresponds to (`entity__dimension`, e.g. `customer__customer_segment`), or `null` where no model has it yet.

Build the list bottom-up from the semantic models in `dbt/models/marts/**/*.yml` (their `entities` and `dimensions`), and use their names as the canonical IDs wherever one exists. That way a metric's listed dimension is something you can actually query.

## Mapping rules

- **Time**: `date`, `period`, `month`, `quarter`, `created_date`, `fiscal_period`, `fiscal_year` → `metric_time`. Grain is a query choice, not a dimension. (Fiscal calendars are an open README issue; don't invent a fiscal dimension.) `school_year` stays its own dimension where an education model has it.
- **Entities**: `school`/`school_id` → one ID, following the semantic model's entity name; the same for customer, student, product, rep, campaign and so on.
- **Synonyms** collapse to one ID. A generic `segment` maps to the specific segment the metric's model carries (`customer_segment`, `user_segment`), judged per metric.
- After mapping, dedupe each metric's list and keep first-seen order.

## Queryability

For each metric × dimension, record whether MetricFlow can group that metric by it: the semantic model behind each input measure must reach the dimension through its entities (`mf list dimensions --metrics <id>` from the dbt venv answers this directly). Report this; don't drop unqueryable dimensions in this task. They show where models are missing, and the user decides their fate from the review table.

## Review table

- `review/06-dimensions.csv`: `raw_dimension, count, example_metrics, dimension_id, notes`, one row per distinct raw name (for per-metric decisions such as `segment`, one row per metric).
- `review/06-dimensions.json`: the proposed `data/dimensions.json`.
- `review/06-queryability.csv`: `metricId, dimension_id, queryable (y/n)`.

## Wiring

- `scripts/validate.py`: every `dimensions` entry is a key of `dimensions.json`; no duplicates within a metric; every entry in `dimensions.json` is used.
- `CATALOG.md` "Dimensions" line shows labels from `dimensions.json`.
- README Layout table: add `data/dimensions.json`; add a Model gaps entry summarizing unqueryable dimensions, if the user keeps them.

## Done when

- Every metric's `dimensions` holds only IDs from `data/dimensions.json`, and every approved CSV row is applied.
- `semantic` is filled for every dimension a semantic model provides.
