# dbt / MetricFlow conventions

For anyone editing metric definitions (`formulaYaml`), metric SQL (`formulaSql`) or the dbt models.
Open definition questions are listed under [Known issues](../README.md#known-issues) in the README.

## Environment

- dbt-core 1.12.5, dbt-duckdb 1.11.0, dbt-metricflow 0.15.0 (MetricFlow 0.213.0), Python 3.11.
- Venv: `/private/tmp/claude-501/-Users-donnobanmaldonado-Projects-metrics/7b5b290a-330a-4c5f-882c-972e94fe51d5/scratchpad/.venv-dbt`. If it's gone, recreate it with `python3.11 -m venv <path> && <path>/bin/pip install dbt-core dbt-duckdb dbt-metricflow pyyaml`, then point `DBT_VENV` at it.
- The `dbt` on PATH is the dbt Cloud CLI and can't run this project. Always use the venv's `dbt` and `mf`.
- The profile is `dbt/profiles.yml`. The database is `dbt/metric_library.duckdb` (gitignored). Set `DBT_PROFILES_DIR` to `dbt/`, or pass `--profiles-dir .`.

## Regenerate and check

```sh
python3 scripts/build.py          # data/metrics.json -> dbt/models/metrics/, dbt/analyses/metrics/, CATALOG.md
scripts/check_dbt.sh --fast       # build.py + dbt parse                          (~5 s)
scripts/check_dbt.sh              # + dbt build, run every metric SQL, mf validate-configs   (~35 s)
python3 scripts/validate.py       # graph + YAML shape checks; must exit 0
```

Single commands, run from `dbt/` with `V=<venv>`:

```sh
DBT_PROFILES_DIR=. $V/bin/dbt parse --no-partial-parse
DBT_PROFILES_DIR=. $V/bin/dbt build
DBT_PROFILES_DIR=. $V/bin/dbt show --select <metric_id>        # run one analysis (metric SQL)
DBT_PROFILES_DIR=. $V/bin/mf validate-configs                   # also runs every metric against duckdb
DBT_PROFILES_DIR=. $V/bin/mf query --metrics aov --group-by metric_time__month --explain
```

`check_dbt.sh` passes when `dbt parse` succeeds with no deprecation warnings, `dbt build` succeeds, every metric SQL file executes, and `mf validate-configs` reports no errors. These warnings are expected and harmless:

- `Metric '<name>' was included in the OSI document, but its cumulative window ... cannot be represented`, once per cumulative metric (`mau`, `wau`, `revenue_ytd`, `revenue_ttm`, `cogs_ttm`, `opex_ttm`, `da_ttm`, `lifetime_order_revenue`, `lifetime_ordering_customers`). dbt writes an OSI export on every parse, and that format has no cumulative windows.
- A note that the private helper metric `user_events_distinct_user_count` (behind `mau`/`wau`) is excluded from the OSI document.
- `mf validate-configs` reports one warning per cumulative metric above (`WARNINGS: 9`), "should not have both a measure and a metric as inputs". This is a quirk of this dbt-core/MetricFlow pairing: it appears whether the cumulative metric uses `measure:` or `cumulative_type_params.metric:`.

A new cumulative metric adds one warning of each kind; update this list when you add one.

## What is generated and what is hand-maintained

| Path | Source of truth | How to change it |
|---|---|---|
| `dbt/models/metrics/<vertical>/<id>.yml` | `formulaYaml` in `data/metrics.json` | Edit `formulaYaml`, run `build.py`. Never edit the file directly. |
| `dbt/analyses/metrics/<vertical>/<id>.sql` | `formulaSql` in `data/metrics.json` | Edit `formulaSql`, run `build.py`. |
| `dbt/models/marts/<domain>/<model>.sql/.yml` | these files | Edit by hand. |
| `dbt/models/utilities/` | these files | Time spine; leave it alone. |

`build.py` rewrites `config.meta.{metricId,tier,vertical,industry}` from the metric's current fields on every build. Tier changes therefore flow into dbt without touching `formulaYaml`, and you don't need to maintain those four keys by hand. Other meta keys are preserved.

Keep `data/metrics.json` formatted as `json.dumps(metrics, indent=2, ensure_ascii=False) + "\n"`, in the same metric order.

## Models

- One model per logical entity or grain, in `models/marts/<domain>/`. Domains: `finance`, `saas`, `sales`, `marketing`, `product`, `engineering`, `customer`, `commerce`, `operations`, `hr`, `education`.
- `fct_<plural noun>` for events, transactions and period summaries (`fct_orders`, `fct_arr_movements`, `fct_income_statement`). `dim_<plural noun>` for entities (`dim_customers`, `dim_users`, `dim_products`, `dim_staff`, `dim_processes`).
- Each model is a zero-row stub: `select cast(null as <type>) as <col>, ... where false`. Types: `varchar` for ids and categories, `date` for `*_date`, `timestamp` for `*_at`/`*_time`, `double` for amounts, counts and 0/1 flags, `boolean` for true/false filter fields.
- Every model has a primary key column (`<entity>_id` unless the config says otherwise) and one `date` column that is its `agg_time_dimension`.
- A new model needs a stub `.sql`, a `.yml` with `models:` + `semantic_models:`, and a primary entity name that is unique across the project.

## Semantic models

- The semantic model name equals the dbt model name (`fct_orders`), which keeps it from colliding with metric names.
- **Primary entity:** a singular noun, unique per semantic model (`order`, `ticket`, `arr_movement`, `financial_period`). Filters reference dimensions through it: `{{ Dimension('order__channel') }}`.
- **Foreign entities:** every `<x>_id` column that isn't the key. The entity takes the name of the model whose key it is (`customer_id` → `customer`, `user_id` → `user`, `order_id` → `order`); otherwise it is `<x>`.
- **Time dimensions:** `agg_time_dimension` is the model's date column (`defaults.agg_time_dimension`). Any other `*_date`/`*_time`/`*_at` dimension is also `type: time` with `time_granularity: day`. Don't add `date`/`period`/`month`/`quarter`/`fiscal_period` dimension columns. Query those as `metric_time__<grain>`.
- **Categorical dimensions:** snake_case, and never a MetricFlow reserved word (`select`, `from`, `day`, `month`, `metric_time`, …). If a dimension name clashes with an entity name anywhere in the project, it gets a `_name` suffix (`product` → `product_name`, `school` → `school_name`, `campaign` → `campaign_name`). A name must have the same element type (time, categorical, entity or measure) in every semantic model. `mf validate-configs` enforces all of this.
- **Normalised synonyms:** `customer_segment` → `segment`, `grade` → `grade_level`, `level` → `job_level`, `plan` → `plan_tier`, `feature` → `feature_name`, `form` → `form_name`, `sales_rep` → `rep_id`, `facility` → `facility_id`.
- **Snapshot models** (`fct_balance_sheet`, `fct_subscriptions`, `fct_employee_snapshots`, `fct_deferred_revenue`, `fct_valuations`, `fct_market_sizing`, `fct_seo_*`, `fct_github_repos`, `fct_warehouse_capacity`, `fct_benefits_enrollment`, `fct_inventory_snapshots`, `fct_social_metrics`, `fct_code_quality`, `dim_processes`): every balance measure has `non_additive_dimension: {name: <time col>, window_choice: max}`, so balances aren't summed over time.

## Measures

Measure names are unique across the whole project and follow this pattern:

| Aggregation | Measure name | Example |
|---|---|---|
| `sum` of a column | `<column>` | `order_amount` |
| `count` of a column | `<column minus _id>_count` | `ticket_count` (count of `ticket_id`) |
| `count_distinct` | `distinct_<column minus _id>_count` | `distinct_user_count` |
| `average` / `max` | `avg_<column>` / `max_<column>` | `avg_duration_seconds` |
| `percentile` / `median` | `p<NN>_<column>` / `median_<column>` | `p95_response_time_ms` |
| anything with an expression | `<metricId>_value` | `arr_value` = `sum(monthly_amount * 12)` |
| ratio part given as an expression | `<metricId>_numerator` / `_denominator` | `cpm` → `spend * 1000` |
| ratio/derived input (column name) | `<column>` | `total_tickets` |

If two semantic models want the same name, both get the model name as a prefix, without `fct_`/`dim_` (`orders_total_orders`, `user_events_distinct_user_count`). The same applies when a name clashes with a dimension or entity.

**Helper metrics.** MetricFlow ratio and derived metrics take *metrics* as inputs, not measures. A ratio/derived input that matches a library metric id uses that metric, even across semantic models (`roa` = `net_income / total_assets`). Any other input gets a helper: a measure plus a same-named `type: simple` metric under `metrics:` in the semantic model's `.yml`. There are 185 helpers. They carry no `meta` and use the name as the label. Derived metrics use `alias:` when the helper name differs from the identifier in `expr`.

### Adding or fixing a measure

1. Add the column to the stub `.sql` with the right type (keep the `where false`).
2. Add the measure under `measures:` in the same `.yml`: `name`, `agg` (`sum`, `count`, `count_distinct`, `average`, `min`, `max`, `percentile`, `sum_boolean`), `expr` if it differs from the name, `agg_params` for percentiles, `non_additive_dimension` on snapshot models, and a `description`.
3. A ratio or derived input needs a metric. Add a helper `type: simple` metric under `metrics:` in the same file, or put a `filter` on it: a count with a filter usually beats a pre-computed 0/1 column (`escalated_tickets` = `ticket_count` filtered on `{{ Dimension('ticket__is_escalated') }}`). When you replace a helper, delete the old one and its column if nothing else uses them (grep `dbt/models`).
4. Reference it from the library metric's `formulaYaml` and run `scripts/check_dbt.sh`.

Semantic model files are shared between verticals (the header lists the metrics on each model). Make additive edits, and don't rename or delete measures or helpers another vertical's metric uses.

## Metrics (`formulaYaml`)

Each `formulaYaml` is a `metrics:` list with exactly one metric whose `name` is the metricId:

```yaml
metrics:
  - name: mql
    label: MQLs
    description: Leads meeting scoring threshold passed to sales
    type: simple                     # simple | ratio | derived | cumulative
    type_params:
      measure: lead_count
    filter: "{{ Dimension('lead__lifecycle_stage') }} = 'mql'"
    config:
      meta:                          # refreshed by build.py
        metricId: mql
        tier: north_star
        vertical: marketing
        industry: cross_industry
```

- `label` comes from the metric's `label` field and must be unique across all metrics. Where two metrics share a label, the second has a ` (<metricId>)` suffix. These are usually duplicates (see [Known issues](../README.md#known-issues)).
- `description` is `shortDescription`.
- Plain aggregations are `simple`. Distinct counts over a rolling window of more than one day (`mau`, `wau`) are `cumulative` with `cumulative_type_params.window`. A quotient of two metrics is `ratio`; anything that mixes metrics into an expression is `derived`. A row-level expression is a `simple` metric over a `<metricId>_value` measure.
- Filters: `{{ Dimension('<primary_entity>__<dimension>') }} <op> <literal>`. Combine clauses with `AND`. For time, use `{{ TimeDimension('metric_time', 'day') }}`. A ratio's metric-level `filter` applies to both numerator and denominator. To filter one side only, use `numerator: {name: x, filter: "..."}`.
- Prefer an existing library metric over a new helper when it means the same thing. For period comparisons, use `offset_window` on a derived input instead of a `prior_*` column. For trailing windows, use a `cumulative` metric instead of a `ttm_*` column.

## Metric SQL (`formulaSql`)

- Each `formulaSql` runs against the dbt models via `{{ ref('<model>') }}`. **Always use `ref()`; plain model names don't work.** `build.py` writes it to `dbt/analyses/metrics/<vertical>/<metricId>.sql`. dbt parses these as analyses, so a `ref()` to a model that doesn't exist fails `dbt parse`. `check_dbt.sh` then compiles and executes every analysis against the zero-row stubs, which catches missing columns and type errors.
- Use only columns that exist in the stubs. If you need a new column, add it to the stub (and to the semantic model if a metric needs it).
- Match the metric's definition in `formulaYaml`, and return one row per the metric's natural dimensions: `date_trunc('month', <time col>) as period` plus the categorical dimensions. Name the metric column after the metricId.
- Write multi-line, lower-case SQL with `nullif(x, 0)` on every denominator. It must be duckdb-compatible (`datediff('day', a, b)`, `date_trunc`).
