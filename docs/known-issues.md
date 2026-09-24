# Known issues

Open questions about specific definitions. Resolve one by updating the metric, then delete its entry.

## Provisional formulas
- `account_health_score` and `vendor_scorecard_rating`: the composite weights are placeholders (0.4/0.3/0.3 and equal weights).
- `clv` (and `ltv_cac`) is only a lifetime value at year grain (`metric_time__year`); the monthly SQL understates it.

## Description vs numerator/denominator conflicts
- `employee_lifetime_value`: the description implies a currency amount (value minus cost), but it's implemented as a ratio.
- `stockout_rate`: the description is "% of orders unfulfilled due to zero inventory", but it's implemented as stockout events / SKUs.
- `ops_efficiency_ratio`: the description and the numerator/denominator disagree.
- `paid_attribution_pct`, `organic_attribution_pct` and `referral_attribution_pct`: the description is "% of closed revenue", but they're implemented as channel share of all opportunity ARR (open and closed) by creation date.

## Choices to confirm
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

## Model gaps
- Balances on per-record models (`pipeline_value`, `expansion_pipeline`, `ticket_backlog`, `committed_arr`, `contracted_unbilled`) count by creation month. True period-end values need snapshot models.
- `survey_response_rate` needs a survey-send model. `feature_adoption_rate` per feature in MetricFlow needs a feature × period model.
- `fct_service_availability` mixes availability windows with single downtime events. `safety_incident_rate` reads hours worked from rows in `fct_safety_incidents`. `fleet_utilization_rate` allocates available hours per trip.
- `gender_pay_gap` and `compensation_ratio` are computed over pay records, so employees paid more often weigh more.
- `support_cost_per_ticket` uses cost allocated on ticket rows rather than a finance model.
- Cohort metrics (`cohort_revenue_retention`, `cohort_churn`) are only meaningful grouped by `customer_cohort_period__months_since_acquisition`.
- 28 of 907 metric × dimension pairs can't be grouped by in MetricFlow yet ([review/07-queryability.csv](standardization/review/07-queryability.csv), `fix = gap`); each needs a model that doesn't exist. `segment`/`cohort` on `clv` and `cac_payback`, and `channel` on `ltv_cac` and `cac_payback`, need unit economics at customer grain (`fct_unit_economics` is a period summary with no customer). `segment`/`channel` on `gross_margin_pct` and `location` on `inventory_turnover` need COGS below the GL line. `segment` on `dso` and `bad_debt_rate`, and `vendor` on `dpo`, need AR, write-offs and AP at invoice or bill grain. `school_year` on `grade3_reading`, `ap_participation_rate`, `suspension_rate`, `expulsion_rate` and `student_teacher_ratio`, `subgroup` on `suspension_rate`, `grade_level`/`demographic_group` on `advanced_course_enrollment_rate` need a student or school × school-year grain, and `grade_level` on `seat_fill_rate` a school × school-year × grade grain. `channel` on `cost_per_mql`/`cost_per_sql` needs a campaign dimension model. `department` on `headcount_vs_budget` needs a department entity. `segment`/`geography` on `market_penetration_rate` need a grain shared with `fct_market_sizing`. `fund`/`function_code` on `per_pupil_expenditure` need a line-grain school finance model.
- Several stub models still carry unused pre-aggregated columns (noted in each model's header).

## Graph and catalog
- Some parent edges are weak: the leverage family → `roe`, `roic` → `enterprise_value`, `ltv_cac` → `marketing_roi`, `magic_number` → `rule_of_40`, `forecast_accuracy` → `ebitda`, `carbon_emissions_per_unit` → `ops_efficiency_ratio`, `diversity_hire_rate` → `headcount`, survey metrics → `nps`, and `ell_pct`/`frl_pct`/`iep_pct` → `student_proficiency`. Weak edges added so the portfolio cut strands no metric ([docs/portfolio/stranded-metrics.csv](portfolio/stranded-metrics.csv)): `carbon_emissions_per_unit` → `cost_per_unit`, `budget_variance_pct` → `opex`, `avg_tenure` → `turnover_rate`, and `seat_fill_rate`/`staff_student_cost_ratio` → `student_proficiency`.
- North Star → North Star links are recorded as `correlatedMetrics`; check that none is a real driver edge.
- `relationships.csv` lists each parent/child edge twice (declared on both sides).
