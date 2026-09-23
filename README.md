# Metric Library

375 business metrics (22 North Star, 266 KPI, 87 Input) across 8 verticals. Each one has a definition, a MetricFlow metric, runnable SQL and its place in a driver tree.

## Layout

| Path | Contents |
|---|---|
| `data/metrics.json` | **Source of truth.** Per metric: metricId, retiredIds, label, tier, vertical, industry, description, SQL, YAML, numerator/denominator, dimensions, data sources, parent/child/correlated metrics and `formulaInputs`. |
| `data/taxonomy.json` | Tier and vertical labels and descriptions. |
| `data/relationships.csv` | Edge list: `parent_of`, `correlated_with` and `formula_input` (`A formula_input B` = B is computed from A), noting which metric declared each edge. |
| `CATALOG.md` | Readable index grouped by tier, with links between related metrics. |
| `dbt/` | dbt-core + duckdb project: 107 zero-row model stubs with semantic models (`models/marts/<domain>/`), a time spine and conventions ([dbt/CONVENTIONS.md](dbt/CONVENTIONS.md)). |
| `dbt/models/metrics/<vertical>/<id>.yml` | MetricFlow metric (generated from `formulaYaml`). |
| `dbt/analyses/metrics/<vertical>/<id>.sql` | SQL formula (generated from `formulaSql`). |
| `scripts/build.py` | Regenerates `dbt/models/metrics/`, `dbt/analyses/metrics/`, `relationships.csv` and `CATALOG.md` from `data/metrics.json`. |
| `scripts/validate.py` | Graph and YAML integrity checks; exits non-zero if any issue is found. |
| `scripts/check_dbt.sh` | Runs build.py, `dbt parse`, `dbt build`, the metric SQL and `mf validate-configs`. |
| `scripts/owned_metrics.py` | Lists metrics by the mart domain of their model (`python3 scripts/owned_metrics.py finance`). |

## Working on the library

Edit `data/metrics.json` (or the hand-maintained files under `dbt/models/marts/`), then:

```sh
python3 scripts/build.py      # regenerate dbt metric YAML, metric SQL, relationships.csv, CATALOG.md
python3 scripts/validate.py   # graph + YAML checks; must exit 0
scripts/check_dbt.sh          # dbt parse + build, run every metric's SQL, mf validate-configs (~35 s)
```

`check_dbt.sh` needs a Python 3.11 venv with dbt-core, dbt-duckdb and dbt-metricflow (see [dbt/CONVENTIONS.md](dbt/CONVENTIONS.md#environment)); point `DBT_VENV` at it. A `dbt` on PATH that is the dbt Cloud CLI won't work.

## Metric definition conventions

- **`formulaYaml` is a MetricFlow metric** (`type: simple | ratio | derived | cumulative`) over the semantic models in `dbt/models/marts/`.
- **`formulaSql` is runnable dbt SQL**: `{{ ref() }}` against the models, monthly by default (`date_trunc('month', …)`), consistent with the MetricFlow definition. `check_dbt.sh` runs all 375 against the stubs.
- **Rates are fractions (0–1)**, not percentages; score scales such as NPS/eNPS (−100 to 100) keep their native range.
- **Balances are never summed over time.** Snapshot models use `non_additive_dimension`; opening balances come from the prior period's close.
- **One metric per concept.** Duplicates are merged, not aliased: the surviving metric lists the IDs merged into it in `retiredIds` (present on every metric, empty by default), so old references can be traced. A slice of a metric (`revenue_by_region`) is a dimension on it, not a separate metric. `validate.py` rejects bare aliases (`type: derived`, one input, `expr` equal to the input) and retired IDs that are live or listed twice.
- `config.meta` carries `metricId`, `tier`, `vertical` and `industry`, refreshed from the JSON by `build.py`.
- The dbt models are zero-row stubs with the right columns and types; wiring them to real sources is the next step for a live deployment.
- The `vertical` field is unreliable (see [Known issues](#known-issues)); `scripts/owned_metrics.py` groups by model domain instead.

## Graph conventions

- **Parent/child is the driver tree.** A child drives its parent (`new_arr` → `arr`). Both sides always list the edge (`childMetrics` on the parent, `parentMetrics` on the child), and there are no cycles.
- **Tiers only flow downward.** A child's tier rank is ≥ its parent's (North Star 0 → KPI 1 → Input 2; equal is allowed).
- **North Stars are roots.** They have children and no parent. Every KPI and Input rolls up to at least one parent.
- **`formulaInputs`** lists metrics that a metric is *computed from* when that dependency isn't a driver edge, usually because it would run up the tree. For example, `gross_margin_pct` is computed from `revenue`, and `turnover_rate` from `headcount`. It is present on every metric (empty by default) and never self-referencing.
- **`correlatedMetrics` is symmetric.**
- When you change the graph in `data/metrics.json`, update both sides of every edge, then run `build.py` and `validate.py`, which enforce all of the above.

## Known issues

Open questions about specific definitions. Resolve one by updating the metric, then delete its entry.

**Provisional formulas**
- `account_health_score` and `vendor_scorecard_rating`: the composite weights are placeholders (0.4/0.3/0.3 and equal weights).
- `clv` (and `ltv_cac`) is only a lifetime value at year grain (`metric_time__year`); the monthly SQL understates it.

**Description vs numerator/denominator conflicts**
- `employee_lifetime_value`: the description implies a currency amount (value minus cost), but it's implemented as a ratio.
- `stockout_rate`: the description is "% of orders unfulfilled due to zero inventory", but it's implemented as stockout events / SKUs.
- `ops_efficiency_ratio`: the description and the numerator/denominator disagree.

**Choices to confirm**
- `revenue_growth_rate` is month over month (`revenue_vs_py` covers YoY).
- `marketing_roi` is net ROI, `(revenue - spend) / spend`, because the gross version equals `roas`.
- `headcount` counts full-time employees only; the per-employee ratios inherit that.
- `churn_rate` includes downgrades.
- `college_enrollment` (enrolled within 12 months) and `college_enrollment_rate` (16 months) are both kept, as are `sales_cycle_length` (first touch to closed-won) and `avg_sales_cycle` (opportunity created to closed).
- `cx_csat` counts the top two boxes (4–5 of 5), across all interaction types.
- `paid_sessions` treats `cpc`, `cpm` and `paid` as paid mediums.
- `sm_spend` and `magic_number` use department, while `sg_and_a` uses GL category `'S&M'`. Pick one basis. Whether `sg_and_a` should equal S&M + G&A is also open.
- Years are calendar years (`revenue_ytd`, `prior_year_revenue`); a fiscal calendar needs a fiscal time spine.
- `mtbf` and `mttr` describe equipment, but live on engineering incident/availability models.

**Model gaps**
- Balances on per-record models (`pipeline_value`, `expansion_pipeline`, `ticket_backlog`, `committed_arr`, `contracted_unbilled`) count by creation month. True period-end values need snapshot models.
- `survey_response_rate` needs a survey-send model. `feature_adoption_rate` per feature in MetricFlow needs a feature × period model. Per-pupil spend by function/fund needs a line-grain finance model. Cross-model education ratios need a school-year grain.
- `fct_service_availability` mixes availability windows with single downtime events. `safety_incident_rate` reads hours worked from rows in `fct_safety_incidents`. `fleet_utilization_rate` allocates available hours per trip.
- `gender_pay_gap` and `compensation_ratio` are computed over pay records, so employees paid more often weigh more.
- `support_cost_per_ticket` uses cost allocated on ticket rows rather than a finance model.
- Cohort metrics (`cohort_revenue_retention`, `cohort_churn`) are only meaningful grouped by `customer_cohort_period__months_since_acquisition`.
- Several stub models still carry unused pre-aggregated columns (noted in each model's header).

**Graph and catalog**
- Some parent edges are weak: the leverage family → `roe`, `roic` → `enterprise_value`, `ltv_cac` → `marketing_roi`, `magic_number` → `rule_of_40`, `forecast_accuracy` → `ebitda`, `carbon_emissions_per_unit` → `ops_efficiency_ratio`, `diversity_hire_rate` → `headcount`, survey metrics → `nps`, and `ell_pct`/`frl_pct`/`iep_pct` → `student_proficiency`.
- North Star → North Star links are recorded as `correlatedMetrics`; check that none is a real driver edge.
- `formulaInputs` is out of step with some definitions (e.g. `enrollment_count` on education metrics, `headcount` still listed on `absenteeism_rate`/`turnover_rate`/`span_of_control`).
- `vertical` is wrong on some metrics (e.g. `inventory_turnover` is tagged hr, `cross_sell_rate` edu, `lead_time`/`supplier_lead_time` marketing).
- `relationships.csv` lists each parent/child edge twice (declared on both sides).
