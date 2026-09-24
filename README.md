# Metric Library

375 business metrics (22 North Star, 266 KPI, 87 Input) across 11 domains. Each one has a definition, a MetricFlow metric, runnable SQL and its place in a driver tree.

## Layout

| Path | Contents |
|---|---|
| `data/metrics.json` | **Source of truth.** Per metric: metricId, retiredIds, label, shortLabel, unit, domain (and `domainOverride` where set), industry, tier, description, SQL, YAML, numerator/denominator, dimensions (IDs from `data/dimensions.json`), data sources (IDs from `data/sources.json`), parent/child/correlated metrics and `formulaInputs`. |
| `data/taxonomy.json` | Tier and domain labels and descriptions, the allowed industries and units, and the acronyms allowed in labels. |
| `data/sources.json` | The controlled list of source systems (CRM, ERP, HRIS, SIS, ad platforms, …): per source ID, a label, a one-line description and example vendors. |
| `data/dimensions.json` | The controlled list of dimensions: per dimension ID, a label, a one-line description and `semantic`, the MetricFlow names that provide it (`metric_time`, an entity such as `school`, or `<entity>__<dimension>`), or `null` where no model has it yet. |
| `data/relationships.csv` | Edge list: `parent_of`, `correlated_with` and `formula_input` (`A formula_input B` = B is computed from A), noting which metric declared each edge. |
| `CATALOG.md` | Readable index grouped by tier and domain, with links between related metrics. |
| `dbt/` | dbt-core + duckdb project: 107 zero-row model stubs with semantic models (`models/marts/<domain>/`), a time spine and conventions ([dbt/CONVENTIONS.md](dbt/CONVENTIONS.md)). |
| `dbt/models/metrics/<domain>/<id>.yml` | MetricFlow metric (generated from `formulaYaml`). |
| `dbt/analyses/metrics/<domain>/<id>.sql` | SQL formula (generated from `formulaSql`). |
| `scripts/build.py` | Regenerates `dbt/models/metrics/`, `dbt/analyses/metrics/`, `relationships.csv` and `CATALOG.md` from `data/metrics.json`. |
| `scripts/validate.py` | Graph and YAML integrity checks; exits non-zero if any issue is found. |
| `scripts/check_dbt.sh` | Runs build.py, `dbt parse`, `dbt build`, the metric SQL and `mf validate-configs`. |
| `scripts/domains.py` | Derives each metric's domain from the marts and checks the stored `domain`; used by `validate.py` and `owned_metrics.py`. Tests: `python3 -m unittest discover -s scripts`. |
| `scripts/sources.py` | Checks each metric's `dataSources` against `data/sources.json`; used by `validate.py`. |
| `scripts/dimensions.py` | Checks each metric's `dimensions` against `data/dimensions.json`; used by `validate.py`. |
| `scripts/formula_inputs.py` | Derives each metric's `formulaInputs` from its `formulaYaml` and checks the stored list; used by `validate.py`. |
| `scripts/labels.py` | Checks `label`, `shortLabel`, `unit` and `shortDescription` against the conventions below; used by `validate.py`. |
| `scripts/owned_metrics.py` | Lists metrics by derived domain (`python3 scripts/owned_metrics.py finance`). |
| `scripts/export_portfolio.py` | Exports the periodic-table data (`site/public/data/`, not committed) from `data/metrics.json`: applies `data/portfolio_exclude.json`, filters edges to kept metrics, fails on stranded metrics, generates symbols (overrides in `data/portfolio_symbols.json`) and writes the layout order. `--check` runs it without writing. |
| `data/portfolio_exclude.json` | Metrics left out of the periodic table, one ID per line with a reason. |
| `data/portfolio_symbols.json` | Hand-picked element symbols that override the generated ones. |
| `docs/portfolio/stranded-metrics.csv` | The parent edges added so the portfolio cut strands no metric, with the rule and reason for each. |
| `site/` | The Metric Periodic Table: a Vite + TypeScript static site that shows the kept metrics as element tiles ([spec](https://claude.ai/code/artifact/bf02b340-5baa-47c1-82c5-5d5ad5155005)). |
| `.github/workflows/pages.yml` | On every push to `main`: build, validate, export, build the site and deploy it to GitHub Pages. |

## Working on the library

Edit `data/metrics.json` (or the hand-maintained files under `dbt/models/marts/`), then:

```sh
python3 scripts/build.py      # regenerate dbt metric YAML, metric SQL, relationships.csv, CATALOG.md
python3 scripts/validate.py   # graph + YAML checks; must exit 0
scripts/check_dbt.sh          # dbt parse + build, run every metric's SQL, mf validate-configs (~35 s)
```

`check_dbt.sh` needs a Python 3.11 venv with dbt-core, dbt-duckdb and dbt-metricflow (see [dbt/CONVENTIONS.md](dbt/CONVENTIONS.md#environment)); point `DBT_VENV` at it. A `dbt` on PATH that is the dbt Cloud CLI won't work.

## The periodic table site

`site/` shows the library as a periodic table at `https://donnmaldonado.github.io/metric-library/` (deep link: `?m=<metricId>`). It reads generated JSON that is never committed:

```sh
python3 scripts/export_portfolio.py   # data/metrics.json → site/public/data/ (fails if the cut strands a metric)
cd site && npm ci && npm run build     # highlights the formulas with Shiki, then builds site/dist
npm run dev                            # local dev server (run the export first)
```

The GitHub Actions workflow runs the same steps on every push to `main` and deploys `site/dist`; nothing deploys if `validate.py`, the tests or the export fail. Which metrics are shown is decided by `data/portfolio_exclude.json`; every kept non-North-Star needs a kept parent and every kept North Star a kept child, so dropping a metric may need new edges in `data/metrics.json` (see `docs/portfolio/stranded-metrics.csv` for the ones added so far). The Pages base path comes from the repo name (`BASE_PATH` env var, default `/metric-library/`).

## Metric definition conventions

- **`formulaYaml` is a MetricFlow metric** (`type: simple | ratio | derived | cumulative`) over the semantic models in `dbt/models/marts/`.
- **`formulaSql` is runnable dbt SQL**: `{{ ref() }}` against the models, monthly by default (`date_trunc('month', …)`), consistent with the MetricFlow definition. `check_dbt.sh` runs all 375 against the stubs.
- **Rates are fractions (0–1)**, not percentages; score scales such as NPS/eNPS (−100 to 100) keep their native range.
- **Balances are never summed over time.** Snapshot models use `non_additive_dimension`; opening balances come from the prior period's close.
- **One metric per concept.** Duplicates are merged, not aliased: the surviving metric lists the IDs merged into it in `retiredIds` (present on every metric, empty by default), so old references can be traced. A slice of a metric (`revenue_by_region`) is a dimension on it, not a separate metric. `validate.py` rejects bare aliases (`type: derived`, one input, `expr` equal to the input) and retired IDs that are live or listed twice.
- **`domain` follows the data.** It is the mart domain (`dbt/models/marts/<domain>/`) of the semantic model behind the metric's first measure, following ratio/derived inputs through other metrics (`scripts/domains.py`). It is stored in the JSON, and `validate.py` checks it against the derivation. Where a reader of another domain would clearly look for a cross-domain metric, `domainOverride: {domain, reason}` sets it instead (e.g. `ltv_cac` → finance). Use overrides sparingly.
- **`dataSources` names source systems**, as IDs from `data/sources.json`: the kind of system a data team would connect (`crm`, `erp`, `billing`, …). Vendors go in that source's `vendors`, never in a metric. Tables aren't listed; a metric's `ref()`s already show which models it reads. `validate.py` checks that every entry is a known ID, that no metric lists a source twice and that every source is used.
- **`dimensions` are IDs from `data/dimensions.json`**, named after the semantic models (`school`, `grade_level`, `segment`, `rep`), so a listed dimension is meant to be one you can group by (the exceptions are under Model gaps). Time is always `metric_time`; the grain (`date`, `month`, `quarter`, fiscal period) is a query choice, not a dimension. `validate.py` checks that every entry is a known ID, that no metric lists a dimension twice and that every dimension is used.
- **`label` is the full Title Case name** of the quantity, in words: `Average` not `Avg`, `Rate`/`Share`/`Margin` not `%`, `to` not `→` or `/`, and no `#`, unit or parenthesized qualifier ("Grade 3 Reading Proficiency Rate", "Trial-to-Paid Conversion Rate"). Acronyms are spelled out unless they are the everyday name and listed in `acronyms` in `data/taxonomy.json` (ARR, EBITDA, SLA, R&D, …). Labels are unique. `build.py` writes it to the MetricFlow `label`.
- **`shortLabel`** follows `label`: at most 24 characters for dashboard tiles and chart axes, where abbreviations, acronyms and `%` are welcome (`Gr3 Reading %`, `NRR`, `Avg Teacher Exp`). It equals `label` when the label already fits. Unique across the library.
- **`unit`** follows `shortLabel`, one of `units` in `data/taxonomy.json`: `rate` (a 0–1 fraction shown as %), `ratio` (a multiple or per-item quantity), `currency`, `count`, `score` (a native scale), or a duration (`days`, `months`, `years`, `hours`, `minutes`, `seconds`, `milliseconds`). It comes from the formula, not the label.
- **`shortDescription`** is one sentence ending in a period.
- **`industry`** is `cross_industry` unless the metric only makes sense for one industry (`saas`, `education`, …); the allowed values are listed in `data/taxonomy.json`.
- `config.meta` carries `metricId`, `tier`, `domain`, `industry`, `shortLabel` and `unit`, refreshed from the JSON by `build.py`, which also sets the MetricFlow `label`. `validate.py` checks that the YAML `label` matches.
- The dbt models are zero-row stubs with the right columns and types; wiring them to real sources is the next step for a live deployment.

## Graph conventions

- **Parent/child is the driver tree.** A child drives its parent (`new_arr` → `arr`). Both sides always list the edge (`childMetrics` on the parent, `parentMetrics` on the child), and there are no cycles.
- **Tiers only flow downward.** A child's tier rank is ≥ its parent's (North Star 0 → KPI 1 → Input 2; equal is allowed).
- **North Stars are roots.** They have children and no parent. Every KPI and Input rolls up to at least one parent.
- **`formulaInputs`** lists the metrics a metric is *computed from* that aren't already driver edges, usually because the dependency would run up the tree (`gross_margin_pct` is computed from `revenue`). It is derived from `formulaYaml` (`scripts/formula_inputs.py`), in the order the formula names them: library metrics named as ratio or derived inputs, plus any unfiltered `simple` metric whose measure the formula reads (directly or through metrics defined in the marts), or a filtered one when the formula applies the same filter. Metrics in `parentMetrics`/`childMetrics` are left out. It is present on every metric (empty by default), and `validate.py` checks it against the derivation.
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
- `paid_attribution_pct`, `organic_attribution_pct` and `referral_attribution_pct`: the description is "% of closed revenue", but they're implemented as channel share of all opportunity ARR (open and closed) by creation date.

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
- `survey_response_rate` needs a survey-send model. `feature_adoption_rate` per feature in MetricFlow needs a feature × period model.
- `fct_service_availability` mixes availability windows with single downtime events. `safety_incident_rate` reads hours worked from rows in `fct_safety_incidents`. `fleet_utilization_rate` allocates available hours per trip.
- `gender_pay_gap` and `compensation_ratio` are computed over pay records, so employees paid more often weigh more.
- `support_cost_per_ticket` uses cost allocated on ticket rows rather than a finance model.
- Cohort metrics (`cohort_revenue_retention`, `cohort_churn`) are only meaningful grouped by `customer_cohort_period__months_since_acquisition`.
- 28 of 907 metric × dimension pairs can't be grouped by in MetricFlow yet ([review/07-queryability.csv](docs/standardization/review/07-queryability.csv), `fix = gap`); each needs a model that doesn't exist. `segment`/`cohort` on `clv` and `cac_payback`, and `channel` on `ltv_cac` and `cac_payback`, need unit economics at customer grain (`fct_unit_economics` is a period summary with no customer). `segment`/`channel` on `gross_margin_pct` and `location` on `inventory_turnover` need COGS below the GL line. `segment` on `dso` and `bad_debt_rate`, and `vendor` on `dpo`, need AR, write-offs and AP at invoice or bill grain. `school_year` on `grade3_reading`, `ap_participation_rate`, `suspension_rate`, `expulsion_rate` and `student_teacher_ratio`, `subgroup` on `suspension_rate`, `grade_level`/`demographic_group` on `advanced_course_enrollment_rate` need a student or school × school-year grain, and `grade_level` on `seat_fill_rate` a school × school-year × grade grain. `channel` on `cost_per_mql`/`cost_per_sql` needs a campaign dimension model. `department` on `headcount_vs_budget` needs a department entity. `segment`/`geography` on `market_penetration_rate` need a grain shared with `fct_market_sizing`. `fund`/`function_code` on `per_pupil_expenditure` need a line-grain school finance model.
- Several stub models still carry unused pre-aggregated columns (noted in each model's header).

**Graph and catalog**
- Some parent edges are weak: the leverage family → `roe`, `roic` → `enterprise_value`, `ltv_cac` → `marketing_roi`, `magic_number` → `rule_of_40`, `forecast_accuracy` → `ebitda`, `carbon_emissions_per_unit` → `ops_efficiency_ratio`, `diversity_hire_rate` → `headcount`, survey metrics → `nps`, and `ell_pct`/`frl_pct`/`iep_pct` → `student_proficiency`. Weak edges added so the portfolio cut strands no metric ([docs/portfolio/stranded-metrics.csv](docs/portfolio/stranded-metrics.csv)): `carbon_emissions_per_unit` → `cost_per_unit`, `budget_variance_pct` → `opex`, `avg_tenure` → `turnover_rate`, and `seat_fill_rate`/`staff_student_cost_ratio` → `student_proficiency`.
- North Star → North Star links are recorded as `correlatedMetrics`; check that none is a real driver edge.
- `relationships.csv` lists each parent/child edge twice (declared on both sides).
