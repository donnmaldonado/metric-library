# Metric Catalog

483 metrics.

## North Star (23)

<a id="clv"></a>
### Customer LTV — `clv`

Total expected revenue from a customer over their lifetime

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/clv.yml) · [sql](dbt/analyses/metrics/customer/clv.sql)
- **Numerator:** Avg purchase value × frequency × lifespan
- **Dimensions:** date, customer_segment, cohort
- **Data sources:** orders, customers
- **Children:** [`aov`](#aov), [`purchase_frequency`](#purchase_frequency), [`customer_churn_rate`](#customer_churn_rate), [`cohort_ltv_12m`](#cohort_ltv_12m), [`cohort_ltv_24m`](#cohort_ltv_24m), [`cross_sell_rate`](#cross_sell_rate), [`customer_retention_rate`](#customer_retention_rate), [`refund_rate`](#refund_rate)
- **Correlated:** [`cac`](#cac), [`nrr`](#nrr), [`cohort_ltv_12m`](#cohort_ltv_12m), [`aov`](#aov)

<a id="customer_ltv"></a>
### Customer LTV — `customer_ltv`

Predicted or realized revenue from a customer across their lifetime.

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/customer_ltv.yml) · [sql](dbt/analyses/metrics/customer/customer_ltv.sql)
- **Numerator:** SUM(lifetime revenue per customer)
- **Dimensions:** customer_id, segment, cohort_month, acquisition_channel
- **Data sources:** Transactional DB, CRM, Data warehouse
- **Children:** [`arpu`](#arpu), [`churn_rate`](#churn_rate)
- **Correlated:** [`ltv_cac`](#ltv_cac), [`net_revenue_retention`](#net_revenue_retention), [`arpu`](#arpu)

<a id="district_proficiency_rate"></a>
### District Proficiency % — `district_proficiency_rate`

Percentage of students at or above grade-level proficiency across all tested subjects

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/district_proficiency_rate.yml) · [sql](dbt/analyses/metrics/edu/district_proficiency_rate.sql)
- **Numerator:** Proficient students
- **Denominator:** All tested students
- **Dimensions:** school_year, grade, subgroup
- **Data sources:** assessment_data
- **Children:** [`ela_proficiency_rate`](#ela_proficiency_rate), [`math_proficiency_rate`](#math_proficiency_rate), [`science_proficiency_rate`](#science_proficiency_rate)
- **Correlated:** [`four_year_grad_rate`](#four_year_grad_rate), [`sgp`](#sgp), [`ap_pass_rate`](#ap_pass_rate)

<a id="student_proficiency"></a>
### Student Proficiency Rate — `student_proficiency`

% of tested students scoring at or above proficiency on state assessments.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/student_proficiency.yml) · [sql](dbt/analyses/metrics/edu/student_proficiency.sql)
- **Numerator:** Students scoring ≥ Level 3
- **Denominator:** Total students tested
- **Dimensions:** school_id, subject, grade_level, subgroup, academic_year
- **Data sources:** State assessment platform, SIS (PowerSchool / Infinite Campus)
- **Children:** [`attendance_rate`](#attendance_rate), [`chronic_absenteeism`](#chronic_absenteeism), [`instructional_minutes`](#instructional_minutes), [`avg_teacher_experience`](#avg_teacher_experience), [`ell_pct`](#ell_pct), [`ell_proficiency_growth`](#ell_proficiency_growth), [`frl_pct`](#frl_pct), [`graduation_rate`](#graduation_rate), [`iep_goal_mastery_rate`](#iep_goal_mastery_rate), [`iep_pct`](#iep_pct), [`on_time_lesson_delivery`](#on_time_lesson_delivery), [`per_pupil_expenditure`](#per_pupil_expenditure), [`school_climate_score`](#school_climate_score), [`school_culture_score`](#school_culture_score), [`stg_student_assessment_row`](#stg_student_assessment_row), [`student_growth_percentile`](#student_growth_percentile), [`teacher_retention_rate`](#teacher_retention_rate)
- **Correlated:** [`graduation_rate`](#graduation_rate), [`college_enrollment`](#college_enrollment), [`absenteeism_by_subgroup`](#absenteeism_by_subgroup), [`advanced_course_enrollment_rate`](#advanced_course_enrollment_rate), [`attendance_rate`](#attendance_rate), [`average_daily_attendance`](#average_daily_attendance), [`chronic_absenteeism`](#chronic_absenteeism), [`cost_per_outcome`](#cost_per_outcome), [`ell_proficiency_growth`](#ell_proficiency_growth), [`iep_goal_mastery_rate`](#iep_goal_mastery_rate), [`student_growth_percentile`](#student_growth_percentile), [`teacher_retention_rate`](#teacher_retention_rate), [`teacher_student_ratio`](#teacher_student_ratio)

<a id="college_enrollment_rate"></a>
### College Enrollment % — `college_enrollment_rate`

Percentage of graduates enrolled in a 2- or 4-year college within 16 months

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/college_enrollment_rate.yml) · [sql](dbt/analyses/metrics/finance/college_enrollment_rate.sql)
- **Numerator:** Graduates enrolling in college
- **Denominator:** Graduates
- **Dimensions:** school_year, school
- **Data sources:** transcripts, nscc
- **Children:** [`fafsa_completion_rate`](#fafsa_completion_rate), [`ap_participation_rate`](#ap_participation_rate), [`ap_pass_rate`](#ap_pass_rate), [`college_enrollment`](#college_enrollment)
- **Correlated:** [`four_year_grad_rate`](#four_year_grad_rate), [`ap_pass_rate`](#ap_pass_rate), [`ap_participation_rate`](#ap_participation_rate)

<a id="cost_per_outcome"></a>
### Cost per Outcome — `cost_per_outcome`

Per-pupil expenditure divided by % of students meeting proficiency — efficiency of investment.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cost_per_outcome.yml) · [sql](dbt/analyses/metrics/finance/cost_per_outcome.sql)
- **Numerator:** Per-Pupil Expenditure
- **Denominator:** Proficiency Rate
- **Dimensions:** school_id, period
- **Data sources:** Finance, SIS, Assessment platform
- **Children:** [`per_pupil_expenditure`](#per_pupil_expenditure)
- **Formula inputs:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`per_pupil_expenditure`](#per_pupil_expenditure), [`student_proficiency`](#student_proficiency)

<a id="ebitda"></a>
### EBITDA — `ebitda`

Earnings before interest, taxes, depreciation & amortization.

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/ebitda.yml) · [sql](dbt/analyses/metrics/finance/ebitda.sql)
- **Numerator:** EBIT + Depreciation + Amortization
- **Dimensions:** date, segment
- **Data sources:** income_statement
- **Children:** [`gross_profit`](#gross_profit), [`opex`](#opex), [`da`](#da), [`bad_debt_rate`](#bad_debt_rate), [`cogs`](#cogs), [`ebit`](#ebit), [`ebitda_bridge_price`](#ebitda_bridge_price), [`ebitda_bridge_volume`](#ebitda_bridge_volume), [`ebitda_margin`](#ebitda_margin), [`forecast_accuracy`](#forecast_accuracy), [`gross_margin`](#gross_margin), [`gross_margin_pct`](#gross_margin_pct), [`revenue`](#revenue), [`revenue_per_employee`](#revenue_per_employee)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`free_cash_flow`](#free_cash_flow), [`net_income`](#net_income), [`capex`](#capex), [`effective_tax_rate`](#effective_tax_rate), [`enterprise_value`](#enterprise_value), [`net_revenue_retention`](#net_revenue_retention), [`operating_cash_flow`](#operating_cash_flow), [`return_on_equity`](#return_on_equity), [`total_revenue`](#total_revenue)

<a id="enterprise_value"></a>
### Enterprise Value — `enterprise_value`

Market cap plus net debt — basis for EV/EBITDA multiples

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/enterprise_value.yml) · [sql](dbt/analyses/metrics/finance/enterprise_value.sql)
- **Numerator:** Market cap + net debt
- **Dimensions:** date
- **Data sources:** cap_table, balance_sheet
- **Children:** [`net_debt`](#net_debt), [`customer_concentration_risk`](#customer_concentration_risk), [`ev_ebitda`](#ev_ebitda), [`roic`](#roic)
- **Correlated:** [`ev_ebitda`](#ev_ebitda), [`rule_of_40`](#rule_of_40), [`ebitda`](#ebitda)

<a id="free_cash_flow"></a>
### Free Cash Flow — `free_cash_flow`

Operating cash flow minus capital expenditures.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/free_cash_flow.yml) · [sql](dbt/analyses/metrics/finance/free_cash_flow.sql)
- **Numerator:** Operating Cash Flow − CapEx
- **Dimensions:** date
- **Data sources:** cash_flow_statement
- **Children:** [`operating_cash_flow`](#operating_cash_flow), [`capex`](#capex), [`capex_pct_revenue`](#capex_pct_revenue), [`runway_months`](#runway_months), [`working_capital`](#working_capital)
- **Correlated:** [`burn_rate`](#burn_rate), [`ebitda`](#ebitda), [`net_income`](#net_income), [`billings`](#billings), [`capex_pct_revenue`](#capex_pct_revenue), [`da`](#da), [`debt_ebitda`](#debt_ebitda), [`effective_tax_rate`](#effective_tax_rate), [`interest_coverage_ratio`](#interest_coverage_ratio), [`operating_cash_flow`](#operating_cash_flow), [`runway_months`](#runway_months), [`working_capital`](#working_capital)

<a id="marketing_roi"></a>
### Marketing ROI — `marketing_roi`

Return on total marketing investment — revenue driven per dollar spent.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/marketing_roi.yml) · [sql](dbt/analyses/metrics/finance/marketing_roi.sql)
- **Numerator:** Pipeline generated
- **Denominator:** Marketing spend
- **Dimensions:** date, campaign
- **Data sources:** ad_platforms, crm
- **Children:** [`stg_ad_spend`](#stg_ad_spend), [`ltv_cac`](#ltv_cac), [`marketing_influenced_pipeline`](#marketing_influenced_pipeline), [`organic_attribution_pct`](#organic_attribution_pct), [`paid_attribution_pct`](#paid_attribution_pct), [`referral_attribution_pct`](#referral_attribution_pct), [`roas`](#roas), [`share_of_voice`](#share_of_voice)
- **Formula inputs:** [`pipeline_generated`](#pipeline_generated)
- **Correlated:** [`roas`](#roas), [`marketing_cac`](#marketing_cac)

<a id="ops_efficiency_ratio"></a>
### Ops Efficiency — `ops_efficiency_ratio`

Output produced per unit of cost — higher is better

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/ops_efficiency_ratio.yml) · [sql](dbt/analyses/metrics/finance/ops_efficiency_ratio.sql)
- **Numerator:** OpEx
- **Denominator:** Revenue
- **Dimensions:** date
- **Data sources:** finance
- **Children:** [`opex`](#opex), [`budget_variance_pct`](#budget_variance_pct), [`carbon_emissions_per_unit`](#carbon_emissions_per_unit), [`cost_per_mile`](#cost_per_mile), [`support_cost_per_ticket`](#support_cost_per_ticket), [`warehouse_utilization_rate`](#warehouse_utilization_rate)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`gross_margin_pct`](#gross_margin_pct), [`throughput`](#throughput)

<a id="ops_north_star"></a>
### Perfect Order Rate — `ops_north_star`

% of orders that are on time, complete, accurate, and undamaged — the gold standard ops metric.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/ops_north_star.yml) · [sql](dbt/analyses/metrics/finance/ops_north_star.sql)
- **Numerator:** Orders meeting all criteria
- **Denominator:** Total Orders
- **Dimensions:** warehouse_id, carrier, period
- **Data sources:** WMS, TMS, ERP
- **Children:** [`on_time_delivery_rate`](#on_time_delivery_rate), [`fill_rate`](#fill_rate), [`order_accuracy_rate`](#order_accuracy_rate), [`capacity_utilization`](#capacity_utilization), [`capacity_utilization_rate`](#capacity_utilization_rate), [`defect_rate`](#defect_rate), [`order_fulfillment_rate`](#order_fulfillment_rate), [`return_rate`](#return_rate), [`sla_compliance_rate`](#sla_compliance_rate), [`system_uptime`](#system_uptime), [`vendor_scorecard_rating`](#vendor_scorecard_rating)
- **Correlated:** [`csat`](#csat)

<a id="pipeline_generated"></a>
### Pipeline Generated — `pipeline_generated`

Total value of opportunities sourced by marketing

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/pipeline_generated.yml) · [sql](dbt/analyses/metrics/finance/pipeline_generated.sql)
- **Numerator:** Sum of opportunity values created
- **Dimensions:** date, channel
- **Data sources:** crm
- **Children:** [`sql`](#sql), [`avg_deal_size`](#avg_deal_size), [`mql`](#mql)
- **Correlated:** [`bookings`](#bookings), [`mql`](#mql), [`pipeline_coverage`](#pipeline_coverage), [`stg_opportunities_count`](#stg_opportunities_count)

<a id="return_on_equity"></a>
### Return on Equity — `return_on_equity`

Net income as a % of shareholders’ equity — profitability from equity capital.

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/return_on_equity.yml) · [sql](dbt/analyses/metrics/finance/return_on_equity.sql)
- **Numerator:** Net Income
- **Denominator:** Shareholders' Equity
- **Dimensions:** company_id, fiscal_period
- **Data sources:** Income statement, Balance sheet
- **Children:** [`debt_to_equity`](#debt_to_equity), [`interest_coverage`](#interest_coverage), [`leverage_ratio`](#leverage_ratio), [`net_income`](#net_income), [`net_income_margin`](#net_income_margin), [`net_margin`](#net_margin), [`return_on_assets`](#return_on_assets), [`roa`](#roa), [`roe`](#roe)
- **Correlated:** [`return_on_assets`](#return_on_assets), [`debt_ebitda`](#debt_ebitda), [`ebitda`](#ebitda)

<a id="rule_of_40"></a>
### Rule of 40 — `rule_of_40`

Revenue growth rate + EBITDA margin — benchmark for SaaS health. ≥40 = healthy.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/rule_of_40.yml) · [sql](dbt/analyses/metrics/finance/rule_of_40.sql)
- **Numerator:** Revenue Growth % + EBITDA Margin %
- **Dimensions:** company_id, fiscal_period
- **Data sources:** ERP, Billing system
- **Children:** [`ebitda_margin`](#ebitda_margin), [`revenue_growth_rate`](#revenue_growth_rate), [`arr_growth_rate`](#arr_growth_rate), [`magic_number`](#magic_number), [`nrr`](#nrr)
- **Correlated:** [`arr`](#arr), [`net_revenue_retention`](#net_revenue_retention), [`enterprise_value`](#enterprise_value), [`saas_quick_ratio`](#saas_quick_ratio)

<a id="employee_lifetime_value"></a>
### Employee Lifetime Value — `employee_lifetime_value`

Estimated total value an employee contributes over their tenure minus fully-loaded employment cost.

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/employee_lifetime_value.yml) · [sql](dbt/analyses/metrics/hr/employee_lifetime_value.sql)
- **Numerator:** Revenue Contribution over Tenure
- **Denominator:** Fully-Loaded Employment Cost over Tenure
- **Dimensions:** job_level, department, hire_cohort
- **Data sources:** HRIS, Finance
- **Children:** [`headcount_cost`](#headcount_cost), [`revenue_per_employee`](#revenue_per_employee), [`avg_tenure`](#avg_tenure), [`gross_profit_per_employee`](#gross_profit_per_employee), [`workforce_productivity`](#workforce_productivity)
- **Correlated:** [`employee_attrition_rate`](#employee_attrition_rate), [`employee_engagement_score`](#employee_engagement_score)

<a id="headcount"></a>
### Headcount — `headcount`

Total active full-time employees at end of period

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/headcount.yml) · [sql](dbt/analyses/metrics/hr/headcount.sql)
- **Numerator:** Active employees at period end
- **Dimensions:** date, department, location
- **Data sources:** hris
- **Children:** [`stg_employees_count`](#stg_employees_count), [`headcount_by_dept`](#headcount_by_dept), [`diversity_hire_rate`](#diversity_hire_rate), [`headcount_vs_budget`](#headcount_vs_budget), [`new_hires`](#new_hires)
- **Correlated:** [`turnover_rate`](#turnover_rate), [`headcount_vs_budget`](#headcount_vs_budget), [`headcount_by_dept`](#headcount_by_dept), [`stg_employees_count`](#stg_employees_count), [`stg_payroll_total`](#stg_payroll_total), [`total_comp_expense`](#total_comp_expense)

<a id="turnover_rate"></a>
### Turnover Rate — `turnover_rate`

Percentage of employees who left during the period (voluntary + involuntary)

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/turnover_rate.yml) · [sql](dbt/analyses/metrics/hr/turnover_rate.sql)
- **Numerator:** Separations
- **Denominator:** Average headcount
- **Dimensions:** date, department
- **Data sources:** hris
- **Children:** [`separations`](#separations), [`employee_attrition_rate`](#employee_attrition_rate), [`regrettable_attrition`](#regrettable_attrition), [`voluntary_turnover`](#voluntary_turnover)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`regrettable_attrition`](#regrettable_attrition), [`engagement_score`](#engagement_score), [`absenteeism_rate`](#absenteeism_rate), [`headcount`](#headcount), [`stg_employees_count`](#stg_employees_count)

<a id="four_year_grad_rate"></a>
### 4-Year Grad Rate — `four_year_grad_rate`

Percentage of students graduating within 4 years of entering 9th grade

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/four_year_grad_rate.yml) · [sql](dbt/analyses/metrics/marketing/four_year_grad_rate.sql)
- **Numerator:** On-time graduates
- **Denominator:** Entering 9th grade cohort
- **Dimensions:** school_year, school, subgroup
- **Data sources:** enrollment, transcripts
- **Children:** [`student_attendance_rate`](#student_attendance_rate), [`dropout_rate`](#dropout_rate)
- **Correlated:** [`college_enrollment_rate`](#college_enrollment_rate), [`dropout_rate`](#dropout_rate), [`district_proficiency_rate`](#district_proficiency_rate)

<a id="otd_rate"></a>
### On-Time Delivery % — `otd_rate`

Percentage of orders or deliverables completed by the committed date

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/otd_rate.yml) · [sql](dbt/analyses/metrics/ops/otd_rate.sql)
- **Numerator:** On-time deliveries
- **Denominator:** Total deliveries
- **Dimensions:** date, region
- **Data sources:** orders, logistics
- **Children:** [`stg_orders_count`](#stg_orders_count), [`cycle_time`](#cycle_time), [`lead_time`](#lead_time)
- **Correlated:** [`order_fulfillment_rate`](#order_fulfillment_rate), [`cycle_time`](#cycle_time), [`inventory_turnover`](#inventory_turnover), [`lead_time`](#lead_time)

<a id="total_revenue"></a>
### Total Revenue — `total_revenue`

Total top-line revenue across all streams

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/total_revenue.yml) · [sql](dbt/analyses/metrics/pe/total_revenue.sql)
- **Numerator:** Sum of all recognized revenue
- **Dimensions:** date, region, product_line, channel
- **Data sources:** orders, invoices
- **Children:** [`net_revenue`](#net_revenue), [`gross_revenue`](#gross_revenue), [`services_revenue`](#services_revenue), [`license_revenue`](#license_revenue), [`subscription_revenue`](#subscription_revenue), [`implementation_revenue`](#implementation_revenue), [`partner_revenue`](#partner_revenue), [`partner_revenue_pct`](#partner_revenue_pct), [`rev_from_existing`](#rev_from_existing), [`rev_from_new_customers`](#rev_from_new_customers), [`revenue_by_channel`](#revenue_by_channel), [`revenue_by_product`](#revenue_by_product), [`revenue_by_region`](#revenue_by_region), [`revenue_ytd`](#revenue_ytd)
- **Correlated:** [`revenue_growth_rate`](#revenue_growth_rate), [`revenue_vs_py`](#revenue_vs_py), [`arr`](#arr), [`ebitda`](#ebitda), [`prior_year_revenue`](#prior_year_revenue), [`q1_revenue`](#q1_revenue), [`q4_revenue`](#q4_revenue), [`revenue_by_channel`](#revenue_by_channel), [`revenue_by_product`](#revenue_by_product), [`revenue_by_region`](#revenue_by_region), [`stg_orders_count`](#stg_orders_count)

<a id="cx_csat"></a>
### CX CSAT — `cx_csat`

Satisfaction score from customer service interactions

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/cx_csat.yml) · [sql](dbt/analyses/metrics/product/cx_csat.sql)
- **Numerator:** Satisfied customers
- **Denominator:** Survey responses
- **Dimensions:** date, product, channel
- **Data sources:** surveys
- **Children:** [`stg_csat_response_row`](#stg_csat_response_row), [`complaint_resolution_rate`](#complaint_resolution_rate), [`complaints_count`](#complaints_count)
- **Correlated:** [`nps`](#nps), [`ces`](#ces), [`csat`](#csat)

<a id="nps"></a>
### NPS — `nps`

Net Promoter Score — % Promoters minus % Detractors on 0–10 likelihood-to-recommend scale.

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/nps.yml) · [sql](dbt/analyses/metrics/product/nps.sql)
- **Numerator:** % Promoters (9-10) - % Detractors (0-6)
- **Dimensions:** segment, product, survey_period
- **Data sources:** NPS survey platform (Delighted / Qualtrics)
- **Children:** [`stg_nps_response_row`](#stg_nps_response_row), [`app_store_rating`](#app_store_rating), [`feature_request_volume`](#feature_request_volume), [`review_rating`](#review_rating), [`survey_response_rate`](#survey_response_rate), [`testimonials_count`](#testimonials_count)
- **Correlated:** [`customer_health_score`](#customer_health_score), [`churn_rate`](#churn_rate), [`app_store_rating`](#app_store_rating), [`ces`](#ces), [`csat`](#csat), [`cx_csat`](#cx_csat), [`enps`](#enps), [`feature_adoption_rate`](#feature_adoption_rate), [`feature_request_volume`](#feature_request_volume), [`review_rating`](#review_rating), [`survey_response_rate`](#survey_response_rate), [`testimonials_count`](#testimonials_count)

## KPI (308)

<a id="account_health_score"></a>
### Account Health — `account_health_score`

Composite score combining product usage, support tickets, NPS, and contract size

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/account_health_score.yml) · [sql](dbt/analyses/metrics/customer/account_health_score.sql)
- **Numerator:** Composite score (usage + NPS + support)
- **Dimensions:** date, account
- **Data sources:** crm, events, surveys
- **Parents:** [`at_risk_accounts`](#at_risk_accounts)
- **Children:** [`dau`](#dau), [`renewal_rate`](#renewal_rate)
- **Formula inputs:** [`nps`](#nps)
- **Correlated:** [`at_risk_accounts`](#at_risk_accounts), [`nrr`](#nrr), [`qbr_completion_rate`](#qbr_completion_rate)

<a id="aov"></a>
### AOV — `aov`

Average value per transaction

- **Vertical:** Customer & Revenue · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/customer/aov.yml) · [sql](dbt/analyses/metrics/customer/aov.sql)
- **Numerator:** Total order revenue
- **Denominator:** Number of orders
- **Dimensions:** date, customer_segment, channel
- **Data sources:** orders
- **Parents:** [`clv`](#clv), [`cohort_ltv_12m`](#cohort_ltv_12m)
- **Children:** [`stg_purchases_count`](#stg_purchases_count), [`stg_order_amount_sum`](#stg_order_amount_sum)
- **Correlated:** [`purchase_frequency`](#purchase_frequency), [`clv`](#clv), [`cross_sell_rate`](#cross_sell_rate), [`discount_rate`](#discount_rate), [`iap_revenue`](#iap_revenue), [`marketplace_buyers`](#marketplace_buyers), [`stg_order_amount_sum`](#stg_order_amount_sum), [`stg_orders_count`](#stg_orders_count), [`stg_products_active`](#stg_products_active), [`stg_purchases_count`](#stg_purchases_count)

<a id="cac"></a>
### CAC — `cac`

Customer Acquisition Cost — total sales & marketing spend per new customer.

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/cac.yml) · [sql](dbt/analyses/metrics/customer/cac.sql)
- **Numerator:** Total sales & marketing spend
- **Denominator:** New customers
- **Dimensions:** date, channel
- **Data sources:** general_ledger, customers
- **Parents:** [`ltv_cac`](#ltv_cac), [`cac_payback`](#cac_payback), [`payback_period`](#payback_period), [`payback_ratio`](#payback_ratio)
- **Children:** [`marketing_cac`](#marketing_cac), [`monthly_new_customers`](#monthly_new_customers), [`cost_per_mql`](#cost_per_mql), [`cost_per_sql`](#cost_per_sql), [`customers_by_channel`](#customers_by_channel), [`marketing_spend`](#marketing_spend), [`mql_count`](#mql_count), [`sales_spend`](#sales_spend)
- **Correlated:** [`cac_payback`](#cac_payback), [`magic_number`](#magic_number), [`ltv_cac`](#ltv_cac), [`arr_per_rep`](#arr_per_rep), [`clv`](#clv), [`cost_per_sql`](#cost_per_sql), [`customers_by_channel`](#customers_by_channel), [`marketing_cac`](#marketing_cac), [`monthly_new_customers`](#monthly_new_customers), [`mql_to_sql_rate`](#mql_to_sql_rate), [`net_new_customers`](#net_new_customers), [`rev_from_new_customers`](#rev_from_new_customers), [`revenue_by_channel`](#revenue_by_channel), [`roas`](#roas), [`sales_cycle_length`](#sales_cycle_length), [`sales_spend`](#sales_spend), [`sm_spend`](#sm_spend), [`time_to_fill`](#time_to_fill), [`win_rate`](#win_rate)

<a id="cac_payback"></a>
### CAC Payback (mo) — `cac_payback`

Months to recover customer acquisition cost from gross margin

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/cac_payback.yml) · [sql](dbt/analyses/metrics/customer/cac_payback.sql)
- **Numerator:** CAC
- **Denominator:** MRR × Gross Margin %
- **Dimensions:** date, channel
- **Data sources:** subscriptions, general_ledger
- **Parents:** [`ltv_cac`](#ltv_cac)
- **Children:** [`cac`](#cac), [`gross_margin_pct`](#gross_margin_pct), [`arpu`](#arpu), [`sm_spend`](#sm_spend)
- **Correlated:** [`magic_number`](#magic_number), [`ltv_cac`](#ltv_cac), [`avg_sales_cycle`](#avg_sales_cycle), [`cac`](#cac), [`payback_ratio`](#payback_ratio)

<a id="ces"></a>
### CES — `ces`

How easy it was for customers to resolve an issue — lower effort = better.

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/ces.yml) · [sql](dbt/analyses/metrics/customer/ces.sql)
- **Numerator:** AVG(effort_score)
- **Dimensions:** channel, interaction_type, period
- **Data sources:** Survey platform, Support ticket system
- **Parents:** [`customer_health_score`](#customer_health_score)
- **Correlated:** [`csat`](#csat), [`nps`](#nps), [`cx_csat`](#cx_csat), [`first_response_time`](#first_response_time), [`ticket_resolution_rate`](#ticket_resolution_rate)

<a id="cohort_ltv_12m"></a>
### 12-Month Cohort LTV — `cohort_ltv_12m`

Average cumulative revenue per customer 12 months after acquisition

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/cohort_ltv_12m.yml) · [sql](dbt/analyses/metrics/customer/cohort_ltv_12m.sql)
- **Numerator:** Revenue per cohort member over 12 months
- **Dimensions:** date, cohort, channel
- **Data sources:** orders, customers
- **Parents:** [`clv`](#clv), [`cohort_ltv_24m`](#cohort_ltv_24m)
- **Children:** [`aov`](#aov), [`purchase_frequency`](#purchase_frequency)
- **Correlated:** [`cohort_ltv_24m`](#cohort_ltv_24m), [`d30_retention`](#d30_retention), [`clv`](#clv)

<a id="cohort_ltv_24m"></a>
### 24-Month Cohort LTV — `cohort_ltv_24m`

Average cumulative revenue per customer 24 months after acquisition

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/cohort_ltv_24m.yml) · [sql](dbt/analyses/metrics/customer/cohort_ltv_24m.sql)
- **Numerator:** Revenue per cohort member over 24 months
- **Dimensions:** date, cohort
- **Data sources:** orders, customers
- **Parents:** [`clv`](#clv)
- **Children:** [`cohort_ltv_12m`](#cohort_ltv_12m)
- **Correlated:** [`cohort_ltv_12m`](#cohort_ltv_12m), [`nrr`](#nrr)

<a id="customer_health_score"></a>
### Customer Health Score — `customer_health_score`

Composite score predicting retention, expansion, and churn risk.

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/customer_health_score.yml) · [sql](dbt/analyses/metrics/customer/customer_health_score.sql)
- **Numerator:** Weighted signal composite
- **Dimensions:** customer_id, segment, plan_tier, cohort_month
- **Data sources:** Product analytics (Amplitude/Mixpanel), CRM, Support system
- **Parents:** [`churn_rate`](#churn_rate)
- **Children:** [`ces`](#ces), [`churn_prediction_score`](#churn_prediction_score), [`csat`](#csat), [`customer_onboarding_time`](#customer_onboarding_time), [`dau_mau_ratio`](#dau_mau_ratio), [`feature_adoption_rate`](#feature_adoption_rate)
- **Correlated:** [`net_revenue_retention`](#net_revenue_retention), [`arpu`](#arpu), [`churn_prediction_score`](#churn_prediction_score), [`churn_rate`](#churn_rate), [`logo_churn_rate`](#logo_churn_rate), [`nps`](#nps)

<a id="customer_onboarding_time"></a>
### Customer Onboarding Time — `customer_onboarding_time`

Average days from contract signed to customer fully live and using the product.

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/customer_onboarding_time.yml) · [sql](dbt/analyses/metrics/customer/customer_onboarding_time.sql)
- **Numerator:** SUM(go_live_date - contract_date)
- **Denominator:** COUNT(onboarded customers)
- **Dimensions:** segment, product, cs_rep_id, period
- **Data sources:** CRM, Product analytics
- **Parents:** [`customer_health_score`](#customer_health_score)
- **Correlated:** [`time_to_value`](#time_to_value), [`churn_rate`](#churn_rate)

<a id="ltv_cac"></a>
### LTV : CAC — `ltv_cac`

Ratio of customer lifetime value to acquisition cost — PE efficiency lens.

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/ltv_cac.yml) · [sql](dbt/analyses/metrics/customer/ltv_cac.sql)
- **Numerator:** Customer LTV
- **Denominator:** CAC
- **Dimensions:** date, channel
- **Data sources:** orders, customers, general_ledger
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Children:** [`cac`](#cac), [`cac_payback`](#cac_payback), [`payback_period`](#payback_period), [`payback_ratio`](#payback_ratio)
- **Formula inputs:** [`clv`](#clv)
- **Correlated:** [`cac_payback`](#cac_payback), [`magic_number`](#magic_number), [`cac`](#cac), [`churn_rate`](#churn_rate), [`customer_ltv`](#customer_ltv), [`net_revenue_retention`](#net_revenue_retention), [`payback_ratio`](#payback_ratio), [`roas`](#roas)

<a id="marketing_cac"></a>
### Marketing CAC — `marketing_cac`

Total marketing spend divided by new customers acquired

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/marketing_cac.yml) · [sql](dbt/analyses/metrics/customer/marketing_cac.sql)
- **Numerator:** Total marketing spend
- **Denominator:** New customers acquired
- **Dimensions:** date, channel
- **Data sources:** ad_platforms, crm
- **Parents:** [`cac`](#cac)
- **Children:** [`stg_ad_spend`](#stg_ad_spend), [`net_new_customers`](#net_new_customers)
- **Correlated:** [`cac`](#cac), [`cost_per_mql`](#cost_per_mql), [`marketing_roi`](#marketing_roi), [`sm_spend`](#sm_spend), [`stg_ad_spend`](#stg_ad_spend)

<a id="onboarding_time"></a>
### Onboarding Time (days) — `onboarding_time`

Average days from contract sign to customer go-live

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/onboarding_time.yml) · [sql](dbt/analyses/metrics/customer/onboarding_time.sql)
- **Numerator:** Days from contract to go-live
- **Dimensions:** date, customer_segment
- **Data sources:** customers, events
- **Parents:** [`time_to_value`](#time_to_value)
- **Correlated:** [`time_to_value`](#time_to_value), [`activation_rate`](#activation_rate)

<a id="process_automation_rate"></a>
### Automation Rate — `process_automation_rate`

Percentage of defined processes that run without manual intervention

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/process_automation_rate.yml) · [sql](dbt/analyses/metrics/customer/process_automation_rate.sql)
- **Numerator:** Automated processes
- **Denominator:** Total defined processes
- **Dimensions:** date
- **Data sources:** process_catalog
- **Parents:** [`cycle_time`](#cycle_time)
- **Correlated:** [`cycle_time`](#cycle_time), [`throughput`](#throughput)

<a id="product_return_rate"></a>
### Product Return % — `product_return_rate`

Percentage of sold units returned by customers

- **Vertical:** Customer & Revenue · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/customer/product_return_rate.yml) · [sql](dbt/analyses/metrics/customer/product_return_rate.sql)
- **Numerator:** Returned units
- **Denominator:** Sold units
- **Dimensions:** date, product
- **Data sources:** returns
- **Parents:** [`return_rate`](#return_rate)
- **Correlated:** [`refund_rate`](#refund_rate), [`csat`](#csat), [`stg_refunds_count`](#stg_refunds_count)

<a id="purchase_frequency"></a>
### Purchase Frequency — `purchase_frequency`

Average number of orders per customer per year

- **Vertical:** Customer & Revenue · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/customer/purchase_frequency.yml) · [sql](dbt/analyses/metrics/customer/purchase_frequency.sql)
- **Numerator:** Total orders
- **Denominator:** Unique customers
- **Dimensions:** date, customer_segment
- **Data sources:** orders
- **Parents:** [`clv`](#clv), [`cohort_ltv_12m`](#cohort_ltv_12m)
- **Children:** [`stg_purchases_count`](#stg_purchases_count), [`repeat_purchase_rate`](#repeat_purchase_rate)
- **Correlated:** [`aov`](#aov), [`repeat_purchase_rate`](#repeat_purchase_rate), [`stg_purchases_count`](#stg_purchases_count)

<a id="refund_rate"></a>
### Refund Rate — `refund_rate`

Percentage of transactions that were refunded

- **Vertical:** Customer & Revenue · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/customer/refund_rate.yml) · [sql](dbt/analyses/metrics/customer/refund_rate.sql)
- **Numerator:** Refunds processed
- **Denominator:** Total orders
- **Dimensions:** date, product
- **Data sources:** orders, returns
- **Parents:** [`clv`](#clv)
- **Children:** [`stg_refunds_count`](#stg_refunds_count), [`stg_purchases_count`](#stg_purchases_count), [`stg_refund_amount`](#stg_refund_amount)
- **Correlated:** [`product_return_rate`](#product_return_rate), [`csat`](#csat), [`net_revenue`](#net_revenue), [`stg_refund_amount`](#stg_refund_amount), [`stg_refunds_count`](#stg_refunds_count)

<a id="renewal_rate"></a>
### Renewal Rate — `renewal_rate`

% of up-for-renewal contracts that successfully renew.

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/renewal_rate.yml) · [sql](dbt/analyses/metrics/customer/renewal_rate.sql)
- **Numerator:** Contracts Renewed
- **Denominator:** Contracts Up for Renewal
- **Dimensions:** segment, plan_tier, cs_rep_id, period
- **Data sources:** CRM, Billing system
- **Parents:** [`net_revenue_retention`](#net_revenue_retention), [`account_health_score`](#account_health_score)
- **Children:** [`stg_subscription_row`](#stg_subscription_row), [`qbr_completion_rate`](#qbr_completion_rate)
- **Correlated:** [`nrr_monthly`](#nrr_monthly), [`churn_rate`](#churn_rate), [`at_risk_accounts`](#at_risk_accounts), [`customer_churn_rate`](#customer_churn_rate), [`customer_retention_rate`](#customer_retention_rate), [`qbr_completion_rate`](#qbr_completion_rate)

<a id="repeat_purchase_rate"></a>
### Repeat Purchase % — `repeat_purchase_rate`

Percentage of customers who made more than one purchase

- **Vertical:** Customer & Revenue · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/customer/repeat_purchase_rate.yml) · [sql](dbt/analyses/metrics/customer/repeat_purchase_rate.sql)
- **Numerator:** Customers with 2+ orders
- **Denominator:** Total customers
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`purchase_frequency`](#purchase_frequency)
- **Children:** [`stg_purchases_count`](#stg_purchases_count), [`stg_customer_count`](#stg_customer_count)
- **Correlated:** [`purchase_frequency`](#purchase_frequency), [`customer_retention_rate`](#customer_retention_rate), [`stg_purchases_count`](#stg_purchases_count)

<a id="advanced_course_enrollment_rate"></a>
### Advanced Course Enrollment — `advanced_course_enrollment_rate`

% of students enrolled in AP, IB, or dual-enrollment courses.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/advanced_course_enrollment_rate.yml) · [sql](dbt/analyses/metrics/edu/advanced_course_enrollment_rate.sql)
- **Numerator:** Students in Advanced Courses
- **Denominator:** Total Enrollment
- **Dimensions:** school_id, grade_level, demographic_group, period
- **Data sources:** SIS
- **Parents:** [`graduation_rate`](#graduation_rate)
- **Children:** [`stg_enrollment_row`](#stg_enrollment_row)
- **Correlated:** [`college_enrollment`](#college_enrollment), [`student_proficiency`](#student_proficiency)

<a id="cross_sell_rate"></a>
### Cross-Sell Rate — `cross_sell_rate`

Percentage of customers who purchased products from more than one category

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/cross_sell_rate.yml) · [sql](dbt/analyses/metrics/edu/cross_sell_rate.sql)
- **Numerator:** Customers buying across categories
- **Denominator:** Total customers
- **Dimensions:** date, product_category
- **Data sources:** orders
- **Parents:** [`clv`](#clv)
- **Children:** [`stg_purchases_count`](#stg_purchases_count), [`stg_products_active`](#stg_products_active)
- **Correlated:** [`upsell_rate`](#upsell_rate), [`aov`](#aov), [`stg_products_active`](#stg_products_active)

<a id="dropout_rate"></a>
### Dropout Rate — `dropout_rate`

Percentage of students who left school without graduating or transferring

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/dropout_rate.yml) · [sql](dbt/analyses/metrics/edu/dropout_rate.sql)
- **Numerator:** Dropouts in cohort
- **Denominator:** Beginning enrollment
- **Dimensions:** school_year, school, subgroup
- **Data sources:** enrollment, transcripts
- **Parents:** [`four_year_grad_rate`](#four_year_grad_rate)
- **Children:** [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`suspension_rate`](#suspension_rate)
- **Correlated:** [`four_year_grad_rate`](#four_year_grad_rate), [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`course_completion_rate`](#course_completion_rate), [`expulsion_rate`](#expulsion_rate)

<a id="ela_proficiency_rate"></a>
### ELA Proficiency % — `ela_proficiency_rate`

Percentage of students scoring proficient or advanced on ELA state assessments

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/ela_proficiency_rate.yml) · [sql](dbt/analyses/metrics/edu/ela_proficiency_rate.sql)
- **Numerator:** Proficient in ELA
- **Denominator:** Enrolled students tested
- **Dimensions:** school_year, grade, school
- **Data sources:** assessment_data
- **Parents:** [`district_proficiency_rate`](#district_proficiency_rate)
- **Children:** [`grade3_reading`](#grade3_reading), [`sgp`](#sgp), [`student_attendance_rate`](#student_attendance_rate)
- **Correlated:** [`math_proficiency_rate`](#math_proficiency_rate), [`student_attendance_rate`](#student_attendance_rate), [`avg_teacher_experience`](#avg_teacher_experience), [`course_completion_rate`](#course_completion_rate), [`ell_pct`](#ell_pct), [`grade3_reading`](#grade3_reading), [`iep_pct`](#iep_pct), [`instructional_spend_ratio`](#instructional_spend_ratio)

<a id="ell_proficiency_growth"></a>
### ELL Proficiency Growth — `ell_proficiency_growth`

% of English Language Learners who advance at least one proficiency level annually.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/ell_proficiency_growth.yml) · [sql](dbt/analyses/metrics/edu/ell_proficiency_growth.sql)
- **Numerator:** ELLs advancing one or more levels
- **Denominator:** Total ELL Students
- **Dimensions:** school_id, grade_level, home_language, period
- **Data sources:** SIS, ELL assessment system
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Children:** [`stg_student_assessment_row`](#stg_student_assessment_row)
- **Correlated:** [`student_proficiency`](#student_proficiency), [`attendance_rate`](#attendance_rate)

<a id="fafsa_completion_rate"></a>
### FAFSA Completion Rate — `fafsa_completion_rate`

% of 12th graders who complete the FAFSA — college access predictor.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/fafsa_completion_rate.yml) · [sql](dbt/analyses/metrics/edu/fafsa_completion_rate.sql)
- **Numerator:** Seniors who completed FAFSA
- **Denominator:** Total 12th Grade Enrollment
- **Dimensions:** school_id, demographic_group, period
- **Data sources:** SIS, College guidance system
- **Parents:** [`college_enrollment`](#college_enrollment), [`college_enrollment_rate`](#college_enrollment_rate)
- **Correlated:** [`college_enrollment`](#college_enrollment), [`graduation_rate`](#graduation_rate)

<a id="grade3_reading"></a>
### Gr3 Reading % — `grade3_reading`

Percentage of 3rd graders reading at or above grade level

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/grade3_reading.yml) · [sql](dbt/analyses/metrics/edu/grade3_reading.sql)
- **Numerator:** Grade 3 reading proficient
- **Denominator:** Grade 3 enrolled
- **Dimensions:** school_year, school
- **Data sources:** assessment_data
- **Parents:** [`ela_proficiency_rate`](#ela_proficiency_rate)
- **Children:** [`kinder_readiness`](#kinder_readiness)
- **Correlated:** [`ela_proficiency_rate`](#ela_proficiency_rate), [`student_attendance_rate`](#student_attendance_rate), [`kinder_readiness`](#kinder_readiness)

<a id="iep_goal_mastery_rate"></a>
### IEP Goal Mastery Rate — `iep_goal_mastery_rate`

% of IEP goals marked as mastered by end of evaluation period.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/iep_goal_mastery_rate.yml) · [sql](dbt/analyses/metrics/edu/iep_goal_mastery_rate.sql)
- **Numerator:** Mastered IEP Goals
- **Denominator:** Total IEP Goals
- **Dimensions:** school_id, disability_category, grade_level, period
- **Data sources:** Special education management system
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`student_proficiency`](#student_proficiency), [`attendance_rate`](#attendance_rate)

<a id="kinder_readiness"></a>
### K-Readiness % — `kinder_readiness`

Percentage of entering kindergarteners scoring ready on standardized screening

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/kinder_readiness.yml) · [sql](dbt/analyses/metrics/edu/kinder_readiness.sql)
- **Numerator:** Kindergarteners testing ready
- **Denominator:** Total kindergarteners
- **Dimensions:** school_year, school
- **Data sources:** assessment_data
- **Parents:** [`grade3_reading`](#grade3_reading)
- **Correlated:** [`grade3_reading`](#grade3_reading), [`student_attendance_rate`](#student_attendance_rate)

<a id="math_proficiency_rate"></a>
### Math Proficiency % — `math_proficiency_rate`

Percentage of students scoring proficient or advanced on math state assessments

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/math_proficiency_rate.yml) · [sql](dbt/analyses/metrics/edu/math_proficiency_rate.sql)
- **Numerator:** Proficient in math
- **Denominator:** Enrolled students tested
- **Dimensions:** school_year, grade, school
- **Data sources:** assessment_data
- **Parents:** [`district_proficiency_rate`](#district_proficiency_rate)
- **Children:** [`sgp`](#sgp)
- **Correlated:** [`ela_proficiency_rate`](#ela_proficiency_rate), [`student_attendance_rate`](#student_attendance_rate)

<a id="school_climate_score"></a>
### Climate Score — `school_climate_score`

Average score from student, staff, and family school climate surveys

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/school_climate_score.yml) · [sql](dbt/analyses/metrics/edu/school_climate_score.sql)
- **Numerator:** Composite climate survey score (0–100)
- **Dimensions:** school_year, school
- **Data sources:** surveys
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Children:** [`extracurricular_rate`](#extracurricular_rate), [`family_engagement_rate`](#family_engagement_rate)
- **Correlated:** [`teacher_retention_rate`](#teacher_retention_rate), [`suspension_rate`](#suspension_rate), [`student_attendance_rate`](#student_attendance_rate), [`extracurricular_rate`](#extracurricular_rate), [`family_engagement_rate`](#family_engagement_rate)

<a id="school_culture_score"></a>
### School Culture Score — `school_culture_score`

Composite score from student/family/staff climate surveys.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/school_culture_score.yml) · [sql](dbt/analyses/metrics/edu/school_culture_score.sql)
- **Numerator:** Weighted average of climate survey dimensions
- **Dimensions:** school_id, respondent_type, survey_cycle
- **Data sources:** Climate survey platform
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Children:** [`stg_survey_response_row`](#stg_survey_response_row)
- **Correlated:** [`employee_engagement_score`](#employee_engagement_score), [`attendance_rate`](#attendance_rate)

<a id="science_proficiency_rate"></a>
### Science Proficiency % — `science_proficiency_rate`

Percentage of students scoring proficient on science state assessments

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/science_proficiency_rate.yml) · [sql](dbt/analyses/metrics/edu/science_proficiency_rate.sql)
- **Parents:** [`district_proficiency_rate`](#district_proficiency_rate)

<a id="staff_student_cost_ratio"></a>
### Staff-to-Student Cost Ratio — `staff_student_cost_ratio`

Personnel costs as a share of total per-pupil expenditure — staffing investment intensity.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/staff_student_cost_ratio.yml) · [sql](dbt/analyses/metrics/edu/staff_student_cost_ratio.sql)
- **Numerator:** Total Personnel Cost
- **Denominator:** Total Operating Budget
- **Dimensions:** school_id, fiscal_year
- **Data sources:** Finance, HRIS
- **Parents:** [`per_pupil_expenditure`](#per_pupil_expenditure)
- **Children:** [`headcount_cost`](#headcount_cost)
- **Correlated:** [`teacher_retention_rate`](#teacher_retention_rate), [`per_pupil_expenditure`](#per_pupil_expenditure)

<a id="student_attendance_rate"></a>
### Attendance Rate — `student_attendance_rate`

Percentage of scheduled school days attended across all students

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/student_attendance_rate.yml) · [sql](dbt/analyses/metrics/edu/student_attendance_rate.sql)
- **Numerator:** Days attended
- **Denominator:** Days enrolled
- **Dimensions:** school_year, grade, school
- **Data sources:** attendance
- **Parents:** [`four_year_grad_rate`](#four_year_grad_rate), [`ela_proficiency_rate`](#ela_proficiency_rate)
- **Children:** [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`adm`](#adm)
- **Correlated:** [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`sgp`](#sgp), [`ela_proficiency_rate`](#ela_proficiency_rate), [`extracurricular_rate`](#extracurricular_rate), [`family_engagement_rate`](#family_engagement_rate), [`grade3_reading`](#grade3_reading), [`kinder_readiness`](#kinder_readiness), [`math_proficiency_rate`](#math_proficiency_rate), [`school_climate_score`](#school_climate_score)

<a id="student_growth_percentile"></a>
### Student Growth Percentile — `student_growth_percentile`

Percentile ranking of a student’s academic growth relative to peers with similar prior scores.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/student_growth_percentile.yml) · [sql](dbt/analyses/metrics/edu/student_growth_percentile.sql)
- **Numerator:** Percentile of growth vs academic peers
- **Dimensions:** student_id, subject, grade_level, period
- **Data sources:** SIS, Assessment platform
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Children:** [`stg_student_assessment_row`](#stg_student_assessment_row)
- **Correlated:** [`student_proficiency`](#student_proficiency), [`attendance_rate`](#attendance_rate)

<a id="student_teacher_ratio"></a>
### Student:Teacher Ratio — `student_teacher_ratio`

Number of enrolled students per FTE classroom teacher

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/student_teacher_ratio.yml) · [sql](dbt/analyses/metrics/edu/student_teacher_ratio.sql)
- **Numerator:** Students
- **Denominator:** Full-time-equivalent teachers
- **Dimensions:** school_year, school
- **Data sources:** enrollment, hris
- **Parents:** [`per_pupil_expenditure`](#per_pupil_expenditure)
- **Correlated:** [`per_pupil_expenditure`](#per_pupil_expenditure), [`sgp`](#sgp)

<a id="teacher_retention_rate"></a>
### Teacher Retention Rate — `teacher_retention_rate`

% of teachers who return the following school year.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/teacher_retention_rate.yml) · [sql](dbt/analyses/metrics/edu/teacher_retention_rate.sql)
- **Numerator:** Teachers returning next year
- **Denominator:** Teachers at end of prior year
- **Dimensions:** school_id, subject_area, experience_band, period
- **Data sources:** HRIS, SIS
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Children:** [`stg_employee_row`](#stg_employee_row)
- **Correlated:** [`employee_attrition_rate`](#employee_attrition_rate), [`student_proficiency`](#student_proficiency), [`avg_teacher_experience`](#avg_teacher_experience), [`on_time_lesson_delivery`](#on_time_lesson_delivery), [`school_climate_score`](#school_climate_score), [`staff_student_cost_ratio`](#staff_student_cost_ratio), [`teacher_student_ratio`](#teacher_student_ratio)

<a id="teacher_student_ratio"></a>
### Teacher-to-Student Ratio — `teacher_student_ratio`

Average number of students per full-time teacher — resource allocation metric.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/teacher_student_ratio.yml) · [sql](dbt/analyses/metrics/edu/teacher_student_ratio.sql)
- **Numerator:** Total Enrollment
- **Denominator:** FTE Teachers
- **Dimensions:** school_id, grade_level, period
- **Data sources:** SIS, HRIS
- **Parents:** [`per_pupil_expenditure`](#per_pupil_expenditure)
- **Children:** [`enrollment_count`](#enrollment_count), [`headcount_fte`](#headcount_fte)
- **Correlated:** [`student_proficiency`](#student_proficiency), [`teacher_retention_rate`](#teacher_retention_rate)

<a id="upsell_rate"></a>
### Upsell Rate — `upsell_rate`

% of existing customers who expanded to a higher tier or added seats.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/upsell_rate.yml) · [sql](dbt/analyses/metrics/edu/upsell_rate.sql)
- **Numerator:** Upsell events
- **Denominator:** Total customers
- **Dimensions:** date, product
- **Data sources:** crm, orders
- **Parents:** [`expansion_arr`](#expansion_arr)
- **Children:** [`stg_purchases_count`](#stg_purchases_count)
- **Correlated:** [`cross_sell_rate`](#cross_sell_rate), [`expansion_arr`](#expansion_arr), [`nrr`](#nrr), [`expansion_pipeline`](#expansion_pipeline)

<a id="absenteeism_by_subgroup"></a>
### Absenteeism by Subgroup — `absenteeism_by_subgroup`

Chronic absenteeism rate disaggregated by demographic or program subgroup.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/absenteeism_by_subgroup.yml) · [sql](dbt/analyses/metrics/finance/absenteeism_by_subgroup.sql)
- **Numerator:** Chronically Absent Students in Subgroup
- **Denominator:** Total Students in Subgroup
- **Dimensions:** school_id, subgroup, grade_level, period
- **Data sources:** SIS, Attendance system
- **Parents:** [`chronic_absenteeism`](#chronic_absenteeism)
- **Children:** [`stg_attendance_row`](#stg_attendance_row)
- **Correlated:** [`chronic_absenteeism`](#chronic_absenteeism), [`student_proficiency`](#student_proficiency)

<a id="absenteeism_rate"></a>
### Absenteeism Rate — `absenteeism_rate`

Percentage of scheduled workdays lost to unplanned absences

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/absenteeism_rate.yml) · [sql](dbt/analyses/metrics/finance/absenteeism_rate.sql)
- **Numerator:** Unplanned absence days
- **Denominator:** Available working days
- **Dimensions:** date, department
- **Data sources:** hris, time_records
- **Parents:** [`workforce_productivity`](#workforce_productivity)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`engagement_score`](#engagement_score), [`turnover_rate`](#turnover_rate), [`overtime_hours`](#overtime_hours), [`remote_work_rate`](#remote_work_rate)

<a id="activation_rate"></a>
### Activation Rate — `activation_rate`

% of signups that reach the activation milestone within the first session or week.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/activation_rate.yml) · [sql](dbt/analyses/metrics/finance/activation_rate.sql)
- **Numerator:** Users who hit activation event
- **Denominator:** Total Signups
- **Dimensions:** cohort, acquisition_channel, plan_tier
- **Data sources:** Product analytics
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`stg_user_event_row`](#stg_user_event_row), [`funnel_dropoff`](#funnel_dropoff), [`time_to_activate`](#time_to_activate)
- **Correlated:** [`onboarding_completion_rate`](#onboarding_completion_rate), [`time_to_value`](#time_to_value), [`app_downloads`](#app_downloads), [`d7_retention`](#d7_retention), [`feature_adoption`](#feature_adoption), [`free_to_paid_rate`](#free_to_paid_rate), [`funnel_dropoff`](#funnel_dropoff), [`new_user_signups`](#new_user_signups), [`onboarding_time`](#onboarding_time), [`time_to_activate`](#time_to_activate), [`trial_signups`](#trial_signups), [`trial_to_paid_rate`](#trial_to_paid_rate), [`user_signups`](#user_signups)

<a id="active_paying_users"></a>
### Active Paying Users — `active_paying_users`

Users on a paid plan who have been active in the past 30 days

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/active_paying_users.yml) · [sql](dbt/analyses/metrics/finance/active_paying_users.sql)
- **Numerator:** Paid users active in last 30 days
- **Dimensions:** date
- **Data sources:** users, subscriptions
- **Parents:** [`free_to_paid_rate`](#free_to_paid_rate)
- **Children:** [`mau`](#mau), [`stg_subscriptions_active`](#stg_subscriptions_active)
- **Correlated:** [`arr`](#arr), [`free_to_paid_rate`](#free_to_paid_rate)

<a id="acv"></a>
### ACV — `acv`

Average annual contract value of new or existing customer agreements.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/acv.yml) · [sql](dbt/analyses/metrics/finance/acv.sql)
- **Numerator:** Total Contract ARR Value
- **Denominator:** Number of Contracts
- **Dimensions:** segment, product_tier, channel, period
- **Data sources:** CRM, Billing system
- **Parents:** [`arr`](#arr)
- **Children:** [`stg_opportunity_row`](#stg_opportunity_row)
- **Correlated:** [`arr`](#arr), [`new_arr`](#new_arr), [`avg_deal_size`](#avg_deal_size), [`revenue_per_account`](#revenue_per_account)

<a id="ap_participation_rate"></a>
### AP Participation % — `ap_participation_rate`

Percentage of 11th and 12th graders enrolled in at least one AP course

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/ap_participation_rate.yml) · [sql](dbt/analyses/metrics/finance/ap_participation_rate.sql)
- **Numerator:** Students in AP courses
- **Denominator:** 11th–12th grade enrollment
- **Dimensions:** school_year, school
- **Data sources:** course_enrollment
- **Parents:** [`college_enrollment_rate`](#college_enrollment_rate)
- **Children:** [`school_enrollment`](#school_enrollment)
- **Correlated:** [`ap_pass_rate`](#ap_pass_rate), [`college_enrollment_rate`](#college_enrollment_rate)

<a id="ap_pass_rate"></a>
### AP Pass Rate — `ap_pass_rate`

Percentage of AP exam takers scoring 3, 4, or 5

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/ap_pass_rate.yml) · [sql](dbt/analyses/metrics/finance/ap_pass_rate.sql)
- **Numerator:** AP scores of 3+
- **Denominator:** AP tests taken
- **Dimensions:** school_year, subject
- **Data sources:** assessment_data
- **Parents:** [`college_enrollment_rate`](#college_enrollment_rate)
- **Correlated:** [`college_enrollment_rate`](#college_enrollment_rate), [`district_proficiency_rate`](#district_proficiency_rate), [`ap_participation_rate`](#ap_participation_rate)

<a id="app_store_rating"></a>
### App Store Rating — `app_store_rating`

Average rating on iOS App Store and Google Play

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/app_store_rating.yml) · [sql](dbt/analyses/metrics/finance/app_store_rating.sql)
- **Numerator:** Average app store rating
- **Dimensions:** date, platform
- **Data sources:** app_stores
- **Parents:** [`nps`](#nps)
- **Correlated:** [`nps`](#nps), [`csat`](#csat), [`review_rating`](#review_rating)

<a id="ar_aging_90d"></a>
### AR Aging 90d+ — `ar_aging_90d`

Total outstanding receivables past 90 days — bad debt risk indicator.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/ar_aging_90d.yml) · [sql](dbt/analyses/metrics/finance/ar_aging_90d.sql)
- **Numerator:** SUM(invoice_amount WHERE days_outstanding > 90)
- **Dimensions:** company_id, customer_segment, period
- **Data sources:** ERP, AR aging report
- **Parents:** [`dso`](#dso), [`bad_debt_rate`](#bad_debt_rate)
- **Children:** [`stg_invoice_row`](#stg_invoice_row)
- **Correlated:** [`dso`](#dso), [`working_capital`](#working_capital), [`bad_debt_rate`](#bad_debt_rate)

<a id="arpu"></a>
### ARPU — `arpu`

Average Revenue Per User — revenue efficiency across the base.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/arpu.yml) · [sql](dbt/analyses/metrics/finance/arpu.sql)
- **Numerator:** Total Revenue
- **Denominator:** Active Customers (period)
- **Dimensions:** segment, product_category, channel, month
- **Data sources:** Transactional DB, Billing system
- **Parents:** [`customer_ltv`](#customer_ltv), [`revenue`](#revenue), [`cac_payback`](#cac_payback), [`payback_ratio`](#payback_ratio)
- **Children:** [`revenue_per_account`](#revenue_per_account)
- **Correlated:** [`customer_ltv`](#customer_ltv), [`churn_rate`](#churn_rate), [`customer_health_score`](#customer_health_score), [`iap_revenue`](#iap_revenue), [`revenue`](#revenue), [`revenue_per_account`](#revenue_per_account)

<a id="asp"></a>
### ASP — `asp`

Average selling price per unit or transaction — pricing health signal.

- **Vertical:** Finance & FP&A · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/finance/asp.yml) · [sql](dbt/analyses/metrics/finance/asp.sql)
- **Numerator:** Total Revenue
- **Denominator:** Units Sold
- **Dimensions:** product_line, channel, geography, period
- **Data sources:** ERP, Billing system
- **Parents:** [`revenue`](#revenue)
- **Children:** [`stg_revenue_event_amount`](#stg_revenue_event_amount)
- **Correlated:** [`revenue`](#revenue), [`gross_margin`](#gross_margin)

<a id="at_risk_accounts"></a>
### At-Risk Accounts — `at_risk_accounts`

Number of accounts with health score below the risk threshold

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/at_risk_accounts.yml) · [sql](dbt/analyses/metrics/finance/at_risk_accounts.sql)
- **Numerator:** Accounts below health score threshold
- **Dimensions:** date
- **Data sources:** crm
- **Parents:** [`churn_rate`](#churn_rate)
- **Children:** [`account_health_score`](#account_health_score)
- **Correlated:** [`churn_rate`](#churn_rate), [`renewal_rate`](#renewal_rate), [`account_health_score`](#account_health_score), [`expansion_pipeline`](#expansion_pipeline)

<a id="attendance_rate"></a>
### Attendance Rate — `attendance_rate`

% of possible days attended across enrolled students.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/attendance_rate.yml) · [sql](dbt/analyses/metrics/finance/attendance_rate.sql)
- **Numerator:** Days Attended
- **Denominator:** Days Enrolled
- **Dimensions:** school_id, grade_level, subgroup, month
- **Data sources:** SIS, Daily attendance system
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Children:** [`chronic_absenteeism`](#chronic_absenteeism), [`average_daily_attendance`](#average_daily_attendance), [`stg_attendance_row`](#stg_attendance_row)
- **Correlated:** [`student_proficiency`](#student_proficiency), [`suspension_rate`](#suspension_rate), [`ell_proficiency_growth`](#ell_proficiency_growth), [`enrollment_count`](#enrollment_count), [`graduation_rate`](#graduation_rate), [`iep_goal_mastery_rate`](#iep_goal_mastery_rate), [`on_time_lesson_delivery`](#on_time_lesson_delivery), [`per_pupil_expenditure`](#per_pupil_expenditure), [`school_culture_score`](#school_culture_score), [`student_growth_percentile`](#student_growth_percentile)

<a id="average_daily_attendance"></a>
### Avg Daily Attendance — `average_daily_attendance`

Average % of enrolled students present each school day.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/average_daily_attendance.yml) · [sql](dbt/analyses/metrics/finance/average_daily_attendance.sql)
- **Numerator:** Total Days Present
- **Denominator:** Total Days Enrolled
- **Dimensions:** school_id, grade_level, period
- **Data sources:** SIS, Attendance system
- **Parents:** [`attendance_rate`](#attendance_rate)
- **Children:** [`stg_attendance_row`](#stg_attendance_row)
- **Correlated:** [`chronic_absenteeism`](#chronic_absenteeism), [`student_proficiency`](#student_proficiency)

<a id="avg_deal_size"></a>
### Avg Deal Size — `avg_deal_size`

Average ARR value of closed-won opportunities in the period.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/avg_deal_size.yml) · [sql](dbt/analyses/metrics/finance/avg_deal_size.sql)
- **Numerator:** Total bookings value
- **Denominator:** Number of deals closed
- **Dimensions:** date, sales_rep, segment
- **Data sources:** opportunities
- **Parents:** [`new_arr`](#new_arr), [`pipeline_generated`](#pipeline_generated)
- **Children:** [`bookings`](#bookings), [`stg_opportunities_count`](#stg_opportunities_count)
- **Correlated:** [`acv`](#acv), [`pipeline_coverage`](#pipeline_coverage), [`competitive_win_rate`](#competitive_win_rate)

<a id="avg_sales_cycle"></a>
### Sales Cycle (days) — `avg_sales_cycle`

Average days from opportunity creation to close

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/avg_sales_cycle.yml) · [sql](dbt/analyses/metrics/finance/avg_sales_cycle.sql)
- **Numerator:** Sum of sales cycle days
- **Denominator:** Closed opportunities
- **Dimensions:** date, segment, product
- **Data sources:** crm
- **Parents:** [`new_arr`](#new_arr)
- **Children:** [`sql`](#sql), [`bookings`](#bookings), [`sales_cycle_by_segment`](#sales_cycle_by_segment)
- **Correlated:** [`win_rate`](#win_rate), [`cac_payback`](#cac_payback), [`sales_cycle_by_segment`](#sales_cycle_by_segment)

<a id="avg_session_duration"></a>
### Avg Session Duration — `avg_session_duration`

Average time users spend per session in the product.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/avg_session_duration.yml) · [sql](dbt/analyses/metrics/finance/avg_session_duration.sql)
- **Numerator:** SUM(session_duration_seconds)
- **Denominator:** COUNT(sessions)
- **Dimensions:** platform, product_area, user_segment, period
- **Data sources:** Product analytics
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`stg_user_event_row`](#stg_user_event_row)
- **Correlated:** [`feature_adoption_rate`](#feature_adoption_rate), [`dau`](#dau), [`bounce_rate`](#bounce_rate)

<a id="bounce_rate"></a>
### Bounce Rate — `bounce_rate`

% of sessions where users leave after viewing only one page.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/bounce_rate.yml) · [sql](dbt/analyses/metrics/finance/bounce_rate.sql)
- **Numerator:** Single-Page Sessions
- **Denominator:** Total Sessions
- **Dimensions:** landing_page, channel, device, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`web_conversion_rate`](#web_conversion_rate)
- **Children:** [`stg_session_row`](#stg_session_row)
- **Correlated:** [`web_conversion_rate`](#web_conversion_rate), [`avg_session_duration`](#avg_session_duration), [`session_to_lead_rate`](#session_to_lead_rate), [`stg_page_views`](#stg_page_views), [`website_sessions`](#website_sessions)

<a id="budget_variance"></a>
### Budget Variance — `budget_variance`

Actual spend vs budget — positive = over budget, negative = under budget.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/budget_variance.yml) · [sql](dbt/analyses/metrics/finance/budget_variance.sql)
- **Numerator:** Actual spend − Budgeted spend
- **Denominator:** Budgeted spend
- **Dimensions:** date, department
- **Data sources:** budget_tracking, general_ledger
- **Parents:** [`budget_variance_pct`](#budget_variance_pct)
- **Children:** [`annual_budget`](#annual_budget)
- **Correlated:** [`forecast_accuracy`](#forecast_accuracy), [`opex`](#opex), [`annual_budget`](#annual_budget), [`headcount_vs_budget`](#headcount_vs_budget)

<a id="budget_variance_pct"></a>
### Budget Variance % — `budget_variance_pct`

Budget variance as a % of budget — normalized over/under indicator.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/budget_variance_pct.yml) · [sql](dbt/analyses/metrics/finance/budget_variance_pct.sql)
- **Numerator:** Actual - Budget
- **Denominator:** Budget
- **Dimensions:** department, cost_center, fiscal_period
- **Data sources:** ERP, Budgeting system
- **Parents:** [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Children:** [`budget_variance`](#budget_variance)
- **Correlated:** [`opex`](#opex), [`ebitda_margin`](#ebitda_margin)

<a id="burn_rate"></a>
### Burn Rate — `burn_rate`

Monthly net cash outflow — critical for pre-revenue or high-growth companies.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/burn_rate.yml) · [sql](dbt/analyses/metrics/finance/burn_rate.sql)
- **Numerator:** Monthly net cash outflow
- **Dimensions:** date
- **Data sources:** bank_transactions, general_ledger
- **Parents:** [`runway_months`](#runway_months)
- **Children:** [`opex`](#opex), [`capex`](#capex)
- **Correlated:** [`free_cash_flow`](#free_cash_flow), [`runway_months`](#runway_months), [`cash_and_equivalents`](#cash_and_equivalents)

<a id="capacity_utilization"></a>
### Capacity Utilization % — `capacity_utilization`

Actual output as a percentage of total available capacity

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/capacity_utilization.yml) · [sql](dbt/analyses/metrics/finance/capacity_utilization.sql)
- **Numerator:** Actual output
- **Denominator:** Maximum capacity
- **Dimensions:** date, facility
- **Data sources:** capacity_planning
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Children:** [`throughput`](#throughput)
- **Correlated:** [`warehouse_utilization`](#warehouse_utilization), [`cycle_time`](#cycle_time), [`throughput`](#throughput)

<a id="capacity_utilization_rate"></a>
### Capacity Utilization — `capacity_utilization_rate`

Actual output as a % of theoretical maximum capacity — productivity efficiency.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/capacity_utilization_rate.yml) · [sql](dbt/analyses/metrics/finance/capacity_utilization_rate.sql)
- **Numerator:** Actual Output
- **Denominator:** Maximum Possible Output
- **Dimensions:** production_line, plant_id, period
- **Data sources:** MES, ERP
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Correlated:** [`defect_rate`](#defect_rate), [`cost_per_unit`](#cost_per_unit), [`energy_cost_per_unit`](#energy_cost_per_unit)

<a id="capex"></a>
### CapEx — `capex`

Capital expenditures — spend on fixed assets and infrastructure.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/capex.yml) · [sql](dbt/analyses/metrics/finance/capex.sql)
- **Numerator:** SUM(capex_amount)
- **Dimensions:** company_id, asset_category, fiscal_period
- **Data sources:** ERP, Fixed asset register
- **Parents:** [`free_cash_flow`](#free_cash_flow), [`burn_rate`](#burn_rate), [`capex_pct_revenue`](#capex_pct_revenue)
- **Correlated:** [`ebitda`](#ebitda), [`rd_expense`](#rd_expense), [`da`](#da)

<a id="carbon_emissions_per_unit"></a>
### Carbon per Unit — `carbon_emissions_per_unit`

kg CO2 equivalent emitted per unit of output — ESG and sustainability metric.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/carbon_emissions_per_unit.yml) · [sql](dbt/analyses/metrics/finance/carbon_emissions_per_unit.sql)
- **Numerator:** Total CO2e Emissions (kg)
- **Denominator:** Units Produced
- **Dimensions:** facility_id, process_type, period
- **Data sources:** Environmental monitoring, ERP
- **Parents:** [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Correlated:** [`energy_cost_per_unit`](#energy_cost_per_unit), [`cost_per_unit`](#cost_per_unit)

<a id="change_failure_rate"></a>
### Change Failure % — `change_failure_rate`

Percentage of deployments causing production incidents (DORA metric)

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/change_failure_rate.yml) · [sql](dbt/analyses/metrics/finance/change_failure_rate.sql)
- **Numerator:** Failed deployments
- **Denominator:** Total deployments
- **Dimensions:** date
- **Data sources:** ci_cd, incident_management
- **Parents:** [`uptime`](#uptime)
- **Children:** [`deployment_frequency`](#deployment_frequency), [`tech_debt_ratio`](#tech_debt_ratio)
- **Correlated:** [`mttr`](#mttr), [`bug_escape_rate`](#bug_escape_rate), [`code_coverage`](#code_coverage), [`deployment_frequency`](#deployment_frequency)

<a id="chronic_absenteeism"></a>
### Chronic Absenteeism — `chronic_absenteeism`

% of students missing 10%+ of school days (federal accountability metric).

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/chronic_absenteeism.yml) · [sql](dbt/analyses/metrics/finance/chronic_absenteeism.sql)
- **Numerator:** Students absent ≥10% of days
- **Denominator:** Total enrolled students
- **Dimensions:** school_id, grade_level, subgroup, academic_year
- **Data sources:** SIS, State reporting system
- **Parents:** [`attendance_rate`](#attendance_rate), [`student_proficiency`](#student_proficiency)
- **Children:** [`absenteeism_by_subgroup`](#absenteeism_by_subgroup), [`stg_attendance_row`](#stg_attendance_row)
- **Correlated:** [`student_proficiency`](#student_proficiency), [`absenteeism_by_subgroup`](#absenteeism_by_subgroup), [`average_daily_attendance`](#average_daily_attendance), [`credit_accumulation_rate`](#credit_accumulation_rate)

<a id="chronic_absenteeism_rate"></a>
### Chronic Absence % — `chronic_absenteeism_rate`

Percentage of students missing 10% or more of enrolled days

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/chronic_absenteeism_rate.yml) · [sql](dbt/analyses/metrics/finance/chronic_absenteeism_rate.sql)
- **Numerator:** Students missing 10%+ of school days
- **Denominator:** Enrolled students
- **Dimensions:** school_year, grade, school
- **Data sources:** attendance
- **Parents:** [`student_attendance_rate`](#student_attendance_rate), [`dropout_rate`](#dropout_rate)
- **Children:** [`suspension_rate`](#suspension_rate)
- **Correlated:** [`student_attendance_rate`](#student_attendance_rate), [`dropout_rate`](#dropout_rate), [`ell_pct`](#ell_pct), [`frl_pct`](#frl_pct), [`suspension_rate`](#suspension_rate)

<a id="cogs"></a>
### COGS — `cogs`

Total cost of goods sold in a period.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cogs.yml) · [sql](dbt/analyses/metrics/finance/cogs.sql)
- **Numerator:** SUM(cogs_amount)
- **Dimensions:** company_id, product_line, fiscal_period
- **Data sources:** ERP
- **Parents:** [`ebitda`](#ebitda), [`gross_margin`](#gross_margin), [`gross_margin_by_segment`](#gross_margin_by_segment)
- **Children:** [`stg_cogs_event`](#stg_cogs_event), [`procurement_savings_rate`](#procurement_savings_rate), [`shrinkage_rate`](#shrinkage_rate)
- **Correlated:** [`revenue`](#revenue)

<a id="college_enrollment"></a>
### College Enrollment Rate — `college_enrollment`

% of graduates enrolling in 2- or 4-year college within 1 year.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/college_enrollment.yml) · [sql](dbt/analyses/metrics/finance/college_enrollment.sql)
- **Numerator:** Graduates enrolled in college
- **Denominator:** Total graduates
- **Dimensions:** school_id, grad_year, college_type, subgroup
- **Data sources:** National Student Clearinghouse, SIS
- **Parents:** [`college_enrollment_rate`](#college_enrollment_rate)
- **Children:** [`fafsa_completion_rate`](#fafsa_completion_rate), [`graduation_rate`](#graduation_rate)
- **Correlated:** [`student_proficiency`](#student_proficiency), [`graduation_rate`](#graduation_rate), [`advanced_course_enrollment_rate`](#advanced_course_enrollment_rate), [`fafsa_completion_rate`](#fafsa_completion_rate)

<a id="cost_per_event_attendee"></a>
### Cost / Attendee — `cost_per_event_attendee`

Total event spend divided by number of attendees

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cost_per_event_attendee.yml) · [sql](dbt/analyses/metrics/finance/cost_per_event_attendee.sql)
- **Numerator:** Event cost
- **Denominator:** Attendees
- **Dimensions:** date, event
- **Data sources:** events_platform, finance
- **Parents:** [`cpl`](#cpl)
- **Correlated:** [`event_attendees`](#event_attendees), [`cpl`](#cpl)

<a id="cost_per_mile"></a>
### Cost per Mile — `cost_per_mile`

Total fleet operating cost divided by total miles driven.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cost_per_mile.yml) · [sql](dbt/analyses/metrics/finance/cost_per_mile.sql)
- **Numerator:** Total Fleet Operating Cost
- **Denominator:** Total Miles Driven
- **Dimensions:** fleet_type, vehicle_id, period
- **Data sources:** Fleet management, Finance
- **Parents:** [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Children:** [`stg_vehicle_trip_row`](#stg_vehicle_trip_row), [`fleet_utilization_rate`](#fleet_utilization_rate)
- **Correlated:** [`fleet_utilization_rate`](#fleet_utilization_rate)

<a id="cost_per_unit"></a>
### Cost per Unit — `cost_per_unit`

Total production cost divided by units produced in the period.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cost_per_unit.yml) · [sql](dbt/analyses/metrics/finance/cost_per_unit.sql)
- **Numerator:** Total Production Cost
- **Denominator:** Units Produced
- **Dimensions:** product_id, production_line, period
- **Data sources:** ERP, MES
- **Parents:** [`gross_margin`](#gross_margin)
- **Children:** [`energy_cost_per_unit`](#energy_cost_per_unit)
- **Correlated:** [`defect_rate`](#defect_rate), [`capacity_utilization_rate`](#capacity_utilization_rate), [`carbon_emissions_per_unit`](#carbon_emissions_per_unit), [`procurement_savings_rate`](#procurement_savings_rate)

<a id="cpl"></a>
### Cost Per Lead — `cpl`

Total marketing spend divided by leads generated

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cpl.yml) · [sql](dbt/analyses/metrics/finance/cpl.sql)
- **Numerator:** Marketing spend
- **Denominator:** Leads generated
- **Dimensions:** date, channel, campaign
- **Data sources:** ad_platforms, crm
- **Parents:** [`cost_per_mql`](#cost_per_mql)
- **Children:** [`stg_ad_spend`](#stg_ad_spend), [`stg_leads_count`](#stg_leads_count), [`cost_per_event_attendee`](#cost_per_event_attendee), [`cpc`](#cpc)
- **Correlated:** [`cost_per_mql`](#cost_per_mql), [`cpc`](#cpc), [`cost_per_event_attendee`](#cost_per_event_attendee), [`stg_leads_count`](#stg_leads_count)

<a id="cpm"></a>
### CPM — `cpm`

Cost per thousand impressions — media efficiency benchmark.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cpm.yml) · [sql](dbt/analyses/metrics/finance/cpm.sql)
- **Numerator:** Spend × 1000
- **Denominator:** Impressions
- **Dimensions:** channel, campaign, period
- **Data sources:** Ad platforms
- **Parents:** [`cpc`](#cpc)
- **Children:** [`marketing_spend`](#marketing_spend), [`impressions`](#impressions)
- **Correlated:** [`ctr`](#ctr), [`cpc`](#cpc)

<a id="credit_accumulation_rate"></a>
### Credit Accumulation Rate — `credit_accumulation_rate`

% of students on track to graduate based on credit accumulation milestones.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/credit_accumulation_rate.yml) · [sql](dbt/analyses/metrics/finance/credit_accumulation_rate.sql)
- **Numerator:** Students on credit pace
- **Denominator:** Total Students
- **Dimensions:** school_id, grade_level, period
- **Data sources:** SIS, Transcript system
- **Parents:** [`graduation_rate`](#graduation_rate)
- **Children:** [`course_completion_rate`](#course_completion_rate)
- **Correlated:** [`graduation_rate`](#graduation_rate), [`chronic_absenteeism`](#chronic_absenteeism)

<a id="current_ratio"></a>
### Current Ratio — `current_ratio`

Current assets divided by current liabilities — liquidity benchmark (>1 = solvent).

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/current_ratio.yml) · [sql](dbt/analyses/metrics/finance/current_ratio.sql)
- **Numerator:** Current Assets
- **Denominator:** Current Liabilities
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`working_capital`](#working_capital)
- **Children:** [`cash_and_equivalents`](#cash_and_equivalents), [`accounts_receivable`](#accounts_receivable), [`accounts_payable`](#accounts_payable), [`total_assets`](#total_assets)
- **Correlated:** [`working_capital`](#working_capital), [`debt_to_equity`](#debt_to_equity), [`net_debt`](#net_debt), [`quick_ratio`](#quick_ratio)

<a id="debt_ebitda"></a>
### Debt / EBITDA — `debt_ebitda`

Leverage ratio — total debt divided by trailing twelve-month EBITDA.

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/debt_ebitda.yml) · [sql](dbt/analyses/metrics/finance/debt_ebitda.sql)
- **Numerator:** Total Debt
- **Denominator:** TTM EBITDA
- **Dimensions:** company_id, quarter
- **Data sources:** Balance sheet, ERP
- **Parents:** [`leverage_ratio`](#leverage_ratio)
- **Formula inputs:** [`ebitda`](#ebitda)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`free_cash_flow`](#free_cash_flow), [`interest_coverage_ratio`](#interest_coverage_ratio), [`return_on_assets`](#return_on_assets), [`return_on_equity`](#return_on_equity)

<a id="debt_to_equity"></a>
### D/E Ratio — `debt_to_equity`

Total debt divided by shareholder equity

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/debt_to_equity.yml) · [sql](dbt/analyses/metrics/finance/debt_to_equity.sql)
- **Numerator:** Total Debt
- **Denominator:** Shareholders' Equity
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`return_on_equity`](#return_on_equity)
- **Children:** [`total_debt`](#total_debt), [`shareholder_equity`](#shareholder_equity)
- **Correlated:** [`leverage_ratio`](#leverage_ratio), [`current_ratio`](#current_ratio), [`interest_coverage`](#interest_coverage), [`ev_ebitda`](#ev_ebitda), [`total_liabilities`](#total_liabilities)

<a id="domain_authority"></a>
### Domain Authority — `domain_authority`

Third-party domain authority score (Moz, Ahrefs) from 0 to 100

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/domain_authority.yml) · [sql](dbt/analyses/metrics/finance/domain_authority.sql)
- **Numerator:** SEO authority score (0–100)
- **Dimensions:** date
- **Data sources:** seo_tools
- **Parents:** [`keywords_top10`](#keywords_top10)
- **Children:** [`backlink_count`](#backlink_count), [`backlinks_count`](#backlinks_count)
- **Correlated:** [`organic_traffic`](#organic_traffic), [`keywords_top10`](#keywords_top10), [`backlinks_count`](#backlinks_count), [`backlink_count`](#backlink_count), [`content_published`](#content_published), [`oss_stars`](#oss_stars), [`pr_mentions`](#pr_mentions), [`social_engagement_rate`](#social_engagement_rate)

<a id="dpo"></a>
### DPO — `dpo`

Average days taken to pay suppliers

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/dpo.yml) · [sql](dbt/analyses/metrics/finance/dpo.sql)
- **Numerator:** Accounts Payable × 365
- **Denominator:** COGS
- **Dimensions:** date, vendor
- **Data sources:** purchase_orders, payments
- **Parents:** [`working_capital`](#working_capital)
- **Children:** [`accounts_payable`](#accounts_payable), [`cogs_stg`](#cogs_stg)
- **Correlated:** [`dso`](#dso), [`working_capital`](#working_capital), [`accounts_payable`](#accounts_payable), [`inventory_turnover`](#inventory_turnover)

<a id="dso"></a>
### Days Sales Outstanding — `dso`

Average days to collect payment after a sale — cash conversion speed.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/dso.yml) · [sql](dbt/analyses/metrics/finance/dso.sql)
- **Numerator:** Accounts Receivable × 365
- **Denominator:** Annual Revenue
- **Dimensions:** date, customer_segment
- **Data sources:** invoices, payments
- **Parents:** [`working_capital`](#working_capital)
- **Children:** [`accounts_receivable`](#accounts_receivable), [`ar_aging_90d`](#ar_aging_90d), [`stg_invoice_row`](#stg_invoice_row)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`dpo`](#dpo), [`cash_and_equivalents`](#cash_and_equivalents), [`accounts_receivable`](#accounts_receivable), [`ar_aging_90d`](#ar_aging_90d), [`bad_debt_rate`](#bad_debt_rate), [`stg_invoices_count`](#stg_invoices_count)

<a id="earned_media_value"></a>
### Earned Media Value — `earned_media_value`

Estimated equivalent value of organic press coverage

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/earned_media_value.yml) · [sql](dbt/analyses/metrics/finance/earned_media_value.sql)
- **Numerator:** Estimated value of earned media coverage
- **Dimensions:** date
- **Data sources:** media_monitoring
- **Parents:** [`share_of_voice`](#share_of_voice)
- **Children:** [`pr_mentions`](#pr_mentions)
- **Correlated:** [`pr_mentions`](#pr_mentions), [`social_engagement_rate`](#social_engagement_rate)

<a id="ebit"></a>
### EBIT — `ebit`

Earnings before interest and taxes

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/ebit.yml) · [sql](dbt/analyses/metrics/finance/ebit.sql)
- **Numerator:** Gross Profit minus OpEx
- **Parents:** [`ebitda`](#ebitda), [`interest_coverage`](#interest_coverage)

<a id="ebitda_margin"></a>
### EBITDA Margin — `ebitda_margin`

EBITDA as a % of revenue — core PE performance lens.

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/ebitda_margin.yml) · [sql](dbt/analyses/metrics/finance/ebitda_margin.sql)
- **Numerator:** EBITDA
- **Denominator:** Revenue
- **Dimensions:** company_id, fiscal_period, segment
- **Data sources:** ERP, Portfolio data room
- **Parents:** [`ebitda`](#ebitda), [`rule_of_40`](#rule_of_40)
- **Correlated:** [`gross_margin`](#gross_margin), [`budget_variance_pct`](#budget_variance_pct), [`debt_ebitda`](#debt_ebitda), [`ebitda`](#ebitda), [`ga_spend_pct`](#ga_spend_pct), [`gna_pct_revenue`](#gna_pct_revenue), [`gross_margin_by_segment`](#gross_margin_by_segment), [`gross_margin_pct`](#gross_margin_pct), [`net_income_margin`](#net_income_margin), [`net_margin`](#net_margin), [`rd_as_pct_revenue`](#rd_as_pct_revenue), [`rd_spend_pct`](#rd_spend_pct), [`revenue_per_employee`](#revenue_per_employee), [`sg_and_a`](#sg_and_a)

<a id="effective_tax_rate"></a>
### Effective Tax Rate — `effective_tax_rate`

Actual income taxes paid divided by pre-tax income.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/effective_tax_rate.yml) · [sql](dbt/analyses/metrics/finance/effective_tax_rate.sql)
- **Numerator:** Income Tax Expense
- **Denominator:** Pre-Tax Income (EBT)
- **Dimensions:** company_id, fiscal_period, jurisdiction
- **Data sources:** ERP, Tax system
- **Parents:** [`net_income`](#net_income)
- **Correlated:** [`ebitda`](#ebitda), [`free_cash_flow`](#free_cash_flow)

<a id="enrollment_count"></a>
### Enrollment Count — `enrollment_count`

Total enrolled students at a school or district as of census date.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/enrollment_count.yml) · [sql](dbt/analyses/metrics/finance/enrollment_count.sql)
- **Numerator:** COUNT(active enrollments)
- **Dimensions:** school_id, grade_level, demographic_group, period
- **Data sources:** SIS
- **Parents:** [`per_pupil_expenditure`](#per_pupil_expenditure), [`teacher_student_ratio`](#teacher_student_ratio)
- **Children:** [`stg_enrollment_row`](#stg_enrollment_row)
- **Correlated:** [`graduation_rate`](#graduation_rate), [`attendance_rate`](#attendance_rate), [`seat_fill_rate`](#seat_fill_rate)

<a id="error_rate"></a>
### Error Rate — `error_rate`

% of user sessions or API calls that result in an error.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/error_rate.yml) · [sql](dbt/analyses/metrics/finance/error_rate.sql)
- **Numerator:** Error Events
- **Denominator:** Total Events
- **Dimensions:** endpoint, error_type, platform, period
- **Data sources:** Error tracking (Sentry / Datadog)
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`stg_error_event_row`](#stg_error_event_row), [`api_latency_p95`](#api_latency_p95), [`bug_escape_rate`](#bug_escape_rate), [`product_uptime_sla`](#product_uptime_sla)
- **Correlated:** [`csat`](#csat), [`churn_rate`](#churn_rate), [`api_latency_p95`](#api_latency_p95), [`lead_time_for_changes`](#lead_time_for_changes), [`mttd`](#mttd), [`product_uptime_sla`](#product_uptime_sla), [`uptime`](#uptime)

<a id="ev_ebitda"></a>
### EV/EBITDA — `ev_ebitda`

Enterprise value divided by EBITDA — primary valuation multiple

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/ev_ebitda.yml) · [sql](dbt/analyses/metrics/finance/ev_ebitda.sql)
- **Numerator:** Enterprise Value
- **Denominator:** EBITDA
- **Dimensions:** date
- **Data sources:** cap_table, income_statement
- **Parents:** [`enterprise_value`](#enterprise_value)
- **Formula inputs:** [`ebitda`](#ebitda), [`enterprise_value`](#enterprise_value)
- **Correlated:** [`debt_to_equity`](#debt_to_equity), [`leverage_ratio`](#leverage_ratio), [`enterprise_value`](#enterprise_value)

<a id="expansion_pipeline"></a>
### Expansion Pipeline — `expansion_pipeline`

Total potential expansion ARR in open upsell opportunities

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/expansion_pipeline.yml) · [sql](dbt/analyses/metrics/finance/expansion_pipeline.sql)
- **Numerator:** Pipeline value from expansion opportunities
- **Dimensions:** date, csm
- **Data sources:** crm
- **Parents:** [`expansion_arr`](#expansion_arr)
- **Correlated:** [`upsell_rate`](#upsell_rate), [`nrr`](#nrr), [`at_risk_accounts`](#at_risk_accounts)

<a id="fcr_rate"></a>
### FCR Rate — `fcr_rate`

Percentage of support cases resolved on the first contact

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/fcr_rate.yml) · [sql](dbt/analyses/metrics/finance/fcr_rate.sql)
- **Numerator:** Tickets resolved on first contact
- **Denominator:** Total tickets
- **Dimensions:** date, channel
- **Data sources:** helpdesk
- **Parents:** [`csat`](#csat)
- **Children:** [`stg_support_tickets`](#stg_support_tickets)
- **Correlated:** [`ticket_resolution_time`](#ticket_resolution_time), [`csat`](#csat), [`stg_support_tickets`](#stg_support_tickets), [`tickets_per_agent`](#tickets_per_agent), [`tickets_resolved`](#tickets_resolved)

<a id="feature_adoption"></a>
### Feature Adoption — `feature_adoption`

Percentage of active users who used a given feature

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/feature_adoption.yml) · [sql](dbt/analyses/metrics/finance/feature_adoption.sql)
- **Numerator:** Users using feature
- **Denominator:** Total active users
- **Dimensions:** date, feature
- **Data sources:** events
- **Parents:** [`feature_adoption_rate`](#feature_adoption_rate)
- **Children:** [`stg_events_count`](#stg_events_count), [`dau`](#dau)
- **Correlated:** [`dau_mau_ratio`](#dau_mau_ratio), [`activation_rate`](#activation_rate), [`session_length`](#session_length), [`stg_events_count`](#stg_events_count)

<a id="first_response_time"></a>
### First Response Time — `first_response_time`

Average hours from ticket creation to first agent response.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/first_response_time.yml) · [sql](dbt/analyses/metrics/finance/first_response_time.sql)
- **Numerator:** SUM(first_response_at - created_at)
- **Denominator:** COUNT(tickets)
- **Dimensions:** priority, channel, team, period
- **Data sources:** Support platform
- **Parents:** [`csat`](#csat), [`sla_breach_rate`](#sla_breach_rate)
- **Children:** [`stg_ticket_row`](#stg_ticket_row)
- **Correlated:** [`ces`](#ces), [`csat`](#csat), [`stg_support_tickets`](#stg_support_tickets), [`ticket_backlog`](#ticket_backlog), [`ticket_resolution_rate`](#ticket_resolution_rate), [`ticket_resolution_time`](#ticket_resolution_time), [`time_to_resolution`](#time_to_resolution)

<a id="fleet_utilization_rate"></a>
### Fleet Utilization Rate — `fleet_utilization_rate`

% of available vehicle hours actually used in operations.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/fleet_utilization_rate.yml) · [sql](dbt/analyses/metrics/finance/fleet_utilization_rate.sql)
- **Numerator:** Hours in Service
- **Denominator:** Available Hours
- **Dimensions:** vehicle_id, fleet_type, region, period
- **Data sources:** Fleet management system (GPS, telematics)
- **Parents:** [`cost_per_mile`](#cost_per_mile)
- **Children:** [`stg_vehicle_trip_row`](#stg_vehicle_trip_row)
- **Correlated:** [`cost_per_mile`](#cost_per_mile)

<a id="forecast_accuracy"></a>
### Forecast Accuracy % — `forecast_accuracy`

Actual revenue versus forecast, expressed as an error percentage

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/forecast_accuracy.yml) · [sql](dbt/analyses/metrics/finance/forecast_accuracy.sql)
- **Numerator:** 1 − |Actual − Forecast|
- **Denominator:** Forecast
- **Dimensions:** date, segment
- **Data sources:** revenue_forecasts
- **Parents:** [`ebitda`](#ebitda)
- **Children:** [`annual_budget`](#annual_budget)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`budget_variance`](#budget_variance), [`revenue_vs_py`](#revenue_vs_py), [`revenue_ytd`](#revenue_ytd)

<a id="form_conversion_rate"></a>
### Form CVR % — `form_conversion_rate`

Percentage of form page visitors who submitted a form

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/form_conversion_rate.yml) · [sql](dbt/analyses/metrics/finance/form_conversion_rate.sql)
- **Numerator:** Form submissions
- **Denominator:** Form views
- **Dimensions:** date, form, page
- **Data sources:** analytics, crm
- **Parents:** [`mql`](#mql)
- **Children:** [`website_sessions`](#website_sessions), [`stg_leads_count`](#stg_leads_count)
- **Correlated:** [`session_to_lead_rate`](#session_to_lead_rate), [`lead_to_mql_rate`](#lead_to_mql_rate), [`demo_requests`](#demo_requests), [`email_ctr`](#email_ctr), [`webinar_attendance_rate`](#webinar_attendance_rate)

<a id="free_to_paid_rate"></a>
### Free-to-Paid % — `free_to_paid_rate`

Percentage of free-tier users who convert to a paid plan

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/free_to_paid_rate.yml) · [sql](dbt/analyses/metrics/finance/free_to_paid_rate.sql)
- **Numerator:** Free-to-paid conversions
- **Denominator:** Free users
- **Dimensions:** date, cohort
- **Data sources:** users, subscriptions
- **Parents:** [`plg_rate`](#plg_rate), [`trial_to_paid_rate`](#trial_to_paid_rate)
- **Children:** [`trial_signups`](#trial_signups), [`active_paying_users`](#active_paying_users)
- **Correlated:** [`trial_to_paid_rate`](#trial_to_paid_rate), [`activation_rate`](#activation_rate), [`active_paying_users`](#active_paying_users), [`trial_signups`](#trial_signups)

<a id="ga_spend_pct"></a>
### G&A % of Revenue — `ga_spend_pct`

General and administrative expense as a proportion of revenue

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/ga_spend_pct.yml) · [sql](dbt/analyses/metrics/finance/ga_spend_pct.sql)
- **Numerator:** G&A spend
- **Denominator:** Revenue
- **Dimensions:** date
- **Data sources:** general_ledger
- **Parents:** [`opex`](#opex)
- **Correlated:** [`opex`](#opex), [`ebitda_margin`](#ebitda_margin)

<a id="gender_pay_gap"></a>
### Gender Pay Gap — `gender_pay_gap`

Median pay of female employees as a percentage of male employee median

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/gender_pay_gap.yml) · [sql](dbt/analyses/metrics/finance/gender_pay_gap.sql)
- **Numerator:** Median male pay − Median female pay
- **Denominator:** Median male pay
- **Dimensions:** date, department, level
- **Data sources:** hris, payroll
- **Parents:** [`employee_attrition_rate`](#employee_attrition_rate)
- **Children:** [`total_comp_expense`](#total_comp_expense)
- **Correlated:** [`diversity_hire_rate`](#diversity_hire_rate), [`engagement_score`](#engagement_score)

<a id="gmv"></a>
### GMV — `gmv`

Total value of merchandise sold through a marketplace before returns and fees.

- **Vertical:** Finance & FP&A · **Industry:** marketplace
- **Files:** [yml](dbt/models/metrics/finance/gmv.yml) · [sql](dbt/analyses/metrics/finance/gmv.sql)
- **Numerator:** SUM(transaction_value)
- **Dimensions:** category, channel, seller_id, period
- **Data sources:** Marketplace platform, ERP
- **Parents:** [`revenue`](#revenue), [`take_rate`](#take_rate)
- **Children:** [`stg_revenue_event_amount`](#stg_revenue_event_amount), [`liquidity_rate`](#liquidity_rate), [`marketplace_buyers`](#marketplace_buyers), [`marketplace_sellers`](#marketplace_sellers)
- **Correlated:** [`revenue`](#revenue), [`take_rate`](#take_rate)

<a id="graduation_rate"></a>
### 4-Year Graduation Rate — `graduation_rate`

% of students graduating within 4 years of entering 9th grade.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/graduation_rate.yml) · [sql](dbt/analyses/metrics/finance/graduation_rate.sql)
- **Numerator:** Students graduating in 4 years
- **Denominator:** 9th-grade cohort size
- **Dimensions:** school_id, cohort_year, subgroup
- **Data sources:** SIS, State longitudinal data system
- **Parents:** [`student_proficiency`](#student_proficiency), [`college_enrollment`](#college_enrollment)
- **Children:** [`advanced_course_enrollment_rate`](#advanced_course_enrollment_rate), [`credit_accumulation_rate`](#credit_accumulation_rate)
- **Correlated:** [`attendance_rate`](#attendance_rate), [`student_proficiency`](#student_proficiency), [`college_enrollment`](#college_enrollment), [`credit_accumulation_rate`](#credit_accumulation_rate), [`enrollment_count`](#enrollment_count), [`fafsa_completion_rate`](#fafsa_completion_rate)

<a id="gross_margin"></a>
### Gross Margin — `gross_margin`

Revenue minus COGS as a percentage of revenue.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/gross_margin.yml) · [sql](dbt/analyses/metrics/finance/gross_margin.sql)
- **Numerator:** Revenue − COGS
- **Denominator:** Revenue
- **Dimensions:** company_id, product_line, fiscal_period
- **Data sources:** ERP, Cost accounting system
- **Parents:** [`ebitda`](#ebitda), [`payback_period`](#payback_period)
- **Children:** [`cogs`](#cogs), [`cost_per_unit`](#cost_per_unit), [`gross_margin_by_segment`](#gross_margin_by_segment)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`asp`](#asp), [`gross_margin_by_segment`](#gross_margin_by_segment), [`net_income_margin`](#net_income_margin), [`procurement_savings_rate`](#procurement_savings_rate)

<a id="gross_margin_by_segment"></a>
### Gross Margin by Segment — `gross_margin_by_segment`

Gross profit as a % of revenue disaggregated by customer or product segment.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/gross_margin_by_segment.yml) · [sql](dbt/analyses/metrics/finance/gross_margin_by_segment.sql)
- **Numerator:** Revenue - COGS
- **Denominator:** Revenue
- **Dimensions:** segment, product_line, channel, fiscal_period
- **Data sources:** ERP
- **Parents:** [`gross_margin`](#gross_margin)
- **Children:** [`gross_profit`](#gross_profit), [`cogs`](#cogs)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`gross_margin`](#gross_margin)

<a id="gross_margin_pct"></a>
### Gross Margin % — `gross_margin_pct`

Gross profit as a percentage of revenue

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/gross_margin_pct.yml) · [sql](dbt/analyses/metrics/finance/gross_margin_pct.sql)
- **Numerator:** Gross Profit
- **Denominator:** Revenue
- **Dimensions:** date, product_line
- **Data sources:** orders, cogs
- **Parents:** [`ebitda`](#ebitda), [`cac_payback`](#cac_payback)
- **Children:** [`gross_profit`](#gross_profit)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`net_margin`](#net_margin), [`cogs_stg`](#cogs_stg), [`gross_profit`](#gross_profit), [`ops_efficiency_ratio`](#ops_efficiency_ratio), [`revenue_by_product`](#revenue_by_product)

<a id="gross_profit"></a>
### Gross Profit — `gross_profit`

Revenue minus COGS — contribution before operating expenses.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/gross_profit.yml) · [sql](dbt/analyses/metrics/finance/gross_profit.sql)
- **Numerator:** Revenue
- **Denominator:** COGS
- **Dimensions:** date, product_line
- **Data sources:** orders, cogs
- **Parents:** [`ebitda`](#ebitda), [`gross_margin_pct`](#gross_margin_pct), [`gross_margin_by_segment`](#gross_margin_by_segment), [`gross_profit_per_employee`](#gross_profit_per_employee)
- **Children:** [`cogs_stg`](#cogs_stg)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`gross_margin_pct`](#gross_margin_pct), [`gross_profit_per_employee`](#gross_profit_per_employee)

<a id="gross_profit_per_employee"></a>
### GP / Employee — `gross_profit_per_employee`

Gross profit divided by headcount — productivity indicator

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/gross_profit_per_employee.yml) · [sql](dbt/analyses/metrics/finance/gross_profit_per_employee.sql)
- **Numerator:** Gross Profit
- **Denominator:** Headcount
- **Dimensions:** date
- **Data sources:** income_statement, employees
- **Parents:** [`employee_lifetime_value`](#employee_lifetime_value)
- **Children:** [`gross_profit`](#gross_profit)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`revenue_per_employee`](#revenue_per_employee), [`workforce_productivity`](#workforce_productivity), [`gross_profit`](#gross_profit)

<a id="instructional_spend_ratio"></a>
### Instructional Spend % — `instructional_spend_ratio`

Percentage of operating budget spent directly on instruction

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/instructional_spend_ratio.yml) · [sql](dbt/analyses/metrics/finance/instructional_spend_ratio.sql)
- **Numerator:** Instructional spending
- **Denominator:** Total expenditure
- **Dimensions:** school_year
- **Data sources:** finance
- **Parents:** [`per_pupil_expenditure`](#per_pupil_expenditure)
- **Correlated:** [`per_pupil_expenditure`](#per_pupil_expenditure), [`ela_proficiency_rate`](#ela_proficiency_rate)

<a id="interest_coverage"></a>
### Interest Coverage — `interest_coverage`

EBIT divided by interest expense — ability to service debt

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/interest_coverage.yml) · [sql](dbt/analyses/metrics/finance/interest_coverage.sql)
- **Numerator:** EBIT
- **Denominator:** Interest Expense
- **Dimensions:** date
- **Data sources:** income_statement
- **Parents:** [`return_on_equity`](#return_on_equity)
- **Children:** [`ebit`](#ebit), [`total_debt`](#total_debt), [`interest_coverage_ratio`](#interest_coverage_ratio)
- **Correlated:** [`debt_to_equity`](#debt_to_equity), [`leverage_ratio`](#leverage_ratio), [`total_debt`](#total_debt)

<a id="interest_coverage_ratio"></a>
### Interest Coverage Ratio — `interest_coverage_ratio`

EBIT divided by interest expense — ability to service debt. <1.5x is distress signal.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/interest_coverage_ratio.yml) · [sql](dbt/analyses/metrics/finance/interest_coverage_ratio.sql)
- **Numerator:** EBIT
- **Denominator:** Interest Expense
- **Dimensions:** company_id, fiscal_period
- **Data sources:** Income statement, ERP
- **Parents:** [`interest_coverage`](#interest_coverage)
- **Formula inputs:** [`ebitda`](#ebitda)
- **Correlated:** [`debt_ebitda`](#debt_ebitda), [`free_cash_flow`](#free_cash_flow)

<a id="internal_promotion_rate"></a>
### Internal Promotion Rate — `internal_promotion_rate`

% of open roles filled by internal candidates — talent pipeline health.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/internal_promotion_rate.yml) · [sql](dbt/analyses/metrics/finance/internal_promotion_rate.sql)
- **Numerator:** Internal Hires
- **Denominator:** Total Hires
- **Dimensions:** department, job_level, period
- **Data sources:** HRIS, ATS
- **Parents:** [`employee_attrition_rate`](#employee_attrition_rate)
- **Children:** [`stg_job_requisition_row`](#stg_job_requisition_row)
- **Correlated:** [`employee_attrition_rate`](#employee_attrition_rate), [`time_to_fill`](#time_to_fill), [`span_of_control`](#span_of_control), [`training_hours_per_employee`](#training_hours_per_employee)

<a id="interview_to_offer_rate"></a>
### Interview-to-Offer % — `interview_to_offer_rate`

Percentage of final-round interviews that resulted in an offer

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/interview_to_offer_rate.yml) · [sql](dbt/analyses/metrics/finance/interview_to_offer_rate.sql)
- **Numerator:** Offers extended
- **Denominator:** Final round interviews
- **Dimensions:** date, department
- **Data sources:** ats
- **Parents:** [`time_to_hire`](#time_to_hire)
- **Correlated:** [`offer_acceptance_rate`](#offer_acceptance_rate), [`time_to_hire`](#time_to_hire)

<a id="leverage_ratio"></a>
### Leverage Ratio — `leverage_ratio`

Net debt relative to EBITDA — key PE portfolio health metric

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/leverage_ratio.yml) · [sql](dbt/analyses/metrics/finance/leverage_ratio.sql)
- **Numerator:** Net Debt
- **Denominator:** EBITDA
- **Dimensions:** date
- **Data sources:** balance_sheet, income_statement
- **Parents:** [`return_on_equity`](#return_on_equity)
- **Children:** [`net_debt`](#net_debt), [`debt_ebitda`](#debt_ebitda)
- **Formula inputs:** [`ebitda`](#ebitda)
- **Correlated:** [`debt_to_equity`](#debt_to_equity), [`interest_coverage`](#interest_coverage), [`ev_ebitda`](#ev_ebitda), [`total_debt`](#total_debt)

<a id="liquidity_rate"></a>
### Marketplace Liquidity % — `liquidity_rate`

Percentage of listings that resulted in a transaction

- **Vertical:** Finance & FP&A · **Industry:** marketplace
- **Files:** [yml](dbt/models/metrics/finance/liquidity_rate.yml) · [sql](dbt/analyses/metrics/finance/liquidity_rate.sql)
- **Numerator:** Transacting listings
- **Denominator:** Total active listings
- **Dimensions:** date, category
- **Data sources:** marketplace
- **Parents:** [`gmv`](#gmv)
- **Correlated:** [`take_rate`](#take_rate), [`marketplace_sellers`](#marketplace_sellers)

<a id="magic_number"></a>
### Magic Number — `magic_number`

Net new ARR divided by prior quarter S&M spend — go-to-market efficiency

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/magic_number.yml) · [sql](dbt/analyses/metrics/finance/magic_number.sql)
- **Numerator:** Net new ARR × 4
- **Denominator:** S&M spend (prior quarter)
- **Dimensions:** date
- **Data sources:** subscriptions, general_ledger
- **Parents:** [`rule_of_40`](#rule_of_40)
- **Children:** [`new_arr`](#new_arr), [`sm_spend`](#sm_spend)
- **Correlated:** [`cac_payback`](#cac_payback), [`cac`](#cac), [`ltv_cac`](#ltv_cac), [`payback_ratio`](#payback_ratio)

<a id="manager_effectiveness_score"></a>
### Manager Effectiveness — `manager_effectiveness_score`

Upward feedback score measuring managerial quality from direct reports.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/manager_effectiveness_score.yml) · [sql](dbt/analyses/metrics/finance/manager_effectiveness_score.sql)
- **Numerator:** AVG(upward feedback scores)
- **Dimensions:** manager_id, department, survey_cycle
- **Data sources:** Performance management system
- **Parents:** [`employee_engagement_score`](#employee_engagement_score)
- **Children:** [`stg_survey_response_row`](#stg_survey_response_row), [`span_of_control`](#span_of_control)
- **Correlated:** [`employee_attrition_rate`](#employee_attrition_rate), [`employee_engagement_score`](#employee_engagement_score)

<a id="market_share"></a>
### Market Share — `market_share`

Company revenue as a percentage of total addressable market

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/market_share.yml) · [sql](dbt/analyses/metrics/finance/market_share.sql)
- **Numerator:** Company revenue
- **Denominator:** Total addressable market
- **Dimensions:** date, region
- **Data sources:** market_analysis
- **Parents:** [`revenue_growth_rate`](#revenue_growth_rate)
- **Children:** [`market_penetration_rate`](#market_penetration_rate)
- **Correlated:** [`revenue_growth_rate`](#revenue_growth_rate), [`tam`](#tam), [`revenue_by_region`](#revenue_by_region), [`sam`](#sam)

<a id="marketing_influenced_pipeline"></a>
### Mktg Influenced Pipeline — `marketing_influenced_pipeline`

Total pipeline ARR where marketing had at least one touchpoint before opportunity creation.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/marketing_influenced_pipeline.yml) · [sql](dbt/analyses/metrics/finance/marketing_influenced_pipeline.sql)
- **Numerator:** SUM(arr_value of influenced opportunities)
- **Dimensions:** channel, campaign, segment, period
- **Data sources:** CRM, Attribution model
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Children:** [`stg_opportunity_row`](#stg_opportunity_row)
- **Correlated:** [`pipeline_value`](#pipeline_value), [`roas`](#roas)

<a id="marketing_spend"></a>
### Marketing Spend — `marketing_spend`

Total paid and owned marketing spend in the period.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/marketing_spend.yml) · [sql](dbt/analyses/metrics/finance/marketing_spend.sql)
- **Numerator:** SUM(spend)
- **Dimensions:** channel, campaign, period
- **Data sources:** Ad platforms, Finance
- **Parents:** [`cac`](#cac), [`cost_per_mql`](#cost_per_mql), [`cost_per_sql`](#cost_per_sql), [`cpm`](#cpm), [`roas`](#roas)
- **Children:** [`stg_ad_spend_row`](#stg_ad_spend_row)
- **Correlated:** [`revenue`](#revenue), [`mrr`](#mrr), [`sales_spend`](#sales_spend)

<a id="mtbf"></a>
### MTBF — `mtbf`

Mean Time Between Failures — average operating time between unplanned stoppages.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/mtbf.yml) · [sql](dbt/analyses/metrics/finance/mtbf.sql)
- **Numerator:** Total Uptime Hours
- **Denominator:** Number of Failures
- **Dimensions:** system_id, facility_id, period
- **Data sources:** CMMS, SCADA
- **Parents:** [`system_uptime`](#system_uptime)
- **Children:** [`stg_downtime_event_row`](#stg_downtime_event_row), [`preventive_maintenance_rate`](#preventive_maintenance_rate)
- **Correlated:** [`preventive_maintenance_rate`](#preventive_maintenance_rate), [`system_uptime`](#system_uptime)

<a id="mttd"></a>
### MTTD — `mttd`

Average hours from incident start to detection

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/mttd.yml) · [sql](dbt/analyses/metrics/finance/mttd.sql)
- **Numerator:** Sum of detection times
- **Denominator:** Number of incidents
- **Dimensions:** date
- **Data sources:** monitoring
- **Parents:** [`uptime`](#uptime)
- **Children:** [`incident_count`](#incident_count), [`stg_error_event_row`](#stg_error_event_row)
- **Correlated:** [`mttr`](#mttr), [`error_rate`](#error_rate), [`incident_count`](#incident_count)

<a id="mttr"></a>
### MTTR — `mttr`

Mean Time to Repair — average time to restore equipment after failure.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/mttr.yml) · [sql](dbt/analyses/metrics/finance/mttr.sql)
- **Numerator:** Sum of resolution times
- **Denominator:** Number of incidents
- **Dimensions:** date
- **Data sources:** incident_management
- **Parents:** [`system_uptime`](#system_uptime)
- **Children:** [`incident_count`](#incident_count)
- **Correlated:** [`mttd`](#mttd), [`uptime`](#uptime), [`change_failure_rate`](#change_failure_rate), [`incident_count`](#incident_count), [`rcr_rate`](#rcr_rate)

<a id="net_debt"></a>
### Net Debt — `net_debt`

Total debt minus cash and equivalents

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/net_debt.yml) · [sql](dbt/analyses/metrics/finance/net_debt.sql)
- **Numerator:** Total Debt − Cash
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`enterprise_value`](#enterprise_value), [`leverage_ratio`](#leverage_ratio)
- **Children:** [`total_debt`](#total_debt), [`cash_and_equivalents`](#cash_and_equivalents)
- **Correlated:** [`current_ratio`](#current_ratio), [`runway_months`](#runway_months), [`shareholder_equity`](#shareholder_equity)

<a id="net_income"></a>
### Net Income — `net_income`

Bottom-line profit after all expenses and taxes.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/net_income.yml) · [sql](dbt/analyses/metrics/finance/net_income.sql)
- **Numerator:** Revenue - All Expenses - Taxes
- **Dimensions:** company_id, fiscal_period
- **Data sources:** Income statement, ERP
- **Parents:** [`return_on_equity`](#return_on_equity), [`net_income_margin`](#net_income_margin), [`net_margin`](#net_margin), [`operating_cash_flow`](#operating_cash_flow), [`roa`](#roa), [`roe`](#roe), [`roic`](#roic)
- **Children:** [`effective_tax_rate`](#effective_tax_rate)
- **Formula inputs:** [`ebitda`](#ebitda)
- **Correlated:** [`free_cash_flow`](#free_cash_flow), [`ebitda`](#ebitda)

<a id="net_income_margin"></a>
### Net Income Margin — `net_income_margin`

Net income as a % of revenue — bottom-line profitability.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/net_income_margin.yml) · [sql](dbt/analyses/metrics/finance/net_income_margin.sql)
- **Numerator:** Net Income
- **Denominator:** Revenue
- **Dimensions:** company_id, fiscal_period
- **Data sources:** Income statement
- **Parents:** [`return_on_equity`](#return_on_equity)
- **Children:** [`net_income`](#net_income), [`revenue`](#revenue)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`gross_margin`](#gross_margin)

<a id="net_margin"></a>
### Net Margin % — `net_margin`

Net income as a percentage of revenue

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/net_margin.yml) · [sql](dbt/analyses/metrics/finance/net_margin.sql)
- **Numerator:** Net Income
- **Denominator:** Revenue
- **Dimensions:** date
- **Data sources:** income_statement
- **Parents:** [`return_on_equity`](#return_on_equity)
- **Children:** [`net_income`](#net_income)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`gross_margin_pct`](#gross_margin_pct), [`ebitda_margin`](#ebitda_margin)

<a id="net_new_customers"></a>
### Net New Customers — `net_new_customers`

New customers acquired minus churned customers

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/net_new_customers.yml) · [sql](dbt/analyses/metrics/finance/net_new_customers.sql)
- **Numerator:** New customers − Churned customers
- **Dimensions:** date, channel
- **Data sources:** crm, orders
- **Parents:** [`marketing_cac`](#marketing_cac)
- **Children:** [`monthly_new_customers`](#monthly_new_customers), [`customer_churn_rate`](#customer_churn_rate)
- **Correlated:** [`arr_growth_rate`](#arr_growth_rate), [`cac`](#cac), [`customer_count`](#customer_count), [`stg_customer_count`](#stg_customer_count)

<a id="new_user_signups"></a>
### New Signups — `new_user_signups`

Count of new user account registrations in the period.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/new_user_signups.yml) · [sql](dbt/analyses/metrics/finance/new_user_signups.sql)
- **Numerator:** COUNT(new user registrations)
- **Dimensions:** acquisition_channel, plan_tier, geography, period
- **Data sources:** Product database, CRM
- **Parents:** [`mau`](#mau)
- **Children:** [`stg_user_event_row`](#stg_user_event_row), [`app_downloads`](#app_downloads), [`viral_coefficient`](#viral_coefficient)
- **Correlated:** [`activation_rate`](#activation_rate), [`mql_count`](#mql_count)

<a id="offer_acceptance_rate"></a>
### Offer Acceptance Rate — `offer_acceptance_rate`

% of job offers accepted by candidates.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/offer_acceptance_rate.yml) · [sql](dbt/analyses/metrics/finance/offer_acceptance_rate.sql)
- **Numerator:** Accepted offers
- **Denominator:** Offers extended
- **Dimensions:** date, department
- **Data sources:** ats
- **Parents:** [`time_to_fill`](#time_to_fill)
- **Children:** [`recruiting_pipeline`](#recruiting_pipeline), [`new_hires`](#new_hires)
- **Correlated:** [`time_to_hire`](#time_to_hire), [`interview_to_offer_rate`](#interview_to_offer_rate), [`recruiting_pipeline`](#recruiting_pipeline)

<a id="operating_cash_flow"></a>
### Operating Cash Flow — `operating_cash_flow`

Cash generated from core business operations

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/operating_cash_flow.yml) · [sql](dbt/analyses/metrics/finance/operating_cash_flow.sql)
- **Numerator:** Net income + D&A − working capital changes
- **Dimensions:** date
- **Data sources:** cash_flow_statement
- **Parents:** [`free_cash_flow`](#free_cash_flow)
- **Children:** [`net_income`](#net_income), [`da`](#da), [`deferred_revenue`](#deferred_revenue)
- **Correlated:** [`ebitda`](#ebitda), [`free_cash_flow`](#free_cash_flow)

<a id="opex"></a>
### OpEx — `opex`

Total operating expenses excluding COGS in a period.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/opex.yml) · [sql](dbt/analyses/metrics/finance/opex.sql)
- **Numerator:** Total operating expenses
- **Dimensions:** date, department
- **Data sources:** general_ledger
- **Parents:** [`ebitda`](#ebitda), [`burn_rate`](#burn_rate), [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Children:** [`sg_and_a`](#sg_and_a), [`total_comp_expense`](#total_comp_expense), [`ga_spend_pct`](#ga_spend_pct), [`gna_pct_revenue`](#gna_pct_revenue), [`headcount_cost`](#headcount_cost), [`hr_cost_pct_revenue`](#hr_cost_pct_revenue), [`rd_as_pct_revenue`](#rd_as_pct_revenue), [`rd_expense`](#rd_expense), [`rd_spend_pct`](#rd_spend_pct), [`stg_opex_line`](#stg_opex_line)
- **Correlated:** [`ga_spend_pct`](#ga_spend_pct), [`rd_spend_pct`](#rd_spend_pct), [`annual_budget`](#annual_budget), [`budget_variance`](#budget_variance), [`budget_variance_pct`](#budget_variance_pct), [`gna_pct_revenue`](#gna_pct_revenue), [`headcount_fte`](#headcount_fte), [`headcount_vs_budget`](#headcount_vs_budget), [`hr_cost_pct_revenue`](#hr_cost_pct_revenue)

<a id="order_accuracy_rate"></a>
### Order Accuracy Rate — `order_accuracy_rate`

% of orders shipped without errors (wrong item, quantity, or address).

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/order_accuracy_rate.yml) · [sql](dbt/analyses/metrics/finance/order_accuracy_rate.sql)
- **Numerator:** Error-Free Orders
- **Denominator:** Total Orders Shipped
- **Dimensions:** warehouse_id, carrier, period
- **Data sources:** WMS, Customer service system
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Children:** [`stg_shipment_row`](#stg_shipment_row)
- **Correlated:** [`fill_rate`](#fill_rate), [`on_time_delivery_rate`](#on_time_delivery_rate), [`defect_rate`](#defect_rate), [`return_rate`](#return_rate)

<a id="paid_attribution_pct"></a>
### Paid Attribution % — `paid_attribution_pct`

Percentage of closed revenue attributed to paid channels

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/paid_attribution_pct.yml) · [sql](dbt/analyses/metrics/finance/paid_attribution_pct.sql)
- **Numerator:** Paid-attributed pipeline
- **Denominator:** Total pipeline
- **Dimensions:** date, channel
- **Data sources:** ad_platforms, crm
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Children:** [`stg_ad_spend`](#stg_ad_spend)
- **Formula inputs:** [`mql`](#mql)
- **Correlated:** [`organic_attribution_pct`](#organic_attribution_pct), [`roas`](#roas)

<a id="paid_sessions"></a>
### Paid Sessions — `paid_sessions`

Web sessions from paid advertising channels (CPC, CPM).

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/paid_sessions.yml) · [sql](dbt/analyses/metrics/finance/paid_sessions.sql)
- **Numerator:** COUNT(sessions WHERE medium = 'cpc' or 'paid')
- **Dimensions:** channel, campaign, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`website_sessions`](#website_sessions)
- **Children:** [`stg_session_row`](#stg_session_row)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`roas`](#roas)

<a id="payback_period"></a>
### CAC Payback Period — `payback_period`

Months to recover CAC from gross margin contribution — capital efficiency lens.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/payback_period.yml) · [sql](dbt/analyses/metrics/finance/payback_period.sql)
- **Numerator:** CAC
- **Denominator:** MRR × Gross Margin %
- **Dimensions:** segment, channel, cohort
- **Data sources:** CRM, Billing system
- **Parents:** [`ltv_cac`](#ltv_cac)
- **Children:** [`cac`](#cac), [`mrr`](#mrr), [`gross_margin`](#gross_margin)
- **Correlated:** [`churn_rate`](#churn_rate), [`arr`](#arr)

<a id="payback_ratio"></a>
### Payback Ratio — `payback_ratio`

LTV to CAC ratio — measure of long-term unit economics

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/payback_ratio.yml) · [sql](dbt/analyses/metrics/finance/payback_ratio.sql)
- **Numerator:** CAC
- **Denominator:** Monthly gross profit per customer
- **Dimensions:** date, channel
- **Data sources:** subscriptions, general_ledger
- **Parents:** [`ltv_cac`](#ltv_cac)
- **Children:** [`cac`](#cac), [`arpu`](#arpu)
- **Correlated:** [`cac_payback`](#cac_payback), [`ltv_cac`](#ltv_cac), [`magic_number`](#magic_number)

<a id="per_pupil_expenditure"></a>
### Per Pupil Expenditure — `per_pupil_expenditure`

Total operating spend divided by average daily membership.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/per_pupil_expenditure.yml) · [sql](dbt/analyses/metrics/finance/per_pupil_expenditure.sql)
- **Numerator:** Total expenditures
- **Denominator:** Average daily membership (ADM)
- **Dimensions:** school_id, fiscal_year, function_code, fund
- **Data sources:** Finance system (Infinite Visions / QuickBooks), State reporting
- **Parents:** [`cost_per_outcome`](#cost_per_outcome), [`student_proficiency`](#student_proficiency)
- **Children:** [`enrollment_count`](#enrollment_count), [`instructional_spend_ratio`](#instructional_spend_ratio), [`seat_fill_rate`](#seat_fill_rate), [`staff_student_cost_ratio`](#staff_student_cost_ratio), [`student_teacher_ratio`](#student_teacher_ratio), [`teacher_student_ratio`](#teacher_student_ratio)
- **Correlated:** [`attendance_rate`](#attendance_rate), [`adm`](#adm), [`cost_per_outcome`](#cost_per_outcome), [`frl_pct`](#frl_pct), [`iep_pct`](#iep_pct), [`instructional_spend_ratio`](#instructional_spend_ratio), [`school_enrollment`](#school_enrollment), [`seat_fill_rate`](#seat_fill_rate), [`staff_student_cost_ratio`](#staff_student_cost_ratio), [`student_teacher_ratio`](#student_teacher_ratio)

<a id="pipeline_coverage"></a>
### Pipeline Coverage — `pipeline_coverage`

Total qualified pipeline divided by quota — leading indicator of quota achievement.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/pipeline_coverage.yml) · [sql](dbt/analyses/metrics/finance/pipeline_coverage.sql)
- **Numerator:** Qualified Pipeline Value
- **Denominator:** Remaining Quota for Period
- **Dimensions:** team, segment, period
- **Data sources:** CRM
- **Parents:** [`new_arr`](#new_arr)
- **Children:** [`pipeline_value`](#pipeline_value), [`quota_attainment`](#quota_attainment)
- **Correlated:** [`win_rate`](#win_rate), [`new_arr`](#new_arr), [`avg_deal_size`](#avg_deal_size), [`pipeline_generated`](#pipeline_generated)

<a id="pipeline_value"></a>
### Pipeline Value — `pipeline_value`

Total ARR value of open opportunities in the pipeline.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/pipeline_value.yml) · [sql](dbt/analyses/metrics/finance/pipeline_value.sql)
- **Numerator:** SUM(arr_value) WHERE stage NOT IN ('Closed Won','Closed Lost')
- **Dimensions:** segment, stage, rep_id, period
- **Data sources:** CRM
- **Parents:** [`pipeline_coverage`](#pipeline_coverage)
- **Children:** [`stg_opportunity_row`](#stg_opportunity_row), [`sql_count`](#sql_count)
- **Correlated:** [`new_arr`](#new_arr), [`win_rate`](#win_rate), [`marketing_influenced_pipeline`](#marketing_influenced_pipeline)

<a id="plg_rate"></a>
### PLG Rate — `plg_rate`

Percentage of new signups coming from product-driven virality (invites, sharing)

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/plg_rate.yml) · [sql](dbt/analyses/metrics/finance/plg_rate.sql)
- **Numerator:** Self-serve signups
- **Denominator:** Total new signups
- **Dimensions:** date
- **Data sources:** users, subscriptions
- **Parents:** [`new_arr`](#new_arr)
- **Children:** [`trial_signups`](#trial_signups), [`free_to_paid_rate`](#free_to_paid_rate), [`trial_to_paid_rate`](#trial_to_paid_rate)
- **Correlated:** [`viral_coefficient`](#viral_coefficient), [`trial_to_paid_rate`](#trial_to_paid_rate)

<a id="preventive_maintenance_rate"></a>
### Preventive Maintenance Rate — `preventive_maintenance_rate`

% of maintenance activity that is planned preventive vs reactive.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/preventive_maintenance_rate.yml) · [sql](dbt/analyses/metrics/finance/preventive_maintenance_rate.sql)
- **Numerator:** Preventive Work Orders
- **Denominator:** Total Work Orders
- **Dimensions:** facility_id, asset_type, period
- **Data sources:** CMMS
- **Parents:** [`mtbf`](#mtbf)
- **Children:** [`stg_work_order_row`](#stg_work_order_row)
- **Correlated:** [`work_order_resolution_time`](#work_order_resolution_time), [`mtbf`](#mtbf), [`system_uptime`](#system_uptime)

<a id="push_open_rate"></a>
### Push Open Rate — `push_open_rate`

Percentage of push notifications that were opened

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/push_open_rate.yml) · [sql](dbt/analyses/metrics/finance/push_open_rate.sql)
- **Numerator:** Push notification opens
- **Denominator:** Delivered notifications
- **Dimensions:** date, campaign
- **Data sources:** push_platform
- **Parents:** [`dau`](#dau)
- **Correlated:** [`email_open_rate`](#email_open_rate), [`dau_mau_ratio`](#dau_mau_ratio)

<a id="quick_ratio"></a>
### Quick Ratio — `quick_ratio`

(Cash + Receivables) / Current Liabilities — excludes inventory from liquidity test.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/quick_ratio.yml) · [sql](dbt/analyses/metrics/finance/quick_ratio.sql)
- **Numerator:** Cash + Accounts Receivable
- **Denominator:** Current Liabilities
- **Dimensions:** company_id, quarter
- **Data sources:** Balance sheet
- **Parents:** [`working_capital`](#working_capital)
- **Correlated:** [`current_ratio`](#current_ratio), [`working_capital`](#working_capital)

<a id="quota_attainment"></a>
### Quota Attainment — `quota_attainment`

Sales rep ARR closed as a % of their assigned quota.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/quota_attainment.yml) · [sql](dbt/analyses/metrics/finance/quota_attainment.sql)
- **Numerator:** ARR Closed
- **Denominator:** Quota
- **Dimensions:** rep_id, segment, period
- **Data sources:** CRM, Finance
- **Parents:** [`new_arr`](#new_arr), [`pct_reps_at_quota`](#pct_reps_at_quota), [`pipeline_coverage`](#pipeline_coverage)
- **Children:** [`stg_opportunity_row`](#stg_opportunity_row)
- **Correlated:** [`win_rate`](#win_rate), [`new_arr`](#new_arr), [`arr_per_rep`](#arr_per_rep), [`pct_reps_at_quota`](#pct_reps_at_quota), [`sales_headcount`](#sales_headcount)

<a id="rd_expense"></a>
### R&D Expense — `rd_expense`

Research and development spend in the period.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/rd_expense.yml) · [sql](dbt/analyses/metrics/finance/rd_expense.sql)
- **Numerator:** SUM(opex_amount WHERE gl_category = 'R&D')
- **Dimensions:** company_id, department, fiscal_period
- **Data sources:** ERP, General Ledger
- **Parents:** [`opex`](#opex), [`rd_as_pct_revenue`](#rd_as_pct_revenue)
- **Correlated:** [`rd_as_pct_revenue`](#rd_as_pct_revenue), [`capex`](#capex)

<a id="rd_spend_pct"></a>
### R&D % of Revenue — `rd_spend_pct`

Research and development expense as a proportion of revenue

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/rd_spend_pct.yml) · [sql](dbt/analyses/metrics/finance/rd_spend_pct.sql)
- **Numerator:** R&D spend
- **Denominator:** Revenue
- **Dimensions:** date
- **Data sources:** general_ledger
- **Parents:** [`opex`](#opex)
- **Correlated:** [`rd_headcount_pct`](#rd_headcount_pct), [`ebitda_margin`](#ebitda_margin), [`opex`](#opex)

<a id="referral_attribution_pct"></a>
### Referral Attribution % — `referral_attribution_pct`

Percentage of closed revenue attributed to referral channels

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/referral_attribution_pct.yml) · [sql](dbt/analyses/metrics/finance/referral_attribution_pct.sql)
- **Numerator:** Referral-attributed pipeline
- **Denominator:** Total pipeline
- **Dimensions:** date
- **Data sources:** crm, referrals
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Formula inputs:** [`mql`](#mql)
- **Correlated:** [`organic_attribution_pct`](#organic_attribution_pct), [`viral_coefficient`](#viral_coefficient)

<a id="return_on_assets"></a>
### Return on Assets — `return_on_assets`

Net income divided by total assets — asset efficiency measure.

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/return_on_assets.yml) · [sql](dbt/analyses/metrics/finance/return_on_assets.sql)
- **Numerator:** Net Income
- **Denominator:** Total Assets
- **Dimensions:** company_id, fiscal_period
- **Data sources:** Income statement, Balance sheet
- **Parents:** [`return_on_equity`](#return_on_equity)
- **Correlated:** [`return_on_equity`](#return_on_equity), [`debt_ebitda`](#debt_ebitda)

<a id="rev_concentration_top10"></a>
### Top 10 Customer Rev % — `rev_concentration_top10`

Percentage of total revenue from the top 10 customers

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/rev_concentration_top10.yml) · [sql](dbt/analyses/metrics/finance/rev_concentration_top10.sql)
- **Numerator:** Revenue from top 10 customers
- **Denominator:** Total revenue
- **Dimensions:** date
- **Data sources:** orders, customers
- **Parents:** [`customer_concentration_risk`](#customer_concentration_risk)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`customer_concentration_risk`](#customer_concentration_risk), [`nrr`](#nrr)

<a id="rev_from_existing"></a>
### Existing Customer Revenue — `rev_from_existing`

Revenue from customers acquired prior to the current period

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/rev_from_existing.yml) · [sql](dbt/analyses/metrics/finance/rev_from_existing.sql)
- **Numerator:** Revenue from existing customers
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Correlated:** [`nrr`](#nrr), [`expansion_arr`](#expansion_arr)

<a id="rev_from_new_customers"></a>
### New Customer Revenue — `rev_from_new_customers`

Revenue from customers acquired in the period

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/rev_from_new_customers.yml) · [sql](dbt/analyses/metrics/finance/rev_from_new_customers.sql)
- **Numerator:** Revenue from new customer acquisitions
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Correlated:** [`cac`](#cac), [`new_arr`](#new_arr)

<a id="review_rating"></a>
### Review Rating — `review_rating`

Average rating on third-party review platforms (out of 5)

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/review_rating.yml) · [sql](dbt/analyses/metrics/finance/review_rating.sql)
- **Numerator:** Average review score
- **Dimensions:** date, platform
- **Data sources:** review_platforms
- **Parents:** [`nps`](#nps)
- **Correlated:** [`nps`](#nps), [`csat`](#csat), [`app_store_rating`](#app_store_rating), [`testimonials_count`](#testimonials_count)

<a id="roa"></a>
### ROA — `roa`

Net income as a percentage of total assets

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/roa.yml) · [sql](dbt/analyses/metrics/finance/roa.sql)
- **Numerator:** Net Income
- **Denominator:** Total Assets
- **Dimensions:** date
- **Data sources:** income_statement, balance_sheet
- **Parents:** [`return_on_equity`](#return_on_equity)
- **Children:** [`net_income`](#net_income), [`total_assets`](#total_assets)
- **Correlated:** [`roe`](#roe), [`roic`](#roic)

<a id="roe"></a>
### ROE — `roe`

Net income as a percentage of shareholders equity

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/roe.yml) · [sql](dbt/analyses/metrics/finance/roe.sql)
- **Numerator:** Net Income
- **Denominator:** Shareholders' Equity
- **Dimensions:** date
- **Data sources:** income_statement, balance_sheet
- **Parents:** [`return_on_equity`](#return_on_equity)
- **Children:** [`net_income`](#net_income), [`shareholder_equity`](#shareholder_equity)
- **Correlated:** [`roa`](#roa), [`roic`](#roic), [`shareholder_equity`](#shareholder_equity)

<a id="roic"></a>
### ROIC — `roic`

NOPAT divided by invested capital

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/roic.yml) · [sql](dbt/analyses/metrics/finance/roic.sql)
- **Numerator:** NOPAT
- **Denominator:** Invested Capital
- **Dimensions:** date
- **Data sources:** income_statement, balance_sheet
- **Parents:** [`enterprise_value`](#enterprise_value)
- **Children:** [`net_income`](#net_income), [`total_assets`](#total_assets), [`total_debt`](#total_debt)
- **Correlated:** [`roe`](#roe), [`roa`](#roa)

<a id="runway_months"></a>
### Runway (Months) — `runway_months`

How many months of runway at current burn rate — survival horizon metric.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/runway_months.yml) · [sql](dbt/analyses/metrics/finance/runway_months.sql)
- **Numerator:** Cash on Hand
- **Denominator:** Monthly Burn Rate
- **Dimensions:** company_id, as_of_date
- **Data sources:** Bank statements, Finance
- **Parents:** [`free_cash_flow`](#free_cash_flow)
- **Children:** [`burn_rate`](#burn_rate)
- **Correlated:** [`burn_rate`](#burn_rate), [`free_cash_flow`](#free_cash_flow), [`cash_and_equivalents`](#cash_and_equivalents), [`net_debt`](#net_debt)

<a id="sales_cycle_length"></a>
### Sales Cycle Length — `sales_cycle_length`

Average days from first touch to closed-won opportunity.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/sales_cycle_length.yml) · [sql](dbt/analyses/metrics/finance/sales_cycle_length.sql)
- **Numerator:** SUM(days_to_close)
- **Denominator:** COUNT(closed_won_opportunities)
- **Dimensions:** segment, rep_id, deal_size_tier, period
- **Data sources:** CRM (Salesforce / HubSpot)
- **Parents:** [`new_arr`](#new_arr)
- **Children:** [`stg_opportunity_row`](#stg_opportunity_row)
- **Correlated:** [`cac`](#cac), [`win_rate`](#win_rate)

<a id="sales_spend"></a>
### Sales Spend — `sales_spend`

Total sales team costs including salaries, commissions, and tools.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/sales_spend.yml) · [sql](dbt/analyses/metrics/finance/sales_spend.sql)
- **Numerator:** SUM(sales team headcount cost + tools)
- **Dimensions:** company_id, team, fiscal_period
- **Data sources:** HRIS, ERP
- **Parents:** [`cac`](#cac), [`sg_and_a`](#sg_and_a)
- **Children:** [`stg_payroll_row`](#stg_payroll_row)
- **Correlated:** [`marketing_spend`](#marketing_spend), [`cac`](#cac)

<a id="session_length"></a>
### Avg Session Length — `session_length`

Average duration of user sessions in minutes

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/session_length.yml) · [sql](dbt/analyses/metrics/finance/session_length.sql)
- **Numerator:** Average session duration (minutes)
- **Dimensions:** date, platform
- **Data sources:** sessions
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Correlated:** [`dau_mau_ratio`](#dau_mau_ratio), [`feature_adoption`](#feature_adoption), [`sessions_per_user`](#sessions_per_user), [`stg_sessions_count`](#stg_sessions_count)

<a id="sessions_per_user"></a>
### Sessions / User — `sessions_per_user`

Average number of sessions per active user in the period

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/sessions_per_user.yml) · [sql](dbt/analyses/metrics/finance/sessions_per_user.sql)
- **Numerator:** Sessions
- **Denominator:** Active users
- **Dimensions:** date, platform
- **Data sources:** sessions
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`stg_sessions_count`](#stg_sessions_count)
- **Correlated:** [`dau_mau_ratio`](#dau_mau_ratio), [`session_length`](#session_length)

<a id="sg_and_a"></a>
### SG&A — `sg_and_a`

Sales, general and administrative expenses in the period.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/sg_and_a.yml) · [sql](dbt/analyses/metrics/finance/sg_and_a.sql)
- **Numerator:** SUM(opex_amount WHERE gl_category = 'SG&A')
- **Dimensions:** company_id, department, fiscal_period
- **Data sources:** ERP
- **Parents:** [`opex`](#opex), [`gna_pct_revenue`](#gna_pct_revenue)
- **Children:** [`sales_spend`](#sales_spend)
- **Correlated:** [`ebitda_margin`](#ebitda_margin)

<a id="sgp"></a>
### SGP (Growth) — `sgp`

Median Student Growth Percentile — measures growth relative to academic peers

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/sgp.yml) · [sql](dbt/analyses/metrics/finance/sgp.sql)
- **Numerator:** Student's percentile relative to academic peers
- **Dimensions:** school_year, grade, school
- **Data sources:** assessment_data
- **Parents:** [`ela_proficiency_rate`](#ela_proficiency_rate), [`math_proficiency_rate`](#math_proficiency_rate)
- **Correlated:** [`district_proficiency_rate`](#district_proficiency_rate), [`student_attendance_rate`](#student_attendance_rate), [`student_teacher_ratio`](#student_teacher_ratio)

<a id="share_of_voice"></a>
### Share of Voice — `share_of_voice`

Brand mentions as a % of total category mentions — competitive visibility.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/share_of_voice.yml) · [sql](dbt/analyses/metrics/finance/share_of_voice.sql)
- **Numerator:** Brand Mentions
- **Denominator:** Total Category Mentions
- **Dimensions:** platform, keyword_group, period
- **Data sources:** Social listening tools (Brandwatch / Mention)
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Children:** [`social_followers`](#social_followers), [`earned_media_value`](#earned_media_value), [`social_engagement_rate`](#social_engagement_rate)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`impressions`](#impressions)

<a id="suspension_rate"></a>
### Suspension Rate — `suspension_rate`

% of students who received at least one out-of-school suspension in a year.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/suspension_rate.yml) · [sql](dbt/analyses/metrics/finance/suspension_rate.sql)
- **Numerator:** Students suspended
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school, subgroup
- **Data sources:** discipline
- **Parents:** [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`dropout_rate`](#dropout_rate)
- **Children:** [`expulsion_rate`](#expulsion_rate), [`stg_discipline_row`](#stg_discipline_row)
- **Correlated:** [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`school_climate_score`](#school_climate_score), [`attendance_rate`](#attendance_rate), [`expulsion_rate`](#expulsion_rate)

<a id="take_rate"></a>
### Take Rate — `take_rate`

Platform revenue as a % of GMV — marketplace monetization efficiency.

- **Vertical:** Finance & FP&A · **Industry:** marketplace
- **Files:** [yml](dbt/models/metrics/finance/take_rate.yml) · [sql](dbt/analyses/metrics/finance/take_rate.sql)
- **Numerator:** Platform Revenue (Fees)
- **Denominator:** GMV
- **Dimensions:** category, tier, period
- **Data sources:** Marketplace platform
- **Parents:** [`revenue`](#revenue)
- **Children:** [`gmv`](#gmv)
- **Correlated:** [`gmv`](#gmv), [`revenue`](#revenue), [`liquidity_rate`](#liquidity_rate), [`marketplace_sellers`](#marketplace_sellers)

<a id="tech_debt_ratio"></a>
### Tech Debt Ratio — `tech_debt_ratio`

Estimated remediation cost of tech debt relative to development cost

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/tech_debt_ratio.yml) · [sql](dbt/analyses/metrics/finance/tech_debt_ratio.sql)
- **Numerator:** Technical debt hours
- **Denominator:** Total dev hours
- **Dimensions:** date, service
- **Data sources:** code_analysis
- **Parents:** [`change_failure_rate`](#change_failure_rate)
- **Correlated:** [`code_coverage`](#code_coverage), [`bug_escape_rate`](#bug_escape_rate), [`sprint_velocity`](#sprint_velocity)

<a id="time_to_activate"></a>
### Time to Activate — `time_to_activate`

Median hours from signup to activation event

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/time_to_activate.yml) · [sql](dbt/analyses/metrics/finance/time_to_activate.sql)
- **Numerator:** Days from signup to activation event
- **Dimensions:** date, cohort
- **Data sources:** events, users
- **Parents:** [`activation_rate`](#activation_rate)
- **Correlated:** [`activation_rate`](#activation_rate), [`time_to_value`](#time_to_value)

<a id="time_to_fill"></a>
### Time to Fill — `time_to_fill`

Average days from job posting to offer accepted.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/time_to_fill.yml) · [sql](dbt/analyses/metrics/finance/time_to_fill.sql)
- **Numerator:** SUM(days from open to offer accepted)
- **Denominator:** COUNT(filled roles)
- **Dimensions:** department, job_level, location, period
- **Data sources:** ATS (Greenhouse / Lever)
- **Parents:** [`headcount_vs_budget`](#headcount_vs_budget)
- **Children:** [`stg_job_requisition_row`](#stg_job_requisition_row), [`offer_acceptance_rate`](#offer_acceptance_rate), [`time_to_hire`](#time_to_hire)
- **Correlated:** [`headcount_fte`](#headcount_fte), [`cac`](#cac), [`cost_per_hire`](#cost_per_hire), [`internal_promotion_rate`](#internal_promotion_rate), [`new_hires`](#new_hires), [`open_requisitions`](#open_requisitions), [`time_to_hire`](#time_to_hire)

<a id="time_to_resolution"></a>
### Time to Resolution — `time_to_resolution`

Average total hours from ticket creation to final resolution.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/time_to_resolution.yml) · [sql](dbt/analyses/metrics/finance/time_to_resolution.sql)
- **Numerator:** SUM(resolved_at - created_at)
- **Denominator:** COUNT(resolved tickets)
- **Dimensions:** priority, category, channel, team, period
- **Data sources:** Support platform
- **Parents:** [`csat`](#csat)
- **Children:** [`stg_ticket_row`](#stg_ticket_row)
- **Correlated:** [`first_response_time`](#first_response_time), [`csat`](#csat)

<a id="time_to_value"></a>
### Time to Value — `time_to_value`

Days from signup to first meaningful value event (aha moment).

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/time_to_value.yml) · [sql](dbt/analyses/metrics/finance/time_to_value.sql)
- **Numerator:** SUM(days from signup to value event)
- **Denominator:** COUNT(users who reached value event)
- **Dimensions:** cohort, plan_tier, acquisition_channel
- **Data sources:** Product analytics
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`stg_user_event_row`](#stg_user_event_row), [`onboarding_completion_rate`](#onboarding_completion_rate), [`onboarding_time`](#onboarding_time)
- **Correlated:** [`churn_rate`](#churn_rate), [`feature_adoption_rate`](#feature_adoption_rate), [`activation_rate`](#activation_rate), [`customer_onboarding_time`](#customer_onboarding_time), [`onboarding_time`](#onboarding_time), [`time_to_activate`](#time_to_activate)

<a id="training_hours_per_employee"></a>
### Training Hours / Employee — `training_hours_per_employee`

Average learning and development hours per employee per period.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/training_hours_per_employee.yml) · [sql](dbt/analyses/metrics/finance/training_hours_per_employee.sql)
- **Numerator:** Total Training Hours
- **Denominator:** Average FTE Headcount
- **Dimensions:** department, training_type, period
- **Data sources:** LMS (Learning Management System)
- **Parents:** [`employee_engagement_score`](#employee_engagement_score)
- **Children:** [`stg_employee_row`](#stg_employee_row)
- **Correlated:** [`employee_engagement_score`](#employee_engagement_score), [`internal_promotion_rate`](#internal_promotion_rate)

<a id="trial_to_paid_rate"></a>
### Trial → Paid % — `trial_to_paid_rate`

Percentage of trial users who converted to a paid plan

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/trial_to_paid_rate.yml) · [sql](dbt/analyses/metrics/finance/trial_to_paid_rate.sql)
- **Numerator:** Paid conversions
- **Denominator:** Trial starts
- **Dimensions:** date, cohort
- **Data sources:** users, subscriptions
- **Parents:** [`plg_rate`](#plg_rate)
- **Children:** [`trial_signups`](#trial_signups), [`free_to_paid_rate`](#free_to_paid_rate)
- **Correlated:** [`free_to_paid_rate`](#free_to_paid_rate), [`activation_rate`](#activation_rate), [`plg_rate`](#plg_rate), [`viral_coefficient`](#viral_coefficient)

<a id="unsubscribe_rate"></a>
### Unsubscribe Rate — `unsubscribe_rate`

% of email recipients who unsubscribed — list health signal.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/unsubscribe_rate.yml) · [sql](dbt/analyses/metrics/finance/unsubscribe_rate.sql)
- **Numerator:** Unsubscribes
- **Denominator:** Emails Delivered
- **Dimensions:** campaign_id, segment, period
- **Data sources:** Email platform
- **Parents:** [`mql_count`](#mql_count)
- **Children:** [`stg_email_send_row`](#stg_email_send_row), [`email_unsub_rate`](#email_unsub_rate)
- **Correlated:** [`email_open_rate`](#email_open_rate)

<a id="viral_coefficient"></a>
### Viral Coefficient (K) — `viral_coefficient`

Average number of new customers each existing customer generates

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/viral_coefficient.yml) · [sql](dbt/analyses/metrics/finance/viral_coefficient.sql)
- **Numerator:** Invites sent × conversion rate
- **Dimensions:** date
- **Data sources:** referrals, users
- **Parents:** [`new_user_signups`](#new_user_signups)
- **Children:** [`user_signups`](#user_signups), [`oss_stars`](#oss_stars)
- **Correlated:** [`plg_rate`](#plg_rate), [`trial_to_paid_rate`](#trial_to_paid_rate), [`oss_stars`](#oss_stars), [`referral_attribution_pct`](#referral_attribution_pct)

<a id="web_conversion_rate"></a>
### Web Conversion Rate — `web_conversion_rate`

% of sessions that result in a conversion event (form fill, signup, etc.).

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/web_conversion_rate.yml) · [sql](dbt/analyses/metrics/finance/web_conversion_rate.sql)
- **Numerator:** Conversions
- **Denominator:** Sessions
- **Dimensions:** landing_page, channel, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`mql_count`](#mql_count)
- **Children:** [`website_sessions`](#website_sessions), [`bounce_rate`](#bounce_rate)
- **Correlated:** [`ctr`](#ctr), [`cost_per_mql`](#cost_per_mql), [`ad_clicks`](#ad_clicks), [`bounce_rate`](#bounce_rate), [`email_click_rate`](#email_click_rate), [`organic_sessions`](#organic_sessions), [`website_sessions`](#website_sessions)

<a id="website_sessions"></a>
### Website Sessions — `website_sessions`

Total web sessions across all channels.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/website_sessions.yml) · [sql](dbt/analyses/metrics/finance/website_sessions.sql)
- **Numerator:** COUNT(sessions)
- **Dimensions:** channel, source, medium, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`form_conversion_rate`](#form_conversion_rate), [`session_to_lead_rate`](#session_to_lead_rate), [`web_conversion_rate`](#web_conversion_rate)
- **Children:** [`organic_sessions`](#organic_sessions), [`stg_session_row`](#stg_session_row), [`organic_traffic`](#organic_traffic), [`paid_sessions`](#paid_sessions), [`paid_traffic`](#paid_traffic), [`referral_sessions`](#referral_sessions), [`stg_page_view_row`](#stg_page_view_row), [`stg_page_views`](#stg_page_views)
- **Correlated:** [`mql_count`](#mql_count), [`web_conversion_rate`](#web_conversion_rate), [`bounce_rate`](#bounce_rate), [`stg_page_views`](#stg_page_views)

<a id="win_rate"></a>
### Win Rate — `win_rate`

% of qualified opportunities that close as won.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/win_rate.yml) · [sql](dbt/analyses/metrics/finance/win_rate.sql)
- **Numerator:** Closed Won Opportunities
- **Denominator:** Total Qualified Opportunities
- **Dimensions:** segment, rep_id, source, period
- **Data sources:** CRM
- **Parents:** [`new_arr`](#new_arr)
- **Children:** [`stg_opportunity_row`](#stg_opportunity_row), [`competitive_win_rate`](#competitive_win_rate)
- **Correlated:** [`sales_cycle_length`](#sales_cycle_length), [`cac`](#cac), [`avg_sales_cycle`](#avg_sales_cycle), [`competitive_win_rate`](#competitive_win_rate), [`mql_to_sql_rate`](#mql_to_sql_rate), [`pct_reps_at_quota`](#pct_reps_at_quota), [`pipeline_coverage`](#pipeline_coverage), [`pipeline_value`](#pipeline_value), [`quota_attainment`](#quota_attainment), [`sales_cycle_by_segment`](#sales_cycle_by_segment), [`sql`](#sql), [`sql_count`](#sql_count)

<a id="work_order_resolution_time"></a>
### Work Order Resolution Time — `work_order_resolution_time`

Average days to close a maintenance work order from creation.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/work_order_resolution_time.yml) · [sql](dbt/analyses/metrics/finance/work_order_resolution_time.sql)
- **Numerator:** SUM(completed_date - created_date)
- **Denominator:** COUNT(completed work orders)
- **Dimensions:** facility_id, category, priority, period
- **Data sources:** CMMS
- **Parents:** [`system_uptime`](#system_uptime)
- **Children:** [`stg_work_order_row`](#stg_work_order_row)
- **Correlated:** [`preventive_maintenance_rate`](#preventive_maintenance_rate)

<a id="workforce_productivity"></a>
### Workforce Productivity — `workforce_productivity`

Output or revenue generated per labor hour worked

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/workforce_productivity.yml) · [sql](dbt/analyses/metrics/finance/workforce_productivity.sql)
- **Numerator:** Revenue
- **Denominator:** Labor hours worked
- **Dimensions:** date, department
- **Data sources:** hris, orders
- **Parents:** [`employee_lifetime_value`](#employee_lifetime_value)
- **Children:** [`absenteeism_rate`](#absenteeism_rate), [`overtime_hours`](#overtime_hours), [`safety_incident_rate`](#safety_incident_rate)
- **Formula inputs:** [`headcount`](#headcount), [`total_revenue`](#total_revenue)
- **Correlated:** [`revenue_per_employee`](#revenue_per_employee), [`gross_profit_per_employee`](#gross_profit_per_employee), [`overtime_hours`](#overtime_hours)

<a id="working_capital"></a>
### Working Capital — `working_capital`

Current assets minus current liabilities — short-term liquidity indicator.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/working_capital.yml) · [sql](dbt/analyses/metrics/finance/working_capital.sql)
- **Numerator:** Current Assets - Current Liabilities
- **Dimensions:** company_id, quarter
- **Data sources:** Balance sheet
- **Parents:** [`free_cash_flow`](#free_cash_flow)
- **Children:** [`current_ratio`](#current_ratio), [`accounts_payable`](#accounts_payable), [`accounts_receivable`](#accounts_receivable), [`cash_and_equivalents`](#cash_and_equivalents), [`dpo`](#dpo), [`dso`](#dso), [`inventory_turnover`](#inventory_turnover), [`quick_ratio`](#quick_ratio)
- **Correlated:** [`free_cash_flow`](#free_cash_flow), [`accounts_payable`](#accounts_payable), [`ar_aging_90d`](#ar_aging_90d), [`current_ratio`](#current_ratio), [`dpo`](#dpo), [`quick_ratio`](#quick_ratio)

<a id="avg_tenure"></a>
### Avg Tenure (yrs) — `avg_tenure`

Average years of service among current employees

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/avg_tenure.yml) · [sql](dbt/analyses/metrics/hr/avg_tenure.sql)
- **Numerator:** Average years of service
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`employee_lifetime_value`](#employee_lifetime_value)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`engagement_score`](#engagement_score)

<a id="compensation_ratio"></a>
### Compensation Ratio — `compensation_ratio`

Employee pay relative to market midpoint for their role — pay equity signal.

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/compensation_ratio.yml) · [sql](dbt/analyses/metrics/hr/compensation_ratio.sql)
- **Numerator:** Employee Salary
- **Denominator:** Market Midpoint for Role
- **Dimensions:** job_level, department, location, period
- **Data sources:** HRIS, Market compensation data
- **Parents:** [`employee_attrition_rate`](#employee_attrition_rate)
- **Children:** [`stg_payroll_row`](#stg_payroll_row)
- **Correlated:** [`employee_attrition_rate`](#employee_attrition_rate), [`headcount_cost`](#headcount_cost)

<a id="complaint_resolution_rate"></a>
### Complaint Resolution % — `complaint_resolution_rate`

Percentage of complaints resolved within the SLA

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/complaint_resolution_rate.yml) · [sql](dbt/analyses/metrics/hr/complaint_resolution_rate.sql)
- **Numerator:** Complaints resolved within SLA
- **Denominator:** Total complaints
- **Dimensions:** date
- **Data sources:** crm
- **Parents:** [`cx_csat`](#cx_csat)
- **Correlated:** [`csat`](#csat), [`sla_breach_rate`](#sla_breach_rate), [`complaints_count`](#complaints_count)

<a id="cost_per_hire"></a>
### Cost Per Hire — `cost_per_hire`

Total recruiting costs divided by hires made

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/cost_per_hire.yml) · [sql](dbt/analyses/metrics/hr/cost_per_hire.sql)
- **Numerator:** Total recruiting costs
- **Denominator:** Hires made
- **Dimensions:** date, department
- **Data sources:** ats, hris, finance
- **Parents:** [`hr_cost_pct_revenue`](#hr_cost_pct_revenue)
- **Children:** [`total_comp_expense`](#total_comp_expense), [`new_hires`](#new_hires)
- **Correlated:** [`time_to_fill`](#time_to_fill), [`hr_cost_pct_revenue`](#hr_cost_pct_revenue), [`new_hires`](#new_hires), [`total_comp_expense`](#total_comp_expense)

<a id="course_completion_rate"></a>
### Course Completion % — `course_completion_rate`

Percentage of enrolled students who successfully completed a course

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/course_completion_rate.yml) · [sql](dbt/analyses/metrics/hr/course_completion_rate.sql)
- **Numerator:** Courses completed
- **Denominator:** Courses enrolled
- **Dimensions:** school_year, school
- **Data sources:** transcripts
- **Parents:** [`credit_accumulation_rate`](#credit_accumulation_rate)
- **Correlated:** [`dropout_rate`](#dropout_rate), [`ela_proficiency_rate`](#ela_proficiency_rate)

<a id="diversity_hire_rate"></a>
### Diversity Hire % — `diversity_hire_rate`

Percentage of hires from underrepresented groups

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/diversity_hire_rate.yml) · [sql](dbt/analyses/metrics/hr/diversity_hire_rate.sql)
- **Numerator:** Hires from underrepresented groups
- **Denominator:** Total hires
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`headcount`](#headcount)
- **Correlated:** [`gender_pay_gap`](#gender_pay_gap), [`engagement_score`](#engagement_score)

<a id="employee_attrition_rate"></a>
### Employee Attrition Rate — `employee_attrition_rate`

% of workforce that voluntarily left during the period.

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/employee_attrition_rate.yml) · [sql](dbt/analyses/metrics/hr/employee_attrition_rate.sql)
- **Numerator:** Voluntary Terminations
- **Denominator:** Average Headcount in Period
- **Dimensions:** department, job_level, location, period
- **Data sources:** HRIS
- **Parents:** [`turnover_rate`](#turnover_rate)
- **Children:** [`stg_employee_row`](#stg_employee_row), [`compensation_ratio`](#compensation_ratio), [`gender_pay_gap`](#gender_pay_gap), [`internal_promotion_rate`](#internal_promotion_rate)
- **Correlated:** [`headcount_fte`](#headcount_fte), [`employee_engagement_score`](#employee_engagement_score), [`compensation_ratio`](#compensation_ratio), [`employee_lifetime_value`](#employee_lifetime_value), [`internal_promotion_rate`](#internal_promotion_rate), [`manager_effectiveness_score`](#manager_effectiveness_score), [`safety_incident_rate`](#safety_incident_rate), [`teacher_retention_rate`](#teacher_retention_rate)

<a id="employee_engagement_score"></a>
### Employee Engagement Score — `employee_engagement_score`

Composite score from engagement surveys (eNPS, pulse).

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/employee_engagement_score.yml) · [sql](dbt/analyses/metrics/hr/employee_engagement_score.sql)
- **Numerator:** Weighted average of survey responses
- **Dimensions:** department, job_level, location, survey_cycle
- **Data sources:** Survey platform (Lattice / Culture Amp)
- **Parents:** [`voluntary_turnover`](#voluntary_turnover)
- **Children:** [`stg_survey_response_row`](#stg_survey_response_row), [`manager_effectiveness_score`](#manager_effectiveness_score), [`training_hours_per_employee`](#training_hours_per_employee)
- **Correlated:** [`employee_attrition_rate`](#employee_attrition_rate), [`headcount_cost`](#headcount_cost), [`employee_lifetime_value`](#employee_lifetime_value), [`manager_effectiveness_score`](#manager_effectiveness_score), [`school_culture_score`](#school_culture_score), [`training_hours_per_employee`](#training_hours_per_employee)

<a id="engagement_score"></a>
### Engagement Score — `engagement_score`

Composite score from employee engagement surveys

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/engagement_score.yml) · [sql](dbt/analyses/metrics/hr/engagement_score.sql)
- **Numerator:** Employee survey score (0–100)
- **Dimensions:** date, department
- **Data sources:** surveys
- **Parents:** [`voluntary_turnover`](#voluntary_turnover)
- **Children:** [`benefits_utilization`](#benefits_utilization), [`enps`](#enps), [`remote_work_rate`](#remote_work_rate)
- **Correlated:** [`enps`](#enps), [`turnover_rate`](#turnover_rate), [`voluntary_turnover`](#voluntary_turnover), [`absenteeism_rate`](#absenteeism_rate), [`avg_tenure`](#avg_tenure), [`benefits_utilization`](#benefits_utilization), [`diversity_hire_rate`](#diversity_hire_rate), [`gender_pay_gap`](#gender_pay_gap), [`regrettable_attrition`](#regrettable_attrition), [`remote_work_rate`](#remote_work_rate), [`survey_response_rate`](#survey_response_rate)

<a id="headcount_cost"></a>
### Headcount Cost — `headcount_cost`

Total fully-loaded compensation cost including salary, benefits, and employer taxes.

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/headcount_cost.yml) · [sql](dbt/analyses/metrics/hr/headcount_cost.sql)
- **Numerator:** SUM(total_comp + benefits + employer_taxes)
- **Dimensions:** department, location, job_level, period
- **Data sources:** HRIS, Payroll system
- **Parents:** [`opex`](#opex), [`employee_lifetime_value`](#employee_lifetime_value), [`staff_student_cost_ratio`](#staff_student_cost_ratio)
- **Children:** [`stg_payroll_row`](#stg_payroll_row)
- **Correlated:** [`headcount_fte`](#headcount_fte), [`revenue_per_employee`](#revenue_per_employee), [`compensation_ratio`](#compensation_ratio), [`employee_engagement_score`](#employee_engagement_score), [`safety_incident_rate`](#safety_incident_rate)

<a id="headcount_vs_budget"></a>
### HC vs Budget — `headcount_vs_budget`

Actual headcount relative to approved headcount budget

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/headcount_vs_budget.yml) · [sql](dbt/analyses/metrics/hr/headcount_vs_budget.sql)
- **Numerator:** Actual headcount − Budget headcount
- **Dimensions:** date, department
- **Data sources:** hris, finance
- **Parents:** [`headcount`](#headcount)
- **Children:** [`annual_budget`](#annual_budget), [`time_to_fill`](#time_to_fill)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`budget_variance`](#budget_variance), [`opex`](#opex), [`headcount`](#headcount), [`open_requisitions`](#open_requisitions), [`span_of_control`](#span_of_control)

<a id="inventory_turnover"></a>
### Inventory Turnover — `inventory_turnover`

COGS divided by average inventory — how many times inventory was sold and replaced

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/inventory_turnover.yml) · [sql](dbt/analyses/metrics/hr/inventory_turnover.sql)
- **Numerator:** COGS
- **Denominator:** Average inventory value
- **Dimensions:** date, product, location
- **Data sources:** inventory, orders
- **Parents:** [`working_capital`](#working_capital)
- **Children:** [`cogs_stg`](#cogs_stg), [`inventory_value`](#inventory_value), [`stg_inventory_items`](#stg_inventory_items)
- **Correlated:** [`stockout_rate`](#stockout_rate), [`dpo`](#dpo), [`otd_rate`](#otd_rate), [`cogs_stg`](#cogs_stg), [`fill_rate`](#fill_rate), [`inventory_value`](#inventory_value), [`stg_inventory_items`](#stg_inventory_items), [`supplier_lead_time`](#supplier_lead_time), [`warehouse_utilization_rate`](#warehouse_utilization_rate)

<a id="onboarding_completion_rate"></a>
### Onboarding Completion — `onboarding_completion_rate`

% of new users who complete all onboarding steps.

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/onboarding_completion_rate.yml) · [sql](dbt/analyses/metrics/hr/onboarding_completion_rate.sql)
- **Numerator:** Users who completed onboarding
- **Denominator:** Users who started onboarding
- **Dimensions:** cohort, plan_tier, acquisition_channel
- **Data sources:** Product analytics
- **Parents:** [`time_to_value`](#time_to_value)
- **Children:** [`stg_user_event_row`](#stg_user_event_row)
- **Correlated:** [`feature_adoption_rate`](#feature_adoption_rate), [`churn_rate`](#churn_rate), [`activation_rate`](#activation_rate)

<a id="pct_reps_at_quota"></a>
### % Reps at Quota — `pct_reps_at_quota`

% of sales reps who hit or exceeded their quota — team productivity signal.

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/pct_reps_at_quota.yml) · [sql](dbt/analyses/metrics/hr/pct_reps_at_quota.sql)
- **Numerator:** Reps at or above quota
- **Denominator:** Total Active Reps
- **Dimensions:** segment, team, period
- **Data sources:** CRM, Finance
- **Parents:** [`new_arr`](#new_arr)
- **Children:** [`quota_attainment`](#quota_attainment)
- **Correlated:** [`quota_attainment`](#quota_attainment), [`win_rate`](#win_rate)

<a id="qbr_completion_rate"></a>
### QBR Completion % — `qbr_completion_rate`

Percentage of accounts that had a quarterly business review in the period

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/qbr_completion_rate.yml) · [sql](dbt/analyses/metrics/hr/qbr_completion_rate.sql)
- **Numerator:** QBRs completed
- **Denominator:** QBRs scheduled
- **Dimensions:** date, csm
- **Data sources:** crm
- **Parents:** [`renewal_rate`](#renewal_rate)
- **Correlated:** [`renewal_rate`](#renewal_rate), [`account_health_score`](#account_health_score)

<a id="rd_headcount_pct"></a>
### R&D % of Headcount — `rd_headcount_pct`

Engineering and product staff as a share of total headcount

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/rd_headcount_pct.yml) · [sql](dbt/analyses/metrics/hr/rd_headcount_pct.sql)
- **Numerator:** R&D headcount
- **Denominator:** Total headcount
- **Dimensions:** date
- **Data sources:** hris
- **Parents:** [`rd_as_pct_revenue`](#rd_as_pct_revenue)
- **Children:** [`rd_headcount`](#rd_headcount)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`rd_spend_pct`](#rd_spend_pct), [`deployment_frequency`](#deployment_frequency), [`headcount_by_dept`](#headcount_by_dept), [`rd_headcount`](#rd_headcount)

<a id="regrettable_attrition"></a>
### Regrettable Attrition % — `regrettable_attrition`

Percentage of turnover classified as regrettable by management

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/regrettable_attrition.yml) · [sql](dbt/analyses/metrics/hr/regrettable_attrition.sql)
- **Numerator:** Regrettable departures
- **Denominator:** Total separations
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`turnover_rate`](#turnover_rate)
- **Children:** [`separations`](#separations)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`engagement_score`](#engagement_score), [`separations`](#separations), [`turnover_rate`](#turnover_rate)

<a id="sla_compliance_rate"></a>
### SLA Compliance Rate — `sla_compliance_rate`

% of service commitments delivered within contracted SLA windows.

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/sla_compliance_rate.yml) · [sql](dbt/analyses/metrics/hr/sla_compliance_rate.sql)
- **Numerator:** SLA-Compliant Events
- **Denominator:** Total SLA-Tracked Events
- **Dimensions:** service_type, client_id, period
- **Data sources:** Operations platform, CRM
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Correlated:** [`on_time_delivery_rate`](#on_time_delivery_rate), [`csat`](#csat)

<a id="span_of_control"></a>
### Span of Control — `span_of_control`

Average number of direct reports per manager

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/span_of_control.yml) · [sql](dbt/analyses/metrics/hr/span_of_control.sql)
- **Numerator:** Direct reports
- **Denominator:** Manager count
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`manager_effectiveness_score`](#manager_effectiveness_score)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`headcount_vs_budget`](#headcount_vs_budget), [`internal_promotion_rate`](#internal_promotion_rate)

<a id="time_to_hire"></a>
### Time to Hire — `time_to_hire`

Average days from application to accepted offer

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/time_to_hire.yml) · [sql](dbt/analyses/metrics/hr/time_to_hire.sql)
- **Numerator:** Days from application to offer acceptance
- **Dimensions:** date, department
- **Data sources:** ats
- **Parents:** [`time_to_fill`](#time_to_fill)
- **Children:** [`open_requisitions`](#open_requisitions), [`recruiting_pipeline`](#recruiting_pipeline), [`interview_to_offer_rate`](#interview_to_offer_rate)
- **Correlated:** [`time_to_fill`](#time_to_fill), [`offer_acceptance_rate`](#offer_acceptance_rate), [`interview_to_offer_rate`](#interview_to_offer_rate), [`recruiting_pipeline`](#recruiting_pipeline)

<a id="vendor_compliance_rate"></a>
### Vendor Compliance % — `vendor_compliance_rate`

Percentage of purchase orders fulfilled by vendors per specifications

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/vendor_compliance_rate.yml) · [sql](dbt/analyses/metrics/hr/vendor_compliance_rate.sql)
- **Numerator:** Compliant POs
- **Denominator:** Total POs
- **Dimensions:** date, vendor
- **Data sources:** procurement, quality
- **Parents:** [`vendor_scorecard_rating`](#vendor_scorecard_rating)
- **Children:** [`stg_purchase_order_row`](#stg_purchase_order_row)
- **Correlated:** [`supplier_lead_time`](#supplier_lead_time), [`defect_rate`](#defect_rate), [`shrinkage_rate`](#shrinkage_rate)

<a id="voluntary_turnover"></a>
### Voluntary Turnover — `voluntary_turnover`

Turnover from employee-initiated separations only

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/voluntary_turnover.yml) · [sql](dbt/analyses/metrics/hr/voluntary_turnover.sql)
- **Numerator:** Voluntary departures
- **Denominator:** Average headcount
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`turnover_rate`](#turnover_rate)
- **Children:** [`separations`](#separations), [`employee_engagement_score`](#employee_engagement_score), [`engagement_score`](#engagement_score)
- **Correlated:** [`regrettable_attrition`](#regrettable_attrition), [`engagement_score`](#engagement_score), [`avg_tenure`](#avg_tenure), [`separations`](#separations), [`turnover_rate`](#turnover_rate)

<a id="ad_ctr"></a>
### Ad CTR — `ad_ctr`

Percentage of ad impressions that received a click

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/ad_ctr.yml) · [sql](dbt/analyses/metrics/marketing/ad_ctr.sql)
- **Numerator:** Ad clicks
- **Denominator:** Ad impressions
- **Dimensions:** date, channel, ad
- **Data sources:** ad_platforms
- **Parents:** [`cpc`](#cpc)
- **Children:** [`ad_impressions`](#ad_impressions)
- **Correlated:** [`cpc`](#cpc), [`roas`](#roas), [`ad_impressions`](#ad_impressions)

<a id="bad_debt_rate"></a>
### Bad Debt Rate — `bad_debt_rate`

% of revenue written off as uncollectible bad debt.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/bad_debt_rate.yml) · [sql](dbt/analyses/metrics/marketing/bad_debt_rate.sql)
- **Numerator:** Bad Debt Write-Offs
- **Denominator:** Revenue
- **Dimensions:** company_id, customer_segment, fiscal_period
- **Data sources:** ERP, Finance
- **Parents:** [`ebitda`](#ebitda)
- **Children:** [`ar_aging_90d`](#ar_aging_90d)
- **Correlated:** [`dso`](#dso), [`ar_aging_90d`](#ar_aging_90d)

<a id="cost_per_mql"></a>
### Cost per MQL — `cost_per_mql`

Total marketing spend divided by MQLs generated.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/cost_per_mql.yml) · [sql](dbt/analyses/metrics/marketing/cost_per_mql.sql)
- **Numerator:** Marketing spend
- **Denominator:** MQLs
- **Dimensions:** date, channel
- **Data sources:** ad_platforms, crm
- **Parents:** [`cac`](#cac)
- **Children:** [`stg_ad_spend`](#stg_ad_spend), [`cpl`](#cpl), [`marketing_spend`](#marketing_spend)
- **Formula inputs:** [`mql`](#mql)
- **Correlated:** [`cpl`](#cpl), [`marketing_cac`](#marketing_cac), [`cost_per_sql`](#cost_per_sql), [`mql_count`](#mql_count), [`web_conversion_rate`](#web_conversion_rate)

<a id="cost_per_sql"></a>
### Cost per SQL — `cost_per_sql`

Total marketing spend per sales-qualified lead generated.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/cost_per_sql.yml) · [sql](dbt/analyses/metrics/marketing/cost_per_sql.sql)
- **Numerator:** Marketing Spend
- **Denominator:** SQL Count
- **Dimensions:** channel, campaign, period
- **Data sources:** Marketing automation, CRM
- **Parents:** [`cac`](#cac)
- **Children:** [`marketing_spend`](#marketing_spend), [`sql_count`](#sql_count)
- **Correlated:** [`cost_per_mql`](#cost_per_mql), [`cac`](#cac)

<a id="cpc"></a>
### CPC — `cpc`

Average cost paid per ad click.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/cpc.yml) · [sql](dbt/analyses/metrics/marketing/cpc.sql)
- **Numerator:** Ad spend
- **Denominator:** Clicks
- **Dimensions:** date, channel
- **Data sources:** ad_platforms
- **Parents:** [`cpl`](#cpl)
- **Children:** [`stg_ad_spend`](#stg_ad_spend), [`ad_impressions`](#ad_impressions), [`ad_clicks`](#ad_clicks), [`ad_ctr`](#ad_ctr), [`cpm`](#cpm), [`ctr`](#ctr)
- **Correlated:** [`ad_ctr`](#ad_ctr), [`roas`](#roas), [`ad_impressions`](#ad_impressions), [`cpl`](#cpl), [`cpm`](#cpm), [`ctr`](#ctr), [`stg_ad_spend`](#stg_ad_spend)

<a id="ctr"></a>
### CTR — `ctr`

Clicks divided by impressions — ad relevance and creative effectiveness.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/ctr.yml) · [sql](dbt/analyses/metrics/marketing/ctr.sql)
- **Numerator:** Clicks
- **Denominator:** Impressions
- **Dimensions:** channel, campaign, ad_set, period
- **Data sources:** Google Ads, Meta Ads
- **Parents:** [`cpc`](#cpc)
- **Children:** [`ad_clicks`](#ad_clicks), [`impressions`](#impressions)
- **Correlated:** [`cpc`](#cpc), [`web_conversion_rate`](#web_conversion_rate), [`cpm`](#cpm)

<a id="email_click_rate"></a>
### Email Click Rate — `email_click_rate`

% of delivered emails that received at least one click.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/email_click_rate.yml) · [sql](dbt/analyses/metrics/marketing/email_click_rate.sql)
- **Numerator:** Emails Clicked
- **Denominator:** Emails Delivered
- **Dimensions:** campaign_id, segment, period
- **Data sources:** Email platform
- **Parents:** [`mql_count`](#mql_count)
- **Children:** [`stg_email_send_row`](#stg_email_send_row), [`email_open_rate`](#email_open_rate)
- **Correlated:** [`email_open_rate`](#email_open_rate), [`web_conversion_rate`](#web_conversion_rate)

<a id="email_ctr"></a>
### Email CTR — `email_ctr`

Percentage of delivered emails that received a click

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/email_ctr.yml) · [sql](dbt/analyses/metrics/marketing/email_ctr.sql)
- **Numerator:** Unique clicks
- **Denominator:** Emails delivered
- **Dimensions:** date, campaign
- **Data sources:** email_platform
- **Parents:** [`mql_count`](#mql_count)
- **Children:** [`email_open_rate`](#email_open_rate)
- **Correlated:** [`email_open_rate`](#email_open_rate), [`form_conversion_rate`](#form_conversion_rate), [`email_unsub_rate`](#email_unsub_rate)

<a id="email_open_rate"></a>
### Email Open Rate — `email_open_rate`

% of delivered emails that were opened.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/email_open_rate.yml) · [sql](dbt/analyses/metrics/marketing/email_open_rate.sql)
- **Numerator:** Emails Opened
- **Denominator:** Emails Delivered
- **Dimensions:** campaign_id, segment, period
- **Data sources:** Email platform (HubSpot / Klaviyo / Mailchimp)
- **Parents:** [`email_click_rate`](#email_click_rate), [`email_ctr`](#email_ctr)
- **Children:** [`stg_email_send_row`](#stg_email_send_row)
- **Correlated:** [`email_click_rate`](#email_click_rate), [`unsubscribe_rate`](#unsubscribe_rate), [`email_ctr`](#email_ctr), [`email_unsub_rate`](#email_unsub_rate), [`push_open_rate`](#push_open_rate), [`webinar_attendance_rate`](#webinar_attendance_rate)

<a id="keywords_top10"></a>
### Keywords (Top 10) — `keywords_top10`

Number of target keywords ranking on page 1 of Google

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/keywords_top10.yml) · [sql](dbt/analyses/metrics/marketing/keywords_top10.sql)
- **Numerator:** Keywords ranking in top 10 search results
- **Dimensions:** date
- **Data sources:** seo_tools
- **Parents:** [`organic_sessions`](#organic_sessions)
- **Children:** [`domain_authority`](#domain_authority)
- **Correlated:** [`domain_authority`](#domain_authority), [`organic_traffic`](#organic_traffic), [`backlinks_count`](#backlinks_count)

<a id="lead_time"></a>
### Lead Time — `lead_time`

Average time from request to delivery

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/lead_time.yml) · [sql](dbt/analyses/metrics/marketing/lead_time.sql)
- **Numerator:** Time from order to delivery
- **Dimensions:** date, product
- **Data sources:** production
- **Parents:** [`otd_rate`](#otd_rate)
- **Correlated:** [`cycle_time`](#cycle_time), [`otd_rate`](#otd_rate)

<a id="lead_time_for_changes"></a>
### Lead Time for Changes — `lead_time_for_changes`

Median time from code commit to production deployment — DORA metric.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/lead_time_for_changes.yml) · [sql](dbt/analyses/metrics/marketing/lead_time_for_changes.sql)
- **Numerator:** MEDIAN(deploy_time - commit_time)
- **Dimensions:** team, service, period
- **Data sources:** CI/CD platform, Version control
- **Parents:** [`deployment_frequency`](#deployment_frequency)
- **Children:** [`pr_merge_time`](#pr_merge_time)
- **Correlated:** [`deployment_frequency`](#deployment_frequency), [`error_rate`](#error_rate)

<a id="lead_to_mql_rate"></a>
### Lead → MQL % — `lead_to_mql_rate`

Percentage of leads that reach MQL threshold

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/lead_to_mql_rate.yml) · [sql](dbt/analyses/metrics/marketing/lead_to_mql_rate.sql)
- **Numerator:** MQLs
- **Denominator:** All leads
- **Dimensions:** date, channel
- **Data sources:** marketing_automation, crm
- **Parents:** [`mql`](#mql)
- **Children:** [`stg_leads_count`](#stg_leads_count)
- **Correlated:** [`mql_to_sql_rate`](#mql_to_sql_rate), [`form_conversion_rate`](#form_conversion_rate), [`mql`](#mql)

<a id="mql"></a>
### MQLs — `mql`

Leads meeting scoring threshold passed to sales

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/mql.yml) · [sql](dbt/analyses/metrics/marketing/mql.sql)
- **Numerator:** Leads meeting MQL criteria in period
- **Dimensions:** date, channel, campaign
- **Data sources:** crm, marketing_automation
- **Parents:** [`pipeline_generated`](#pipeline_generated), [`sql`](#sql)
- **Children:** [`stg_leads_count`](#stg_leads_count), [`form_conversion_rate`](#form_conversion_rate), [`demo_requests`](#demo_requests), [`event_attendees`](#event_attendees), [`lead_to_mql_rate`](#lead_to_mql_rate), [`session_to_lead_rate`](#session_to_lead_rate), [`webinar_attendance_rate`](#webinar_attendance_rate)
- **Correlated:** [`sql`](#sql), [`lead_to_mql_rate`](#lead_to_mql_rate), [`demo_requests`](#demo_requests), [`event_attendees`](#event_attendees), [`pipeline_generated`](#pipeline_generated), [`stg_leads_count`](#stg_leads_count), [`webinar_registrants`](#webinar_registrants)

<a id="mql_count"></a>
### MQLs — `mql_count`

Count of leads that meet scoring threshold for marketing qualification.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/mql_count.yml) · [sql](dbt/analyses/metrics/marketing/mql_count.sql)
- **Numerator:** COUNT(leads WHERE score >= mql_threshold)
- **Dimensions:** channel, campaign, source, period
- **Data sources:** Marketing automation (HubSpot / Marketo)
- **Parents:** [`sql_count`](#sql_count), [`cac`](#cac), [`mql_to_sql_rate`](#mql_to_sql_rate)
- **Children:** [`stg_lead_row`](#stg_lead_row), [`email_click_rate`](#email_click_rate), [`email_ctr`](#email_ctr), [`unsubscribe_rate`](#unsubscribe_rate), [`web_conversion_rate`](#web_conversion_rate)
- **Correlated:** [`cost_per_mql`](#cost_per_mql), [`content_published_count`](#content_published_count), [`new_user_signups`](#new_user_signups), [`website_sessions`](#website_sessions)

<a id="mql_to_sql_rate"></a>
### MQL→SQL Rate — `mql_to_sql_rate`

% of MQLs that convert to SQLs — marketing-to-sales handoff quality.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/mql_to_sql_rate.yml) · [sql](dbt/analyses/metrics/marketing/mql_to_sql_rate.sql)
- **Numerator:** SQLs
- **Denominator:** MQLs
- **Dimensions:** channel, campaign, period
- **Data sources:** CRM, Marketing automation
- **Parents:** [`sql`](#sql)
- **Children:** [`sql_count`](#sql_count), [`mql_count`](#mql_count)
- **Correlated:** [`win_rate`](#win_rate), [`cac`](#cac), [`lead_to_mql_rate`](#lead_to_mql_rate), [`sql_count`](#sql_count)

<a id="organic_attribution_pct"></a>
### Organic Attribution % — `organic_attribution_pct`

Percentage of closed revenue attributed to organic channels

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/organic_attribution_pct.yml) · [sql](dbt/analyses/metrics/marketing/organic_attribution_pct.sql)
- **Numerator:** Organic-attributed pipeline
- **Denominator:** Total pipeline
- **Dimensions:** date
- **Data sources:** analytics, crm
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Children:** [`organic_traffic`](#organic_traffic)
- **Formula inputs:** [`mql`](#mql)
- **Correlated:** [`paid_attribution_pct`](#paid_attribution_pct), [`referral_attribution_pct`](#referral_attribution_pct)

<a id="organic_sessions"></a>
### Organic Sessions — `organic_sessions`

Web sessions from unpaid search (SEO) traffic.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/organic_sessions.yml) · [sql](dbt/analyses/metrics/marketing/organic_sessions.sql)
- **Numerator:** COUNT(sessions WHERE medium = 'organic')
- **Dimensions:** landing_page, keyword, device, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`website_sessions`](#website_sessions)
- **Children:** [`stg_session_row`](#stg_session_row), [`content_published_count`](#content_published_count), [`keywords_top10`](#keywords_top10), [`top10_keyword_count`](#top10_keyword_count)
- **Correlated:** [`paid_sessions`](#paid_sessions), [`web_conversion_rate`](#web_conversion_rate), [`backlink_count`](#backlink_count), [`content_published_count`](#content_published_count), [`referral_sessions`](#referral_sessions), [`share_of_voice`](#share_of_voice), [`social_followers`](#social_followers), [`top10_keyword_count`](#top10_keyword_count)

<a id="roas"></a>
### ROAS — `roas`

Revenue attributed to ads divided by ad spend — direct campaign ROI.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/roas.yml) · [sql](dbt/analyses/metrics/marketing/roas.sql)
- **Numerator:** Revenue Attributed to Ads
- **Denominator:** Ad Spend
- **Dimensions:** channel, campaign, period
- **Data sources:** Ad platforms, Revenue attribution model
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Children:** [`marketing_spend`](#marketing_spend)
- **Correlated:** [`cac`](#cac), [`ltv_cac`](#ltv_cac), [`ad_ctr`](#ad_ctr), [`cpc`](#cpc), [`marketing_influenced_pipeline`](#marketing_influenced_pipeline), [`marketing_roi`](#marketing_roi), [`paid_attribution_pct`](#paid_attribution_pct), [`paid_sessions`](#paid_sessions), [`stg_ad_spend`](#stg_ad_spend)

<a id="session_to_lead_rate"></a>
### Session → Lead % — `session_to_lead_rate`

Percentage of web sessions that convert to a lead

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/session_to_lead_rate.yml) · [sql](dbt/analyses/metrics/marketing/session_to_lead_rate.sql)
- **Numerator:** Leads created
- **Denominator:** Sessions
- **Dimensions:** date, channel
- **Data sources:** analytics, crm
- **Parents:** [`mql`](#mql)
- **Children:** [`website_sessions`](#website_sessions), [`stg_leads_count`](#stg_leads_count)
- **Correlated:** [`form_conversion_rate`](#form_conversion_rate), [`bounce_rate`](#bounce_rate), [`funnel_dropoff`](#funnel_dropoff)

<a id="social_engagement_rate"></a>
### Social Engagement % — `social_engagement_rate`

Average engagements (likes, comments, shares) per post divided by reach

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/social_engagement_rate.yml) · [sql](dbt/analyses/metrics/marketing/social_engagement_rate.sql)
- **Numerator:** Engagements (likes + comments + shares)
- **Denominator:** Followers
- **Dimensions:** date, platform
- **Data sources:** social_analytics
- **Parents:** [`share_of_voice`](#share_of_voice)
- **Children:** [`social_followers`](#social_followers)
- **Correlated:** [`domain_authority`](#domain_authority), [`earned_media_value`](#earned_media_value), [`pr_mentions`](#pr_mentions)

<a id="sql"></a>
### SQLs — `sql`

Leads accepted by sales as qualified opportunities

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/sql.yml) · [sql](dbt/analyses/metrics/marketing/sql.sql)
- **Numerator:** Opportunities accepted by sales
- **Dimensions:** date, sales_rep, channel
- **Data sources:** crm
- **Parents:** [`pipeline_generated`](#pipeline_generated), [`bookings`](#bookings), [`avg_sales_cycle`](#avg_sales_cycle)
- **Children:** [`mql`](#mql), [`mql_to_sql_rate`](#mql_to_sql_rate)
- **Correlated:** [`mql`](#mql), [`win_rate`](#win_rate), [`demo_requests`](#demo_requests), [`stg_opportunities_count`](#stg_opportunities_count)

<a id="sql_count"></a>
### SQLs — `sql_count`

Leads accepted by sales as ready to work.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/sql_count.yml) · [sql](dbt/analyses/metrics/marketing/sql_count.sql)
- **Numerator:** COUNT(leads WHERE stage = 'SQL')
- **Dimensions:** channel, campaign, segment, period
- **Data sources:** CRM
- **Parents:** [`pipeline_value`](#pipeline_value), [`cost_per_sql`](#cost_per_sql), [`mql_to_sql_rate`](#mql_to_sql_rate)
- **Children:** [`mql_count`](#mql_count)
- **Correlated:** [`mql_to_sql_rate`](#mql_to_sql_rate), [`win_rate`](#win_rate)

<a id="supplier_lead_time"></a>
### Supplier Lead Time — `supplier_lead_time`

Average days from purchase order creation to goods receipt.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/supplier_lead_time.yml) · [sql](dbt/analyses/metrics/marketing/supplier_lead_time.sql)
- **Numerator:** SUM(receipt_date - po_date)
- **Denominator:** COUNT(purchase orders)
- **Dimensions:** supplier_id, product_category, period
- **Data sources:** ERP, Purchasing system
- **Parents:** [`vendor_scorecard_rating`](#vendor_scorecard_rating)
- **Children:** [`stg_purchase_order_row`](#stg_purchase_order_row)
- **Correlated:** [`fill_rate`](#fill_rate), [`inventory_turnover`](#inventory_turnover), [`vendor_compliance_rate`](#vendor_compliance_rate)

<a id="top10_keyword_count"></a>
### Top 10 Keywords — `top10_keyword_count`

Number of target keywords ranking in Google's top 10 results.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/top10_keyword_count.yml) · [sql](dbt/analyses/metrics/marketing/top10_keyword_count.sql)
- **Numerator:** COUNT(keywords WHERE rank <= 10)
- **Dimensions:** keyword_group, page, period
- **Data sources:** SEO tools (SEMrush / Ahrefs)
- **Parents:** [`organic_sessions`](#organic_sessions)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`content_published_count`](#content_published_count)

<a id="webinar_attendance_rate"></a>
### Webinar Attendance % — `webinar_attendance_rate`

Percentage of webinar registrants who attended live

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/webinar_attendance_rate.yml) · [sql](dbt/analyses/metrics/marketing/webinar_attendance_rate.sql)
- **Numerator:** Attendees
- **Denominator:** Registrants
- **Dimensions:** date, webinar
- **Data sources:** webinar_platform, marketing_automation
- **Parents:** [`mql`](#mql)
- **Children:** [`webinar_registrants`](#webinar_registrants)
- **Correlated:** [`email_open_rate`](#email_open_rate), [`form_conversion_rate`](#form_conversion_rate), [`webinar_registrants`](#webinar_registrants)

<a id="cycle_time"></a>
### Cycle Time — `cycle_time`

Average time from work start to delivery

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/cycle_time.yml) · [sql](dbt/analyses/metrics/ops/cycle_time.sql)
- **Numerator:** Order complete − Order start
- **Dimensions:** date, product
- **Data sources:** production, orders
- **Parents:** [`otd_rate`](#otd_rate)
- **Children:** [`stg_orders_count`](#stg_orders_count), [`process_automation_rate`](#process_automation_rate)
- **Correlated:** [`lead_time`](#lead_time), [`throughput`](#throughput), [`otd_rate`](#otd_rate), [`capacity_utilization`](#capacity_utilization), [`process_automation_rate`](#process_automation_rate)

<a id="defect_rate"></a>
### Defect Rate — `defect_rate`

% of units produced or received that fail quality inspection.

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/defect_rate.yml) · [sql](dbt/analyses/metrics/ops/defect_rate.sql)
- **Numerator:** Defective Units
- **Denominator:** Total Units Inspected
- **Dimensions:** production_line, supplier_id, product_id, period
- **Data sources:** Quality management system, ERP
- **Parents:** [`ops_north_star`](#ops_north_star), [`vendor_scorecard_rating`](#vendor_scorecard_rating)
- **Children:** [`stg_quality_inspection_row`](#stg_quality_inspection_row)
- **Correlated:** [`order_accuracy_rate`](#order_accuracy_rate), [`fill_rate`](#fill_rate), [`capacity_utilization_rate`](#capacity_utilization_rate), [`cost_per_unit`](#cost_per_unit), [`return_rate`](#return_rate), [`vendor_compliance_rate`](#vendor_compliance_rate), [`vendor_scorecard_rating`](#vendor_scorecard_rating)

<a id="escalation_rate"></a>
### Escalation Rate — `escalation_rate`

Percentage of tickets escalated to tier 2 or above

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/escalation_rate.yml) · [sql](dbt/analyses/metrics/ops/escalation_rate.sql)
- **Numerator:** Escalated tickets
- **Denominator:** Total tickets
- **Dimensions:** date
- **Data sources:** helpdesk
- **Parents:** [`ticket_resolution_time`](#ticket_resolution_time)
- **Children:** [`stg_support_tickets`](#stg_support_tickets)
- **Correlated:** [`sla_breach_rate`](#sla_breach_rate), [`ticket_resolution_time`](#ticket_resolution_time)

<a id="fill_rate"></a>
### Fill Rate — `fill_rate`

% of order lines fulfilled completely from available inventory.

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/fill_rate.yml) · [sql](dbt/analyses/metrics/ops/fill_rate.sql)
- **Numerator:** Order Lines Fully Shipped
- **Denominator:** Total Order Lines
- **Dimensions:** warehouse_id, product_category, period
- **Data sources:** WMS, ERP
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Children:** [`stg_order_line_row`](#stg_order_line_row), [`stockout_rate`](#stockout_rate)
- **Correlated:** [`on_time_delivery_rate`](#on_time_delivery_rate), [`inventory_turnover`](#inventory_turnover), [`defect_rate`](#defect_rate), [`order_accuracy_rate`](#order_accuracy_rate), [`supplier_lead_time`](#supplier_lead_time), [`vendor_scorecard_rating`](#vendor_scorecard_rating), [`warehouse_utilization_rate`](#warehouse_utilization_rate)

<a id="on_time_delivery_rate"></a>
### On-Time Delivery Rate — `on_time_delivery_rate`

% of orders or deliveries completed by their committed date.

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/on_time_delivery_rate.yml) · [sql](dbt/analyses/metrics/ops/on_time_delivery_rate.sql)
- **Numerator:** On-Time Deliveries
- **Denominator:** Total Deliveries
- **Dimensions:** carrier, region, product_category, period
- **Data sources:** WMS, TMS, ERP
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Children:** [`stg_shipment_row`](#stg_shipment_row)
- **Correlated:** [`fill_rate`](#fill_rate), [`order_accuracy_rate`](#order_accuracy_rate), [`sla_compliance_rate`](#sla_compliance_rate)

<a id="order_fulfillment_rate"></a>
### Order Fulfillment % — `order_fulfillment_rate`

Percentage of orders fulfilled completely and on time

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/order_fulfillment_rate.yml) · [sql](dbt/analyses/metrics/ops/order_fulfillment_rate.sql)
- **Numerator:** Fulfilled orders
- **Denominator:** Total orders
- **Dimensions:** date, region
- **Data sources:** orders, inventory
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Children:** [`stg_orders_count`](#stg_orders_count)
- **Correlated:** [`otd_rate`](#otd_rate), [`stockout_rate`](#stockout_rate)

<a id="procurement_savings_rate"></a>
### Procurement Savings Rate — `procurement_savings_rate`

Actual spend vs budgeted or baseline spend — cost reduction from procurement initiatives.

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/procurement_savings_rate.yml) · [sql](dbt/analyses/metrics/ops/procurement_savings_rate.sql)
- **Numerator:** Baseline Spend - Actual Spend
- **Denominator:** Baseline Spend
- **Dimensions:** category_manager, spend_category, period
- **Data sources:** ERP, Purchasing system
- **Parents:** [`cogs`](#cogs)
- **Children:** [`stg_purchase_order_row`](#stg_purchase_order_row)
- **Correlated:** [`cost_per_unit`](#cost_per_unit), [`gross_margin`](#gross_margin)

<a id="rcr_rate"></a>
### Root Cause Resolution % — `rcr_rate`

Percentage of incidents with documented root cause and resolution

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/rcr_rate.yml) · [sql](dbt/analyses/metrics/ops/rcr_rate.sql)
- **Numerator:** Incidents with documented root cause
- **Denominator:** Total incidents
- **Dimensions:** date
- **Data sources:** incident_management
- **Parents:** [`uptime`](#uptime)
- **Correlated:** [`incident_count`](#incident_count), [`mttr`](#mttr)

<a id="return_rate"></a>
### Return Rate — `return_rate`

% of units sold that are returned by customers.

- **Vertical:** Operations · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/ops/return_rate.yml) · [sql](dbt/analyses/metrics/ops/return_rate.sql)
- **Numerator:** Units Returned
- **Denominator:** Units Sold
- **Dimensions:** product_category, channel, period
- **Data sources:** ERP, WMS
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Children:** [`stg_return_row`](#stg_return_row), [`product_return_rate`](#product_return_rate)
- **Correlated:** [`defect_rate`](#defect_rate), [`order_accuracy_rate`](#order_accuracy_rate)

<a id="safety_incident_rate"></a>
### Safety Incident Rate — `safety_incident_rate`

OSHA recordable incident rate per 100 full-time employees.

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/safety_incident_rate.yml) · [sql](dbt/analyses/metrics/ops/safety_incident_rate.sql)
- **Numerator:** Recordable Incidents × 200,000
- **Denominator:** Total Employee-Hours Worked
- **Dimensions:** facility_id, department, incident_type, period
- **Data sources:** Safety management system, HRIS
- **Parents:** [`workforce_productivity`](#workforce_productivity)
- **Children:** [`stg_safety_incident_row`](#stg_safety_incident_row)
- **Correlated:** [`employee_attrition_rate`](#employee_attrition_rate), [`headcount_cost`](#headcount_cost)

<a id="seat_fill_rate"></a>
### Seat Fill Rate — `seat_fill_rate`

% of available enrollment seats filled by students at a school.

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/seat_fill_rate.yml) · [sql](dbt/analyses/metrics/ops/seat_fill_rate.sql)
- **Numerator:** Enrolled Students
- **Denominator:** Available Seats
- **Dimensions:** school_id, grade_level, period
- **Data sources:** SIS, Facilities system
- **Parents:** [`per_pupil_expenditure`](#per_pupil_expenditure)
- **Children:** [`stg_enrollment_row`](#stg_enrollment_row)
- **Correlated:** [`enrollment_count`](#enrollment_count), [`per_pupil_expenditure`](#per_pupil_expenditure)

<a id="sla_breach_rate"></a>
### SLA Breach % — `sla_breach_rate`

Percentage of tickets that exceeded the committed SLA response or resolution time

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/sla_breach_rate.yml) · [sql](dbt/analyses/metrics/ops/sla_breach_rate.sql)
- **Numerator:** SLA breaches
- **Denominator:** Total tickets
- **Dimensions:** date, priority
- **Data sources:** helpdesk
- **Parents:** [`csat`](#csat)
- **Children:** [`ticket_resolution_time`](#ticket_resolution_time), [`first_response_time`](#first_response_time), [`ticket_backlog`](#ticket_backlog)
- **Correlated:** [`escalation_rate`](#escalation_rate), [`csat`](#csat), [`complaint_resolution_rate`](#complaint_resolution_rate), [`support_cost_per_ticket`](#support_cost_per_ticket), [`ticket_backlog`](#ticket_backlog), [`tickets_created`](#tickets_created), [`tickets_per_agent`](#tickets_per_agent)

<a id="stockout_rate"></a>
### Stockout Rate — `stockout_rate`

Percentage of orders that could not be fulfilled due to zero inventory

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/stockout_rate.yml) · [sql](dbt/analyses/metrics/ops/stockout_rate.sql)
- **Numerator:** Stockout events
- **Denominator:** Total SKUs
- **Dimensions:** date, product, location
- **Data sources:** inventory, orders
- **Parents:** [`fill_rate`](#fill_rate)
- **Children:** [`stg_inventory_items`](#stg_inventory_items)
- **Correlated:** [`inventory_turnover`](#inventory_turnover), [`order_fulfillment_rate`](#order_fulfillment_rate), [`stg_inventory_items`](#stg_inventory_items)

<a id="support_cost_per_ticket"></a>
### Support Cost / Ticket — `support_cost_per_ticket`

Total support cost divided by tickets resolved

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/support_cost_per_ticket.yml) · [sql](dbt/analyses/metrics/ops/support_cost_per_ticket.sql)
- **Numerator:** Support team cost
- **Denominator:** Tickets resolved
- **Dimensions:** date
- **Data sources:** helpdesk, finance
- **Parents:** [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Children:** [`total_comp_expense`](#total_comp_expense), [`tickets_resolved`](#tickets_resolved), [`tickets_per_agent`](#tickets_per_agent)
- **Correlated:** [`hr_cost_pct_revenue`](#hr_cost_pct_revenue), [`sla_breach_rate`](#sla_breach_rate), [`tickets_per_agent`](#tickets_per_agent), [`tickets_per_customer`](#tickets_per_customer), [`tickets_resolved`](#tickets_resolved)

<a id="throughput"></a>
### Throughput — `throughput`

Number of units completed per period

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/throughput.yml) · [sql](dbt/analyses/metrics/ops/throughput.sql)
- **Numerator:** Units produced or delivered in period
- **Dimensions:** date, line
- **Data sources:** production
- **Parents:** [`capacity_utilization`](#capacity_utilization)
- **Children:** [`stg_orders_count`](#stg_orders_count)
- **Correlated:** [`cycle_time`](#cycle_time), [`capacity_utilization`](#capacity_utilization), [`ops_efficiency_ratio`](#ops_efficiency_ratio), [`process_automation_rate`](#process_automation_rate)

<a id="ticket_backlog"></a>
### Ticket Backlog — `ticket_backlog`

Open tickets that have been unresolved beyond standard SLA

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/ticket_backlog.yml) · [sql](dbt/analyses/metrics/ops/ticket_backlog.sql)
- **Numerator:** Open tickets beyond SLA threshold
- **Dimensions:** date
- **Data sources:** helpdesk
- **Parents:** [`sla_breach_rate`](#sla_breach_rate)
- **Correlated:** [`sla_breach_rate`](#sla_breach_rate), [`first_response_time`](#first_response_time)

<a id="ticket_resolution_rate"></a>
### Ticket Resolution Rate — `ticket_resolution_rate`

% of opened tickets resolved within SLA window.

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/ticket_resolution_rate.yml) · [sql](dbt/analyses/metrics/ops/ticket_resolution_rate.sql)
- **Numerator:** Tickets Resolved within SLA
- **Denominator:** Total Tickets Opened
- **Dimensions:** priority, category, team, period
- **Data sources:** Support platform
- **Parents:** [`csat`](#csat)
- **Children:** [`support_tickets_opened`](#support_tickets_opened)
- **Correlated:** [`first_response_time`](#first_response_time), [`ces`](#ces)

<a id="ticket_resolution_time"></a>
### Resolution Time — `ticket_resolution_time`

Average time from ticket creation to resolution

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/ticket_resolution_time.yml) · [sql](dbt/analyses/metrics/ops/ticket_resolution_time.sql)
- **Numerator:** Sum of resolution times
- **Denominator:** Tickets resolved
- **Dimensions:** date, channel, priority
- **Data sources:** helpdesk
- **Parents:** [`sla_breach_rate`](#sla_breach_rate)
- **Children:** [`stg_support_tickets`](#stg_support_tickets), [`escalation_rate`](#escalation_rate)
- **Correlated:** [`first_response_time`](#first_response_time), [`fcr_rate`](#fcr_rate), [`escalation_rate`](#escalation_rate), [`stg_support_tickets`](#stg_support_tickets), [`tickets_created`](#tickets_created)

<a id="tickets_per_agent"></a>
### Tickets / Agent / Day — `tickets_per_agent`

Agent productivity measured by tickets closed

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/tickets_per_agent.yml) · [sql](dbt/analyses/metrics/ops/tickets_per_agent.sql)
- **Numerator:** Tickets handled
- **Denominator:** Support agents
- **Dimensions:** date
- **Data sources:** helpdesk
- **Parents:** [`support_cost_per_ticket`](#support_cost_per_ticket)
- **Children:** [`stg_support_tickets`](#stg_support_tickets)
- **Correlated:** [`support_cost_per_ticket`](#support_cost_per_ticket), [`fcr_rate`](#fcr_rate), [`sla_breach_rate`](#sla_breach_rate)

<a id="tickets_per_customer"></a>
### Tickets / Customer — `tickets_per_customer`

Average support burden per customer — proxy for product quality

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/tickets_per_customer.yml) · [sql](dbt/analyses/metrics/ops/tickets_per_customer.sql)
- **Numerator:** Support tickets
- **Denominator:** Active customers
- **Dimensions:** date, segment
- **Data sources:** helpdesk, crm
- **Parents:** [`csat`](#csat)
- **Children:** [`tickets_created`](#tickets_created)
- **Correlated:** [`csat`](#csat), [`support_cost_per_ticket`](#support_cost_per_ticket)

<a id="vendor_scorecard_rating"></a>
### Vendor Scorecard Rating — `vendor_scorecard_rating`

Composite supplier performance score across quality, delivery, and cost dimensions.

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/vendor_scorecard_rating.yml) · [sql](dbt/analyses/metrics/ops/vendor_scorecard_rating.sql)
- **Numerator:** Weighted average of quality, delivery, and cost scores
- **Dimensions:** supplier_id, category, period
- **Data sources:** Procurement system, WMS, QMS
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Children:** [`supplier_lead_time`](#supplier_lead_time), [`defect_rate`](#defect_rate), [`vendor_compliance_rate`](#vendor_compliance_rate)
- **Correlated:** [`fill_rate`](#fill_rate), [`defect_rate`](#defect_rate)

<a id="warehouse_utilization"></a>
### Warehouse Utilization % — `warehouse_utilization`

Percentage of warehouse storage capacity currently in use

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/warehouse_utilization.yml) · [sql](dbt/analyses/metrics/ops/warehouse_utilization.sql)
- **Numerator:** Occupied square footage
- **Denominator:** Total square footage
- **Dimensions:** date, facility
- **Data sources:** warehouse_system
- **Parents:** [`warehouse_utilization_rate`](#warehouse_utilization_rate)
- **Correlated:** [`capacity_utilization`](#capacity_utilization), [`inventory_value`](#inventory_value)

<a id="warehouse_utilization_rate"></a>
### Warehouse Utilization — `warehouse_utilization_rate`

% of available warehouse storage capacity currently in use.

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/warehouse_utilization_rate.yml) · [sql](dbt/analyses/metrics/ops/warehouse_utilization_rate.sql)
- **Numerator:** Occupied Storage Locations
- **Denominator:** Total Storage Locations
- **Dimensions:** warehouse_id, product_zone, period
- **Data sources:** WMS
- **Parents:** [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Children:** [`warehouse_utilization`](#warehouse_utilization)
- **Correlated:** [`fill_rate`](#fill_rate), [`inventory_turnover`](#inventory_turnover)

<a id="arr"></a>
### ARR — `arr`

Annual Recurring Revenue — annualized value of active subscriptions.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/arr.yml) · [sql](dbt/analyses/metrics/pe/arr.sql)
- **Numerator:** Sum of active annual contract values
- **Dimensions:** date, customer_segment, product
- **Data sources:** subscriptions
- **Parents:** [`arr_growth_rate`](#arr_growth_rate), [`arr_per_rep`](#arr_per_rep), [`employees_per_1m_arr`](#employees_per_1m_arr), [`market_penetration_rate`](#market_penetration_rate), [`revenue`](#revenue), [`subscription_revenue`](#subscription_revenue)
- **Children:** [`new_arr`](#new_arr), [`expansion_arr`](#expansion_arr), [`contraction_arr`](#contraction_arr), [`churned_arr`](#churned_arr), [`acv`](#acv), [`bookings`](#bookings), [`churn_rate`](#churn_rate), [`committed_arr`](#committed_arr), [`mrr`](#mrr), [`net_revenue_retention`](#net_revenue_retention), [`stg_subscription_row`](#stg_subscription_row)
- **Correlated:** [`mrr`](#mrr), [`nrr`](#nrr), [`grr`](#grr), [`revenue_growth_rate`](#revenue_growth_rate), [`active_paying_users`](#active_paying_users), [`acv`](#acv), [`billings`](#billings), [`bookings`](#bookings), [`committed_arr`](#committed_arr), [`contracted_unbilled`](#contracted_unbilled), [`customer_concentration_risk`](#customer_concentration_risk), [`deferred_revenue`](#deferred_revenue), [`license_revenue`](#license_revenue), [`market_penetration_rate`](#market_penetration_rate), [`payback_period`](#payback_period), [`recognized_revenue`](#recognized_revenue), [`rule_of_40`](#rule_of_40), [`saas_quick_ratio`](#saas_quick_ratio), [`stg_subscriptions_active`](#stg_subscriptions_active), [`subscription_revenue`](#subscription_revenue), [`total_revenue`](#total_revenue)

<a id="arr_growth_rate"></a>
### ARR Growth % — `arr_growth_rate`

Year-over-year growth in annual recurring revenue

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/arr_growth_rate.yml) · [sql](dbt/analyses/metrics/pe/arr_growth_rate.sql)
- **Numerator:** ARR(end) − ARR(start)
- **Denominator:** ARR(start)
- **Dimensions:** date
- **Data sources:** subscriptions
- **Parents:** [`rule_of_40`](#rule_of_40)
- **Children:** [`arr`](#arr), [`new_arr`](#new_arr), [`net_mrr_growth`](#net_mrr_growth), [`saas_quick_ratio`](#saas_quick_ratio)
- **Correlated:** [`revenue_growth_rate`](#revenue_growth_rate), [`nrr`](#nrr), [`net_new_customers`](#net_new_customers)

<a id="arr_per_rep"></a>
### ARR / Sales Rep — `arr_per_rep`

Total ARR divided by number of quota-carrying reps

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/arr_per_rep.yml) · [sql](dbt/analyses/metrics/pe/arr_per_rep.sql)
- **Numerator:** Total ARR
- **Denominator:** Quota-carrying reps
- **Dimensions:** date
- **Data sources:** subscriptions, employees
- **Parents:** [`revenue_per_employee`](#revenue_per_employee)
- **Children:** [`arr`](#arr), [`sales_headcount`](#sales_headcount)
- **Correlated:** [`quota_attainment`](#quota_attainment), [`cac`](#cac), [`employees_per_1m_arr`](#employees_per_1m_arr), [`sales_headcount`](#sales_headcount)

<a id="billings"></a>
### Billings — `billings`

Total amounts invoiced to customers in a period — cash collection indicator.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/billings.yml) · [sql](dbt/analyses/metrics/pe/billings.sql)
- **Numerator:** SUM(invoiced amounts)
- **Dimensions:** segment, product_tier, period
- **Data sources:** Billing system
- **Parents:** [`revenue`](#revenue)
- **Children:** [`stg_invoice_row`](#stg_invoice_row), [`contracted_unbilled`](#contracted_unbilled), [`recognized_revenue`](#recognized_revenue), [`stg_invoices_amount`](#stg_invoices_amount), [`stg_invoices_count`](#stg_invoices_count)
- **Correlated:** [`arr`](#arr), [`revenue`](#revenue), [`free_cash_flow`](#free_cash_flow), [`accounts_receivable`](#accounts_receivable), [`contracted_unbilled`](#contracted_unbilled), [`deferred_revenue`](#deferred_revenue), [`stg_invoices_amount`](#stg_invoices_amount), [`stg_invoices_count`](#stg_invoices_count)

<a id="bookings"></a>
### Bookings — `bookings`

Total ARR value of contracts signed in the period, regardless of revenue recognition timing.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/bookings.yml) · [sql](dbt/analyses/metrics/pe/bookings.sql)
- **Numerator:** SUM(contract ARR signed in period)
- **Dimensions:** segment, product_tier, channel, period
- **Data sources:** CRM, Finance
- **Parents:** [`arr`](#arr), [`avg_deal_size`](#avg_deal_size), [`avg_sales_cycle`](#avg_sales_cycle), [`new_arr`](#new_arr)
- **Children:** [`stg_opportunity_row`](#stg_opportunity_row), [`sql`](#sql)
- **Correlated:** [`arr`](#arr), [`new_arr`](#new_arr), [`revenue`](#revenue), [`committed_arr`](#committed_arr), [`pipeline_generated`](#pipeline_generated)

<a id="capex_pct_revenue"></a>
### CapEx % Revenue — `capex_pct_revenue`

Capital spend intensity relative to revenue.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/capex_pct_revenue.yml) · [sql](dbt/analyses/metrics/pe/capex_pct_revenue.sql)
- **Numerator:** CapEx
- **Denominator:** Revenue
- **Dimensions:** company_id, fiscal_period
- **Data sources:** ERP
- **Parents:** [`free_cash_flow`](#free_cash_flow)
- **Children:** [`capex`](#capex), [`revenue`](#revenue)
- **Correlated:** [`free_cash_flow`](#free_cash_flow)

<a id="churn_prediction_score"></a>
### Churn Prediction Score — `churn_prediction_score`

ML model score (0–1) indicating probability of a user churning in the next 30 days.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/churn_prediction_score.yml) · [sql](dbt/analyses/metrics/pe/churn_prediction_score.sql)
- **Numerator:** Model output probability
- **Dimensions:** user_id, plan_tier, cohort, score_date
- **Data sources:** Product analytics, ML model output
- **Parents:** [`customer_health_score`](#customer_health_score)
- **Children:** [`dau`](#dau), [`feature_adoption_rate`](#feature_adoption_rate)
- **Correlated:** [`retention_d30`](#retention_d30), [`customer_health_score`](#customer_health_score)

<a id="churn_rate"></a>
### Churn Rate — `churn_rate`

% of revenue or customers lost in a period.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/churn_rate.yml) · [sql](dbt/analyses/metrics/pe/churn_rate.sql)
- **Numerator:** Lost ARR
- **Denominator:** Starting ARR
- **Dimensions:** cohort_month, plan_tier, geography, segment
- **Data sources:** Billing system, CRM
- **Parents:** [`arr`](#arr), [`net_revenue_retention`](#net_revenue_retention), [`customer_ltv`](#customer_ltv)
- **Children:** [`at_risk_accounts`](#at_risk_accounts), [`cohort_churn`](#cohort_churn), [`customer_health_score`](#customer_health_score), [`logo_churn_rate`](#logo_churn_rate), [`mrr_churn_rate`](#mrr_churn_rate)
- **Correlated:** [`ltv_cac`](#ltv_cac), [`customer_health_score`](#customer_health_score), [`arpu`](#arpu), [`at_risk_accounts`](#at_risk_accounts), [`cohort_revenue_retention`](#cohort_revenue_retention), [`csat`](#csat), [`customer_concentration_risk`](#customer_concentration_risk), [`customer_onboarding_time`](#customer_onboarding_time), [`d30_retention`](#d30_retention), [`error_rate`](#error_rate), [`logo_churn_rate`](#logo_churn_rate), [`mrr`](#mrr), [`new_arr`](#new_arr), [`nps`](#nps), [`nrr_monthly`](#nrr_monthly), [`onboarding_completion_rate`](#onboarding_completion_rate), [`payback_period`](#payback_period), [`renewal_rate`](#renewal_rate), [`retention_d30`](#retention_d30), [`support_tickets_opened`](#support_tickets_opened), [`time_to_value`](#time_to_value)

<a id="cohort_revenue_retention"></a>
### Cohort Revenue Retention — `cohort_revenue_retention`

Revenue retained from a signup cohort after N months relative to their initial value.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/cohort_revenue_retention.yml) · [sql](dbt/analyses/metrics/pe/cohort_revenue_retention.sql)
- **Numerator:** Revenue from Cohort in Month N
- **Denominator:** Revenue from Cohort in Month 0
- **Dimensions:** cohort_month, month_number, segment
- **Data sources:** Billing system
- **Parents:** [`net_revenue_retention`](#net_revenue_retention)
- **Children:** [`stg_subscription_row`](#stg_subscription_row)
- **Correlated:** [`churn_rate`](#churn_rate), [`expansion_arr`](#expansion_arr)

<a id="customer_churn_rate"></a>
### Customer Churn % — `customer_churn_rate`

Percentage of customers who stopped purchasing in the period

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/customer_churn_rate.yml) · [sql](dbt/analyses/metrics/pe/customer_churn_rate.sql)
- **Numerator:** Churned customers
- **Denominator:** Beginning customers
- **Dimensions:** date, customer_segment
- **Data sources:** crm, subscriptions
- **Parents:** [`clv`](#clv), [`customer_retention_rate`](#customer_retention_rate), [`net_new_customers`](#net_new_customers)
- **Children:** [`stg_customer_count`](#stg_customer_count)
- **Correlated:** [`logo_churn_rate`](#logo_churn_rate), [`nrr`](#nrr), [`renewal_rate`](#renewal_rate), [`churned_arr`](#churned_arr), [`customer_count`](#customer_count), [`stg_customer_count`](#stg_customer_count)

<a id="customer_concentration_risk"></a>
### Customer Concentration — `customer_concentration_risk`

Top 10 customers’ ARR as % of total ARR — revenue dependency risk indicator.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/customer_concentration_risk.yml) · [sql](dbt/analyses/metrics/pe/customer_concentration_risk.sql)
- **Numerator:** ARR from Top 10 Customers
- **Denominator:** Total ARR
- **Dimensions:** company_id, period
- **Data sources:** Billing system, CRM
- **Parents:** [`enterprise_value`](#enterprise_value)
- **Children:** [`stg_subscription_row`](#stg_subscription_row), [`rev_concentration_top10`](#rev_concentration_top10)
- **Correlated:** [`churn_rate`](#churn_rate), [`arr`](#arr), [`rev_concentration_top10`](#rev_concentration_top10)

<a id="deferred_revenue"></a>
### Deferred Revenue — `deferred_revenue`

Cash collected but not yet recognized as revenue — forward revenue visibility.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/deferred_revenue.yml) · [sql](dbt/analyses/metrics/pe/deferred_revenue.sql)
- **Numerator:** SUM(unrecognized billed amounts)
- **Dimensions:** company_id, product_tier, period
- **Data sources:** ERP, Billing system
- **Parents:** [`operating_cash_flow`](#operating_cash_flow)
- **Children:** [`stg_invoice_row`](#stg_invoice_row)
- **Correlated:** [`arr`](#arr), [`billings`](#billings), [`revenue`](#revenue), [`recognized_revenue`](#recognized_revenue)

<a id="employees_per_1m_arr"></a>
### Employees / $1M ARR — `employees_per_1m_arr`

Operational efficiency — fewer employees per $1M ARR indicates more scalable business

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/employees_per_1m_arr.yml) · [sql](dbt/analyses/metrics/pe/employees_per_1m_arr.sql)
- **Numerator:** Headcount
- **Denominator:** ARR ($M)
- **Dimensions:** date
- **Data sources:** subscriptions, employees
- **Parents:** [`revenue_per_employee`](#revenue_per_employee)
- **Children:** [`arr`](#arr)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`arr_per_rep`](#arr_per_rep), [`revenue_per_employee`](#revenue_per_employee)

<a id="expansion_arr"></a>
### Expansion ARR — `expansion_arr`

ARR added from upsells and cross-sells to existing customers

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/expansion_arr.yml) · [sql](dbt/analyses/metrics/pe/expansion_arr.sql)
- **Parents:** [`arr`](#arr), [`nrr`](#nrr), [`nrr_monthly`](#nrr_monthly), [`saas_quick_ratio`](#saas_quick_ratio)
- **Children:** [`expansion_pipeline`](#expansion_pipeline), [`upsell_rate`](#upsell_rate)
- **Correlated:** [`cohort_revenue_retention`](#cohort_revenue_retention), [`feature_adoption_rate`](#feature_adoption_rate), [`new_arr`](#new_arr), [`rev_from_existing`](#rev_from_existing), [`upsell_rate`](#upsell_rate)

<a id="gna_pct_revenue"></a>
### G&A % Revenue — `gna_pct_revenue`

General and administrative expenses as a share of revenue — overhead efficiency.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/gna_pct_revenue.yml) · [sql](dbt/analyses/metrics/pe/gna_pct_revenue.sql)
- **Numerator:** G&A Spend
- **Denominator:** Revenue
- **Dimensions:** company_id, fiscal_period
- **Data sources:** ERP
- **Parents:** [`opex`](#opex)
- **Children:** [`sg_and_a`](#sg_and_a), [`revenue`](#revenue)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`opex`](#opex)

<a id="grr"></a>
### GRR — `grr`

Retained ARR from existing customers excluding expansions

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/grr.yml) · [sql](dbt/analyses/metrics/pe/grr.sql)
- **Numerator:** Beginning ARR − churn − contraction
- **Denominator:** Beginning ARR
- **Dimensions:** date, customer_segment
- **Data sources:** subscriptions
- **Parents:** [`nrr`](#nrr)
- **Children:** [`churned_arr`](#churned_arr), [`contraction_arr`](#contraction_arr), [`gross_dollar_retention`](#gross_dollar_retention)
- **Correlated:** [`nrr`](#nrr), [`logo_churn_rate`](#logo_churn_rate), [`arr`](#arr), [`gross_dollar_retention`](#gross_dollar_retention)

<a id="hr_cost_pct_revenue"></a>
### HR Cost % of Revenue — `hr_cost_pct_revenue`

Total HR department cost as a fraction of company revenue

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/hr_cost_pct_revenue.yml) · [sql](dbt/analyses/metrics/pe/hr_cost_pct_revenue.sql)
- **Numerator:** HR total cost
- **Denominator:** Revenue
- **Dimensions:** date
- **Data sources:** hris, finance
- **Parents:** [`opex`](#opex)
- **Children:** [`total_comp_expense`](#total_comp_expense), [`cost_per_hire`](#cost_per_hire)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`cost_per_hire`](#cost_per_hire), [`opex`](#opex), [`support_cost_per_ticket`](#support_cost_per_ticket)

<a id="iap_revenue"></a>
### IAP Revenue — `iap_revenue`

Revenue from in-app purchases made by users

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/iap_revenue.yml) · [sql](dbt/analyses/metrics/pe/iap_revenue.sql)
- **Numerator:** In-app purchase revenue
- **Dimensions:** date, product
- **Data sources:** app_stores
- **Parents:** [`revenue`](#revenue)
- **Correlated:** [`arpu`](#arpu), [`aov`](#aov)

<a id="license_revenue"></a>
### License Revenue — `license_revenue`

Revenue from perpetual license sales

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/license_revenue.yml) · [sql](dbt/analyses/metrics/pe/license_revenue.sql)
- **Numerator:** Revenue from perpetual licenses
- **Dimensions:** date, product
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Correlated:** [`services_revenue`](#services_revenue), [`arr`](#arr)

<a id="logo_churn_rate"></a>
### Logo Churn Rate — `logo_churn_rate`

% of customer accounts lost in a period regardless of ARR value.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/logo_churn_rate.yml) · [sql](dbt/analyses/metrics/pe/logo_churn_rate.sql)
- **Numerator:** Customers Lost
- **Denominator:** Total Customers at Start of Period
- **Dimensions:** segment, product_tier, period
- **Data sources:** CRM, Billing system
- **Parents:** [`churn_rate`](#churn_rate)
- **Children:** [`stg_subscription_row`](#stg_subscription_row)
- **Correlated:** [`churn_rate`](#churn_rate), [`customer_health_score`](#customer_health_score), [`churned_arr`](#churned_arr), [`cohort_churn`](#cohort_churn), [`contraction_arr`](#contraction_arr), [`customer_churn_rate`](#customer_churn_rate), [`customer_count`](#customer_count), [`grr`](#grr), [`mrr_churn_rate`](#mrr_churn_rate), [`nrr`](#nrr), [`product_churn_rate`](#product_churn_rate), [`stg_subscriptions_active`](#stg_subscriptions_active)

<a id="market_penetration_rate"></a>
### Market Penetration Rate — `market_penetration_rate`

ARR as a % of Total Addressable Market — how much of the opportunity is captured.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/market_penetration_rate.yml) · [sql](dbt/analyses/metrics/pe/market_penetration_rate.sql)
- **Numerator:** ARR
- **Denominator:** TAM
- **Dimensions:** segment, geography, period
- **Data sources:** Internal finance, Market research
- **Parents:** [`market_share`](#market_share)
- **Children:** [`arr`](#arr), [`tam`](#tam), [`sam`](#sam)
- **Correlated:** [`arr`](#arr), [`revenue_growth_rate`](#revenue_growth_rate)

<a id="mrr"></a>
### MRR — `mrr`

Monthly Recurring Revenue — annualized base ÷ 12.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/mrr.yml) · [sql](dbt/analyses/metrics/pe/mrr.sql)
- **Numerator:** SUM(monthly_amount) WHERE status = 'active'
- **Dimensions:** company_id, plan_tier, customer_id
- **Data sources:** Billing system
- **Parents:** [`arr`](#arr), [`revenue`](#revenue), [`mrr_churn_rate`](#mrr_churn_rate), [`payback_period`](#payback_period), [`subscription_revenue`](#subscription_revenue)
- **Children:** [`stg_subscription_row`](#stg_subscription_row)
- **Correlated:** [`churn_rate`](#churn_rate), [`net_revenue_retention`](#net_revenue_retention), [`arr`](#arr), [`marketing_spend`](#marketing_spend), [`net_mrr_growth`](#net_mrr_growth), [`stg_subscriptions_active`](#stg_subscriptions_active)

<a id="mrr_churn_rate"></a>
### MRR Churn % — `mrr_churn_rate`

Percentage of MRR lost in the period from cancellations

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/mrr_churn_rate.yml) · [sql](dbt/analyses/metrics/pe/mrr_churn_rate.sql)
- **Numerator:** Churned MRR
- **Denominator:** Beginning MRR
- **Dimensions:** date, customer_segment
- **Data sources:** subscriptions
- **Parents:** [`churn_rate`](#churn_rate)
- **Children:** [`mrr`](#mrr), [`churned_arr`](#churned_arr)
- **Correlated:** [`logo_churn_rate`](#logo_churn_rate), [`nrr`](#nrr)

<a id="net_mrr_growth"></a>
### Net MRR Growth — `net_mrr_growth`

New + expansion MRR minus churned + contraction MRR

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/net_mrr_growth.yml) · [sql](dbt/analyses/metrics/pe/net_mrr_growth.sql)
- **Numerator:** MRR(end) − MRR(start)
- **Dimensions:** date
- **Data sources:** subscriptions
- **Parents:** [`arr_growth_rate`](#arr_growth_rate)
- **Correlated:** [`mrr`](#mrr), [`nrr`](#nrr), [`saas_quick_ratio`](#saas_quick_ratio)

<a id="net_revenue"></a>
### Net Revenue — `net_revenue`

Gross revenue minus returns, allowances, and discounts

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/net_revenue.yml) · [sql](dbt/analyses/metrics/pe/net_revenue.sql)
- **Numerator:** Gross revenue − returns − discounts
- **Dimensions:** date, channel
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Children:** [`gross_revenue`](#gross_revenue), [`discount_rate`](#discount_rate)
- **Correlated:** [`gross_revenue`](#gross_revenue), [`refund_rate`](#refund_rate), [`stg_refund_amount`](#stg_refund_amount)

<a id="net_revenue_retention"></a>
### Net Revenue Retention — `net_revenue_retention`

NRR: expansion + contraction + churn as % of prior-period ARR.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/net_revenue_retention.yml) · [sql](dbt/analyses/metrics/pe/net_revenue_retention.sql)
- **Numerator:** Ending ARR (adjusted)
- **Denominator:** Starting ARR
- **Dimensions:** company_id, period, plan_tier
- **Data sources:** Billing system
- **Parents:** [`arr`](#arr)
- **Children:** [`churn_rate`](#churn_rate), [`cohort_revenue_retention`](#cohort_revenue_retention), [`nrr_monthly`](#nrr_monthly), [`renewal_rate`](#renewal_rate)
- **Correlated:** [`ebitda`](#ebitda), [`ltv_cac`](#ltv_cac), [`customer_health_score`](#customer_health_score), [`customer_ltv`](#customer_ltv), [`mrr`](#mrr), [`nrr_monthly`](#nrr_monthly), [`rule_of_40`](#rule_of_40)

<a id="new_arr"></a>
### New ARR — `new_arr`

ARR added from new customer logos in the period

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/new_arr.yml) · [sql](dbt/analyses/metrics/pe/new_arr.sql)
- **Numerator:** ARR from new logos in period
- **Dimensions:** date, sales_rep, channel
- **Data sources:** subscriptions, opportunities
- **Parents:** [`arr`](#arr), [`arr_growth_rate`](#arr_growth_rate), [`magic_number`](#magic_number), [`saas_quick_ratio`](#saas_quick_ratio)
- **Children:** [`bookings`](#bookings), [`stg_subscriptions_active`](#stg_subscriptions_active), [`avg_deal_size`](#avg_deal_size), [`avg_sales_cycle`](#avg_sales_cycle), [`pct_reps_at_quota`](#pct_reps_at_quota), [`pipeline_coverage`](#pipeline_coverage), [`plg_rate`](#plg_rate), [`quota_attainment`](#quota_attainment), [`sales_cycle_length`](#sales_cycle_length), [`win_rate`](#win_rate)
- **Correlated:** [`expansion_arr`](#expansion_arr), [`churn_rate`](#churn_rate), [`acv`](#acv), [`bookings`](#bookings), [`customers_by_channel`](#customers_by_channel), [`partner_revenue`](#partner_revenue), [`pipeline_coverage`](#pipeline_coverage), [`pipeline_value`](#pipeline_value), [`quota_attainment`](#quota_attainment), [`rev_from_new_customers`](#rev_from_new_customers)

<a id="nrr"></a>
### NRR — `nrr`

Beginning ARR plus expansion minus churn and contraction over beginning ARR

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/nrr.yml) · [sql](dbt/analyses/metrics/pe/nrr.sql)
- **Numerator:** Beginning ARR + expansion − contraction − churn
- **Denominator:** Beginning ARR
- **Dimensions:** date, customer_segment
- **Data sources:** subscriptions
- **Parents:** [`rule_of_40`](#rule_of_40)
- **Children:** [`expansion_arr`](#expansion_arr), [`contraction_arr`](#contraction_arr), [`churned_arr`](#churned_arr), [`grr`](#grr)
- **Correlated:** [`grr`](#grr), [`logo_churn_rate`](#logo_churn_rate), [`account_health_score`](#account_health_score), [`arr`](#arr), [`arr_growth_rate`](#arr_growth_rate), [`clv`](#clv), [`cohort_ltv_24m`](#cohort_ltv_24m), [`customer_churn_rate`](#customer_churn_rate), [`customer_retention_rate`](#customer_retention_rate), [`expansion_pipeline`](#expansion_pipeline), [`gross_dollar_retention`](#gross_dollar_retention), [`mrr_churn_rate`](#mrr_churn_rate), [`net_mrr_growth`](#net_mrr_growth), [`rev_concentration_top10`](#rev_concentration_top10), [`rev_from_existing`](#rev_from_existing), [`saas_quick_ratio`](#saas_quick_ratio), [`subscription_revenue`](#subscription_revenue), [`upsell_rate`](#upsell_rate)

<a id="nrr_monthly"></a>
### NRR (Monthly) — `nrr_monthly`

Monthly NRR including expansion, contraction, and churn from the prior-period customer base.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/nrr_monthly.yml) · [sql](dbt/analyses/metrics/pe/nrr_monthly.sql)
- **Numerator:** Ending MRR from Prior-Period Customers
- **Denominator:** Starting MRR from Same Customers
- **Dimensions:** segment, plan_tier, period
- **Data sources:** Billing system
- **Parents:** [`net_revenue_retention`](#net_revenue_retention)
- **Children:** [`expansion_arr`](#expansion_arr), [`churned_arr`](#churned_arr), [`contraction_arr`](#contraction_arr)
- **Correlated:** [`net_revenue_retention`](#net_revenue_retention), [`churn_rate`](#churn_rate), [`renewal_rate`](#renewal_rate)

<a id="partner_revenue"></a>
### Partner Revenue — `partner_revenue`

Revenue sourced or influenced by channel partners

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/partner_revenue.yml) · [sql](dbt/analyses/metrics/pe/partner_revenue.sql)
- **Numerator:** Revenue sourced via partners
- **Dimensions:** date, partner
- **Data sources:** orders, partner_registry
- **Parents:** [`total_revenue`](#total_revenue), [`partner_revenue_pct`](#partner_revenue_pct)
- **Correlated:** [`partner_revenue_pct`](#partner_revenue_pct), [`new_arr`](#new_arr)

<a id="partner_revenue_pct"></a>
### Partner Revenue % — `partner_revenue_pct`

Partner-sourced revenue as a share of total revenue

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/partner_revenue_pct.yml) · [sql](dbt/analyses/metrics/pe/partner_revenue_pct.sql)
- **Numerator:** Partner revenue
- **Denominator:** Total revenue
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Children:** [`partner_revenue`](#partner_revenue)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`partner_revenue`](#partner_revenue), [`revenue_by_channel`](#revenue_by_channel)

<a id="product_churn_rate"></a>
### Product Churn — `product_churn_rate`

Percentage of active users who became inactive this period

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/product_churn_rate.yml) · [sql](dbt/analyses/metrics/pe/product_churn_rate.sql)
- **Numerator:** Users who stopped using product
- **Denominator:** Active users
- **Dimensions:** date
- **Data sources:** users
- **Parents:** [`mau`](#mau)
- **Correlated:** [`logo_churn_rate`](#logo_churn_rate), [`d30_retention`](#d30_retention)

<a id="rd_as_pct_revenue"></a>
### R&D % of Revenue — `rd_as_pct_revenue`

R&D spend as a share of total revenue — tech investment intensity.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/rd_as_pct_revenue.yml) · [sql](dbt/analyses/metrics/pe/rd_as_pct_revenue.sql)
- **Numerator:** R&D Expense
- **Denominator:** Revenue
- **Dimensions:** company_id, fiscal_period
- **Data sources:** ERP
- **Parents:** [`opex`](#opex)
- **Children:** [`rd_expense`](#rd_expense), [`revenue`](#revenue), [`rd_headcount_pct`](#rd_headcount_pct)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`rd_expense`](#rd_expense)

<a id="revenue"></a>
### Revenue — `revenue`

Total recognized revenue in the period.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/revenue.yml) · [sql](dbt/analyses/metrics/pe/revenue.sql)
- **Numerator:** SUM(recognized_amount)
- **Dimensions:** company_id, product_line, geography, channel
- **Data sources:** ERP, CRM, Billing system
- **Parents:** [`ebitda`](#ebitda), [`capex_pct_revenue`](#capex_pct_revenue), [`gna_pct_revenue`](#gna_pct_revenue), [`net_income_margin`](#net_income_margin), [`rd_as_pct_revenue`](#rd_as_pct_revenue), [`revenue_per_employee`](#revenue_per_employee)
- **Children:** [`arr`](#arr), [`mrr`](#mrr), [`arpu`](#arpu), [`asp`](#asp), [`billings`](#billings), [`customer_count`](#customer_count), [`gmv`](#gmv), [`iap_revenue`](#iap_revenue), [`stg_revenue_event_amount`](#stg_revenue_event_amount), [`take_rate`](#take_rate)
- **Correlated:** [`customer_count`](#customer_count), [`arpu`](#arpu), [`asp`](#asp), [`billings`](#billings), [`bookings`](#bookings), [`cogs`](#cogs), [`deferred_revenue`](#deferred_revenue), [`gmv`](#gmv), [`marketing_spend`](#marketing_spend), [`take_rate`](#take_rate)

<a id="revenue_growth_rate"></a>
### Revenue Growth Rate — `revenue_growth_rate`

YoY or QoQ revenue growth percentage.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/revenue_growth_rate.yml) · [sql](dbt/analyses/metrics/pe/revenue_growth_rate.sql)
- **Numerator:** Revenue(t) − Revenue(t−1)
- **Denominator:** Revenue(t−1)
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`rule_of_40`](#rule_of_40)
- **Children:** [`market_share`](#market_share), [`revenue_vs_py`](#revenue_vs_py)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`arr_growth_rate`](#arr_growth_rate), [`revenue_vs_py`](#revenue_vs_py), [`arr`](#arr), [`market_penetration_rate`](#market_penetration_rate), [`market_share`](#market_share), [`monthly_new_customers`](#monthly_new_customers), [`total_revenue`](#total_revenue)

<a id="revenue_per_account"></a>
### Revenue / Account — `revenue_per_account`

Average monthly revenue per active account

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/revenue_per_account.yml) · [sql](dbt/analyses/metrics/pe/revenue_per_account.sql)
- **Numerator:** Revenue
- **Denominator:** Active accounts
- **Dimensions:** date, segment
- **Data sources:** orders, customers
- **Parents:** [`arpu`](#arpu)
- **Correlated:** [`arpu`](#arpu), [`acv`](#acv)

<a id="revenue_per_employee"></a>
### Revenue per Employee — `revenue_per_employee`

Total revenue divided by headcount — operating leverage metric.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/revenue_per_employee.yml) · [sql](dbt/analyses/metrics/pe/revenue_per_employee.sql)
- **Numerator:** Revenue
- **Denominator:** Full-Time Equivalent Headcount
- **Dimensions:** company_id, fiscal_period, department
- **Data sources:** ERP, HRIS
- **Parents:** [`ebitda`](#ebitda), [`employee_lifetime_value`](#employee_lifetime_value)
- **Children:** [`revenue`](#revenue), [`headcount_fte`](#headcount_fte), [`arr_per_rep`](#arr_per_rep), [`employees_per_1m_arr`](#employees_per_1m_arr)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`employees_per_1m_arr`](#employees_per_1m_arr), [`gross_profit_per_employee`](#gross_profit_per_employee), [`headcount_cost`](#headcount_cost), [`workforce_productivity`](#workforce_productivity)

<a id="revenue_vs_py"></a>
### Revenue vs PY — `revenue_vs_py`

Current year revenue vs prior year — year-over-year growth

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/revenue_vs_py.yml) · [sql](dbt/analyses/metrics/pe/revenue_vs_py.sql)
- **Numerator:** Current revenue − Prior year revenue
- **Denominator:** Prior year revenue
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_growth_rate`](#revenue_growth_rate)
- **Children:** [`prior_year_revenue`](#prior_year_revenue)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`revenue_growth_rate`](#revenue_growth_rate), [`forecast_accuracy`](#forecast_accuracy), [`prior_year_revenue`](#prior_year_revenue), [`revenue_ytd`](#revenue_ytd), [`total_revenue`](#total_revenue)

<a id="revenue_ytd"></a>
### Revenue YTD — `revenue_ytd`

Cumulative revenue from the start of the fiscal year to current date

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/revenue_ytd.yml) · [sql](dbt/analyses/metrics/pe/revenue_ytd.sql)
- **Numerator:** Revenue from fiscal year start to date
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Children:** [`q1_revenue`](#q1_revenue), [`q2_revenue`](#q2_revenue), [`q3_revenue`](#q3_revenue), [`q4_revenue`](#q4_revenue)
- **Formula inputs:** [`total_revenue`](#total_revenue)
- **Correlated:** [`revenue_vs_py`](#revenue_vs_py), [`forecast_accuracy`](#forecast_accuracy)

<a id="saas_quick_ratio"></a>
### SaaS Quick Ratio — `saas_quick_ratio`

New + expansion ARR divided by churned + contraction ARR — growth efficiency

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/saas_quick_ratio.yml) · [sql](dbt/analyses/metrics/pe/saas_quick_ratio.sql)
- **Numerator:** New ARR + Expansion ARR
- **Denominator:** Contraction ARR + Churned ARR
- **Dimensions:** date
- **Data sources:** subscriptions
- **Parents:** [`arr_growth_rate`](#arr_growth_rate)
- **Children:** [`new_arr`](#new_arr), [`expansion_arr`](#expansion_arr), [`contraction_arr`](#contraction_arr), [`churned_arr`](#churned_arr)
- **Correlated:** [`nrr`](#nrr), [`rule_of_40`](#rule_of_40), [`arr`](#arr), [`net_mrr_growth`](#net_mrr_growth)

<a id="services_revenue"></a>
### Services Revenue — `services_revenue`

Revenue from professional services engagements

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/services_revenue.yml) · [sql](dbt/analyses/metrics/pe/services_revenue.sql)
- **Numerator:** Revenue from professional services
- **Dimensions:** date, client
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Correlated:** [`license_revenue`](#license_revenue), [`implementation_revenue`](#implementation_revenue)

<a id="subscription_revenue"></a>
### Subscription Revenue — `subscription_revenue`

Revenue from recurring subscription contracts

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/subscription_revenue.yml) · [sql](dbt/analyses/metrics/pe/subscription_revenue.sql)
- **Numerator:** Revenue from subscription contracts
- **Dimensions:** date, plan
- **Data sources:** subscriptions, orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Children:** [`arr`](#arr), [`mrr`](#mrr)
- **Correlated:** [`arr`](#arr), [`nrr`](#nrr)

<a id="api_latency_p95"></a>
### API Latency p95 — `api_latency_p95`

95th percentile API response time in milliseconds.

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/api_latency_p95.yml) · [sql](dbt/analyses/metrics/product/api_latency_p95.sql)
- **Numerator:** PERCENTILE_CONT(0.95) of response_time_ms
- **Dimensions:** endpoint, environment, period
- **Data sources:** APM (Datadog / New Relic)
- **Parents:** [`error_rate`](#error_rate)
- **Children:** [`api_calls_total`](#api_calls_total)
- **Correlated:** [`error_rate`](#error_rate), [`csat`](#csat), [`api_calls_total`](#api_calls_total), [`product_uptime_sla`](#product_uptime_sla)

<a id="bug_escape_rate"></a>
### Bug Escape Rate — `bug_escape_rate`

Percentage of released code that contained production bugs

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/bug_escape_rate.yml) · [sql](dbt/analyses/metrics/product/bug_escape_rate.sql)
- **Numerator:** Bugs found in prod
- **Denominator:** Total bugs
- **Dimensions:** date, severity
- **Data sources:** bug_tracker
- **Parents:** [`error_rate`](#error_rate)
- **Children:** [`code_coverage`](#code_coverage)
- **Correlated:** [`change_failure_rate`](#change_failure_rate), [`code_coverage`](#code_coverage), [`tech_debt_ratio`](#tech_debt_ratio)

<a id="csat"></a>
### CSAT — `csat`

Average satisfaction rating from post-interaction surveys (1–5 or 1–10).

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/csat.yml) · [sql](dbt/analyses/metrics/product/csat.sql)
- **Numerator:** SUM(satisfaction_score)
- **Denominator:** COUNT(responses)
- **Dimensions:** product, channel, support_team, period
- **Data sources:** Survey platform, CRM
- **Parents:** [`customer_health_score`](#customer_health_score)
- **Children:** [`stg_csat_response_row`](#stg_csat_response_row), [`fcr_rate`](#fcr_rate), [`first_response_time`](#first_response_time), [`sla_breach_rate`](#sla_breach_rate), [`ticket_resolution_rate`](#ticket_resolution_rate), [`tickets_per_customer`](#tickets_per_customer), [`time_to_resolution`](#time_to_resolution)
- **Correlated:** [`nps`](#nps), [`churn_rate`](#churn_rate), [`api_latency_p95`](#api_latency_p95), [`app_store_rating`](#app_store_rating), [`ces`](#ces), [`complaint_resolution_rate`](#complaint_resolution_rate), [`complaints_count`](#complaints_count), [`cx_csat`](#cx_csat), [`error_rate`](#error_rate), [`fcr_rate`](#fcr_rate), [`first_response_time`](#first_response_time), [`ops_north_star`](#ops_north_star), [`product_return_rate`](#product_return_rate), [`refund_rate`](#refund_rate), [`review_rating`](#review_rating), [`sla_breach_rate`](#sla_breach_rate), [`sla_compliance_rate`](#sla_compliance_rate), [`support_tickets_opened`](#support_tickets_opened), [`survey_response_rate`](#survey_response_rate), [`tickets_per_customer`](#tickets_per_customer), [`time_to_resolution`](#time_to_resolution)

<a id="customer_retention_rate"></a>
### Customer Retention % — `customer_retention_rate`

Percentage of customers retained from one period to the next

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/customer_retention_rate.yml) · [sql](dbt/analyses/metrics/product/customer_retention_rate.sql)
- **Numerator:** 1 − churn rate
- **Dimensions:** date, customer_segment
- **Data sources:** crm
- **Parents:** [`clv`](#clv)
- **Children:** [`customer_churn_rate`](#customer_churn_rate)
- **Correlated:** [`nrr`](#nrr), [`renewal_rate`](#renewal_rate), [`repeat_purchase_rate`](#repeat_purchase_rate)

<a id="d30_retention"></a>
### D30 Retention — `d30_retention`

Percentage of new users still active 30 days after signup

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/d30_retention.yml) · [sql](dbt/analyses/metrics/product/d30_retention.sql)
- **Numerator:** Day-30 retained users
- **Denominator:** New users in cohort
- **Dimensions:** date, cohort
- **Data sources:** events, users
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`mau`](#mau), [`user_signups`](#user_signups), [`d7_retention`](#d7_retention)
- **Correlated:** [`d7_retention`](#d7_retention), [`churn_rate`](#churn_rate), [`cohort_churn`](#cohort_churn), [`cohort_ltv_12m`](#cohort_ltv_12m), [`product_churn_rate`](#product_churn_rate)

<a id="d7_retention"></a>
### D7 Retention — `d7_retention`

Percentage of new users still active 7 days after signup

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/d7_retention.yml) · [sql](dbt/analyses/metrics/product/d7_retention.sql)
- **Numerator:** Day-7 retained users
- **Denominator:** New users in cohort
- **Dimensions:** date, cohort
- **Data sources:** events, users
- **Parents:** [`d30_retention`](#d30_retention)
- **Children:** [`dau`](#dau), [`user_signups`](#user_signups)
- **Correlated:** [`d30_retention`](#d30_retention), [`activation_rate`](#activation_rate), [`dau_mau_ratio`](#dau_mau_ratio)

<a id="dau"></a>
### DAU — `dau`

Daily Active Users — unique users who performed a qualifying action in a day.

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/dau.yml) · [sql](dbt/analyses/metrics/product/dau.sql)
- **Numerator:** COUNT(DISTINCT user_id WHERE active_event = true)
- **Dimensions:** platform, product_area, user_segment, date
- **Data sources:** Product analytics (Mixpanel / Amplitude / Segment)
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio), [`account_health_score`](#account_health_score), [`churn_prediction_score`](#churn_prediction_score), [`d7_retention`](#d7_retention), [`feature_adoption`](#feature_adoption), [`wau`](#wau)
- **Children:** [`stg_user_event_row`](#stg_user_event_row), [`push_open_rate`](#push_open_rate)
- **Correlated:** [`mau`](#mau), [`wau`](#wau), [`api_consumers`](#api_consumers), [`app_downloads`](#app_downloads), [`avg_session_duration`](#avg_session_duration), [`stg_events_count`](#stg_events_count), [`stg_sessions_count`](#stg_sessions_count)

<a id="dau_mau_ratio"></a>
### DAU/MAU — `dau_mau_ratio`

Stickiness ratio — daily to monthly active user proportion

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/dau_mau_ratio.yml) · [sql](dbt/analyses/metrics/product/dau_mau_ratio.sql)
- **Numerator:** DAU
- **Denominator:** MAU
- **Dimensions:** date
- **Data sources:** events
- **Parents:** [`customer_health_score`](#customer_health_score)
- **Children:** [`dau`](#dau), [`mau`](#mau), [`activation_rate`](#activation_rate), [`avg_session_duration`](#avg_session_duration), [`d30_retention`](#d30_retention), [`error_rate`](#error_rate), [`feature_adoption_rate`](#feature_adoption_rate), [`retention_d30`](#retention_d30), [`session_length`](#session_length), [`sessions_per_user`](#sessions_per_user), [`time_to_value`](#time_to_value), [`wau`](#wau)
- **Correlated:** [`session_length`](#session_length), [`d7_retention`](#d7_retention), [`feature_adoption`](#feature_adoption), [`push_open_rate`](#push_open_rate), [`retention_d30`](#retention_d30), [`sessions_per_user`](#sessions_per_user)

<a id="deployment_frequency"></a>
### Deployment Frequency — `deployment_frequency`

Number of production deployments per week — DORA engineering velocity metric.

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/deployment_frequency.yml) · [sql](dbt/analyses/metrics/product/deployment_frequency.sql)
- **Numerator:** Deployments in period
- **Dimensions:** date, service
- **Data sources:** ci_cd
- **Parents:** [`change_failure_rate`](#change_failure_rate)
- **Children:** [`lead_time_for_changes`](#lead_time_for_changes), [`sprint_velocity`](#sprint_velocity)
- **Correlated:** [`change_failure_rate`](#change_failure_rate), [`pr_merge_time`](#pr_merge_time), [`lead_time_for_changes`](#lead_time_for_changes), [`rd_headcount`](#rd_headcount), [`rd_headcount_pct`](#rd_headcount_pct), [`sprint_velocity`](#sprint_velocity)

<a id="enps"></a>
### eNPS — `enps`

Employee net promoter score — likelihood to recommend the company as a workplace

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/enps.yml) · [sql](dbt/analyses/metrics/product/enps.sql)
- **Numerator:** % Promoters − % Detractors
- **Dimensions:** date, department
- **Data sources:** surveys
- **Parents:** [`engagement_score`](#engagement_score)
- **Correlated:** [`engagement_score`](#engagement_score), [`nps`](#nps)

<a id="feature_adoption_rate"></a>
### Feature Adoption Rate — `feature_adoption_rate`

% of active users who used a specific feature at least once in the period.

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/feature_adoption_rate.yml) · [sql](dbt/analyses/metrics/product/feature_adoption_rate.sql)
- **Numerator:** Users who used feature
- **Denominator:** Total Active Users
- **Dimensions:** feature_name, user_segment, plan_tier, period
- **Data sources:** Product analytics
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio), [`customer_health_score`](#customer_health_score), [`churn_prediction_score`](#churn_prediction_score)
- **Children:** [`stg_user_event_row`](#stg_user_event_row), [`feature_adoption`](#feature_adoption)
- **Correlated:** [`expansion_arr`](#expansion_arr), [`nps`](#nps), [`avg_session_duration`](#avg_session_duration), [`feature_request_volume`](#feature_request_volume), [`onboarding_completion_rate`](#onboarding_completion_rate), [`time_to_value`](#time_to_value)

<a id="gross_dollar_retention"></a>
### Gross $ Retention — `gross_dollar_retention`

Beginning ARR minus churn and contraction, before expansions

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/gross_dollar_retention.yml) · [sql](dbt/analyses/metrics/product/gross_dollar_retention.sql)
- **Numerator:** Beginning ARR − churn − contraction
- **Denominator:** Beginning ARR
- **Dimensions:** date, segment
- **Data sources:** subscriptions
- **Parents:** [`grr`](#grr)
- **Correlated:** [`nrr`](#nrr), [`grr`](#grr)

<a id="mau"></a>
### MAU — `mau`

Monthly Active Users — unique users active in the last 30 days.

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/mau.yml) · [sql](dbt/analyses/metrics/product/mau.sql)
- **Numerator:** COUNT(DISTINCT user_id WHERE active in last 30 days)
- **Dimensions:** platform, product_area, user_segment
- **Data sources:** Product analytics
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio), [`active_paying_users`](#active_paying_users), [`d30_retention`](#d30_retention)
- **Children:** [`stg_user_event_row`](#stg_user_event_row), [`api_consumers`](#api_consumers), [`new_user_signups`](#new_user_signups), [`product_churn_rate`](#product_churn_rate)
- **Correlated:** [`dau`](#dau), [`wau`](#wau)

<a id="product_uptime_sla"></a>
### Product Uptime SLA — `product_uptime_sla`

% of time the product is fully operational within its contractual SLA (e.g. 99.9%).

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/product_uptime_sla.yml) · [sql](dbt/analyses/metrics/product/product_uptime_sla.sql)
- **Numerator:** Uptime Minutes
- **Denominator:** Total Scheduled Minutes
- **Dimensions:** service, environment, period
- **Data sources:** Status page, APM (Datadog / PagerDuty)
- **Parents:** [`error_rate`](#error_rate)
- **Children:** [`stg_downtime_event_row`](#stg_downtime_event_row), [`uptime`](#uptime)
- **Correlated:** [`error_rate`](#error_rate), [`api_latency_p95`](#api_latency_p95)

<a id="retention_d30"></a>
### D30 Retention — `retention_d30`

% of users who return and are active 30 days after first use.

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/retention_d30.yml) · [sql](dbt/analyses/metrics/product/retention_d30.sql)
- **Numerator:** Users active on Day 30
- **Denominator:** Users who joined on Day 0
- **Dimensions:** cohort, acquisition_channel, plan_tier
- **Data sources:** Product analytics
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`stg_user_event_row`](#stg_user_event_row)
- **Correlated:** [`churn_rate`](#churn_rate), [`dau_mau_ratio`](#dau_mau_ratio), [`churn_prediction_score`](#churn_prediction_score)

<a id="system_uptime"></a>
### System Uptime — `system_uptime`

% of scheduled operating time that systems or equipment are available and running.

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/system_uptime.yml) · [sql](dbt/analyses/metrics/product/system_uptime.sql)
- **Numerator:** Uptime Hours
- **Denominator:** Scheduled Hours
- **Dimensions:** system_id, facility_id, period
- **Data sources:** SCADA, APM, CMMS
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Children:** [`stg_downtime_event_row`](#stg_downtime_event_row), [`mtbf`](#mtbf), [`mttr`](#mttr), [`work_order_resolution_time`](#work_order_resolution_time)
- **Correlated:** [`preventive_maintenance_rate`](#preventive_maintenance_rate), [`mtbf`](#mtbf)

<a id="uptime"></a>
### Uptime % — `uptime`

Percentage of scheduled uptime the service was available

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/uptime.yml) · [sql](dbt/analyses/metrics/product/uptime.sql)
- **Numerator:** Minutes available
- **Denominator:** Total minutes
- **Dimensions:** date, service
- **Data sources:** monitoring
- **Parents:** [`product_uptime_sla`](#product_uptime_sla)
- **Children:** [`incident_count`](#incident_count), [`change_failure_rate`](#change_failure_rate), [`mttd`](#mttd), [`rcr_rate`](#rcr_rate)
- **Correlated:** [`error_rate`](#error_rate), [`mttr`](#mttr)

<a id="wau"></a>
### WAU — `wau`

Weekly Active Users — unique users who performed a qualifying action in a 7-day window.

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/wau.yml) · [sql](dbt/analyses/metrics/product/wau.sql)
- **Numerator:** Distinct active users in 7 days
- **Dimensions:** date, platform
- **Data sources:** events
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`dau`](#dau)
- **Correlated:** [`dau`](#dau), [`mau`](#mau)

## Input (152)

<a id="shrinkage_rate"></a>
### Shrinkage Rate — `shrinkage_rate`

Inventory lost to theft, damage, or administrative error as a percentage of stock

- **Vertical:** Customer & Revenue · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/customer/shrinkage_rate.yml) · [sql](dbt/analyses/metrics/customer/shrinkage_rate.sql)
- **Numerator:** Inventory shrinkage
- **Denominator:** Beginning inventory value
- **Dimensions:** date, location
- **Data sources:** inventory
- **Parents:** [`cogs`](#cogs)
- **Correlated:** [`inventory_value`](#inventory_value), [`vendor_compliance_rate`](#vendor_compliance_rate)

<a id="stg_invoices_amount"></a>
### Invoice Amount — `stg_invoices_amount`

Sum of all invoice amounts in staging

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/stg_invoices_amount.yml) · [sql](dbt/analyses/metrics/customer/stg_invoices_amount.sql)
- **Numerator:** Sum of invoice amounts
- **Dimensions:** date
- **Data sources:** invoices
- **Parents:** [`billings`](#billings)
- **Correlated:** [`billings`](#billings), [`recognized_revenue`](#recognized_revenue)

<a id="stg_invoices_count"></a>
### Invoices — `stg_invoices_count`

Raw invoice row count from billing system staging

- **Vertical:** Customer & Revenue · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/stg_invoices_count.yml) · [sql](dbt/analyses/metrics/customer/stg_invoices_count.sql)
- **Numerator:** Invoice records
- **Dimensions:** date
- **Data sources:** invoices
- **Parents:** [`billings`](#billings)
- **Correlated:** [`billings`](#billings), [`dso`](#dso)

<a id="stg_purchases_count"></a>
### Purchases — `stg_purchases_count`

Raw purchase transaction count in staging

- **Vertical:** Customer & Revenue · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/customer/stg_purchases_count.yml) · [sql](dbt/analyses/metrics/customer/stg_purchases_count.sql)
- **Numerator:** Purchase records
- **Dimensions:** date, product
- **Data sources:** orders
- **Parents:** [`aov`](#aov), [`cross_sell_rate`](#cross_sell_rate), [`purchase_frequency`](#purchase_frequency), [`refund_rate`](#refund_rate), [`repeat_purchase_rate`](#repeat_purchase_rate), [`upsell_rate`](#upsell_rate)
- **Correlated:** [`purchase_frequency`](#purchase_frequency), [`aov`](#aov), [`repeat_purchase_rate`](#repeat_purchase_rate)

<a id="stg_refund_amount"></a>
### Refund Amount — `stg_refund_amount`

Total refund value in staging

- **Vertical:** Customer & Revenue · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/customer/stg_refund_amount.yml) · [sql](dbt/analyses/metrics/customer/stg_refund_amount.sql)
- **Numerator:** Sum of refund amounts
- **Dimensions:** date
- **Data sources:** returns
- **Parents:** [`refund_rate`](#refund_rate)
- **Correlated:** [`refund_rate`](#refund_rate), [`net_revenue`](#net_revenue)

<a id="stg_refunds_count"></a>
### Refunds — `stg_refunds_count`

Raw refund transaction count in staging

- **Vertical:** Customer & Revenue · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/customer/stg_refunds_count.yml) · [sql](dbt/analyses/metrics/customer/stg_refunds_count.sql)
- **Numerator:** Refund records
- **Dimensions:** date, product
- **Data sources:** returns
- **Parents:** [`refund_rate`](#refund_rate)
- **Correlated:** [`refund_rate`](#refund_rate), [`product_return_rate`](#product_return_rate)

<a id="adm"></a>
### ADM — `adm`

Average number of students enrolled per day (used for funding calculations)

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/adm.yml) · [sql](dbt/analyses/metrics/edu/adm.sql)
- **Numerator:** Average daily membership
- **Dimensions:** school_year
- **Data sources:** attendance
- **Parents:** [`student_attendance_rate`](#student_attendance_rate)
- **Correlated:** [`school_enrollment`](#school_enrollment), [`per_pupil_expenditure`](#per_pupil_expenditure)

<a id="avg_teacher_experience"></a>
### Avg Teacher Exp (yrs) — `avg_teacher_experience`

Average years of teaching experience across the teaching staff

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/avg_teacher_experience.yml) · [sql](dbt/analyses/metrics/edu/avg_teacher_experience.sql)
- **Numerator:** Average years of teaching experience
- **Dimensions:** school_year, school
- **Data sources:** hris
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`teacher_retention_rate`](#teacher_retention_rate), [`ela_proficiency_rate`](#ela_proficiency_rate)

<a id="ell_pct"></a>
### ELL Students % — `ell_pct`

Percentage of enrolled students classified as English Language Learners

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/ell_pct.yml) · [sql](dbt/analyses/metrics/edu/ell_pct.sql)
- **Numerator:** English Language Learner students
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school
- **Data sources:** enrollment
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`ela_proficiency_rate`](#ela_proficiency_rate), [`chronic_absenteeism_rate`](#chronic_absenteeism_rate)

<a id="frl_pct"></a>
### FRL % — `frl_pct`

Percentage of students eligible for free or reduced-price lunch (socioeconomic indicator)

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/frl_pct.yml) · [sql](dbt/analyses/metrics/edu/frl_pct.sql)
- **Numerator:** Free/reduced-price lunch eligible students
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school
- **Data sources:** enrollment
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`iep_pct`](#iep_pct), [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`per_pupil_expenditure`](#per_pupil_expenditure)

<a id="iep_pct"></a>
### IEP Students % — `iep_pct`

Percentage of enrolled students with an Individualized Education Program

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/iep_pct.yml) · [sql](dbt/analyses/metrics/edu/iep_pct.sql)
- **Numerator:** Students with IEPs
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school
- **Data sources:** special_education
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`per_pupil_expenditure`](#per_pupil_expenditure), [`ela_proficiency_rate`](#ela_proficiency_rate), [`frl_pct`](#frl_pct)

<a id="instructional_minutes"></a>
### Instructional Minutes — `instructional_minutes`

Average minutes of scheduled instruction delivered per student per school day.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/instructional_minutes.yml) · [sql](dbt/analyses/metrics/edu/instructional_minutes.sql)
- **Numerator:** Scheduled instructional minutes delivered
- **Denominator:** Student school days
- **Dimensions:** school_year, school, grade_level
- **Data sources:** SIS, class_schedules
- **Parents:** [`student_proficiency`](#student_proficiency)

<a id="school_enrollment"></a>
### School Enrollment — `school_enrollment`

Total student headcount enrolled in the school or district

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/school_enrollment.yml) · [sql](dbt/analyses/metrics/edu/school_enrollment.sql)
- **Numerator:** Active enrolled students
- **Dimensions:** school_year, school
- **Data sources:** enrollment
- **Parents:** [`ap_participation_rate`](#ap_participation_rate)
- **Correlated:** [`adm`](#adm), [`per_pupil_expenditure`](#per_pupil_expenditure)

<a id="stg_student_assessment_row"></a>
### Raw Assessment Row — `stg_student_assessment_row`

Individual student assessment result record by subject and grade.

- **Vertical:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/edu/stg_student_assessment_row.yml) · [sql](dbt/analyses/metrics/edu/stg_student_assessment_row.sql)
- **Numerator:** score
- **Dimensions:** student_id, assessment_id, subject, grade_level, assessment_date
- **Data sources:** SIS, Assessment platform
- **Parents:** [`student_proficiency`](#student_proficiency), [`ell_proficiency_growth`](#ell_proficiency_growth), [`student_growth_percentile`](#student_growth_percentile)

<a id="accounts_payable"></a>
### Accounts Payable — `accounts_payable`

Outstanding amounts owed to vendors

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/accounts_payable.yml) · [sql](dbt/analyses/metrics/finance/accounts_payable.sql)
- **Numerator:** Outstanding vendor invoices
- **Dimensions:** date
- **Data sources:** purchase_orders
- **Parents:** [`current_ratio`](#current_ratio), [`dpo`](#dpo), [`working_capital`](#working_capital)
- **Correlated:** [`dpo`](#dpo), [`working_capital`](#working_capital)

<a id="accounts_receivable"></a>
### Accounts Receivable — `accounts_receivable`

Outstanding invoices owed to the company

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/accounts_receivable.yml) · [sql](dbt/analyses/metrics/finance/accounts_receivable.sql)
- **Numerator:** Outstanding customer invoices
- **Dimensions:** date
- **Data sources:** invoices
- **Parents:** [`current_ratio`](#current_ratio), [`dso`](#dso), [`working_capital`](#working_capital)
- **Correlated:** [`dso`](#dso), [`billings`](#billings)

<a id="annual_budget"></a>
### Annual Budget — `annual_budget`

Total approved budget for the fiscal year

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/annual_budget.yml) · [sql](dbt/analyses/metrics/finance/annual_budget.sql)
- **Numerator:** Approved annual budget
- **Dimensions:** date
- **Data sources:** budgets
- **Parents:** [`budget_variance`](#budget_variance), [`forecast_accuracy`](#forecast_accuracy), [`headcount_vs_budget`](#headcount_vs_budget)
- **Correlated:** [`budget_variance`](#budget_variance), [`opex`](#opex)

<a id="app_downloads"></a>
### App Downloads — `app_downloads`

Total app installs from app stores in the period

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/app_downloads.yml) · [sql](dbt/analyses/metrics/finance/app_downloads.sql)
- **Numerator:** App installs in period
- **Dimensions:** date, platform
- **Data sources:** app_stores
- **Parents:** [`new_user_signups`](#new_user_signups)
- **Correlated:** [`dau`](#dau), [`activation_rate`](#activation_rate)

<a id="backlink_count"></a>
### Backlinks — `backlink_count`

Total referring domain backlinks to the site — SEO authority signal.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/backlink_count.yml) · [sql](dbt/analyses/metrics/finance/backlink_count.sql)
- **Numerator:** COUNT(referring domains)
- **Dimensions:** domain, link_type, period
- **Data sources:** Ahrefs, SEMrush
- **Parents:** [`domain_authority`](#domain_authority)
- **Correlated:** [`domain_authority`](#domain_authority), [`organic_sessions`](#organic_sessions), [`referral_sessions`](#referral_sessions)

<a id="backlinks_count"></a>
### Backlinks — `backlinks_count`

Total referring backlinks to the domain

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/backlinks_count.yml) · [sql](dbt/analyses/metrics/finance/backlinks_count.sql)
- **Numerator:** External links pointing to site
- **Dimensions:** date
- **Data sources:** seo_tools
- **Parents:** [`domain_authority`](#domain_authority)
- **Correlated:** [`domain_authority`](#domain_authority), [`organic_traffic`](#organic_traffic), [`keywords_top10`](#keywords_top10)

<a id="benefits_utilization"></a>
### Benefits Utilization % — `benefits_utilization`

Percentage of eligible employees actively using offered benefits

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/benefits_utilization.yml) · [sql](dbt/analyses/metrics/finance/benefits_utilization.sql)
- **Numerator:** Employees using benefits
- **Denominator:** Eligible employees
- **Dimensions:** date
- **Data sources:** benefits_admin
- **Parents:** [`engagement_score`](#engagement_score)
- **Correlated:** [`engagement_score`](#engagement_score), [`total_comp_expense`](#total_comp_expense)

<a id="cash_and_equivalents"></a>
### Cash & Equivalents — `cash_and_equivalents`

Cash on hand and liquid short-term instruments

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cash_and_equivalents.yml) · [sql](dbt/analyses/metrics/finance/cash_and_equivalents.sql)
- **Numerator:** Cash on balance sheet
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`current_ratio`](#current_ratio), [`net_debt`](#net_debt), [`working_capital`](#working_capital)
- **Correlated:** [`burn_rate`](#burn_rate), [`runway_months`](#runway_months), [`dso`](#dso)

<a id="code_coverage"></a>
### Code Coverage % — `code_coverage`

Percentage of codebase covered by automated tests

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/code_coverage.yml) · [sql](dbt/analyses/metrics/finance/code_coverage.sql)
- **Numerator:** Lines covered by tests
- **Denominator:** Total lines
- **Dimensions:** date, service
- **Data sources:** ci_cd
- **Parents:** [`bug_escape_rate`](#bug_escape_rate)
- **Correlated:** [`bug_escape_rate`](#bug_escape_rate), [`change_failure_rate`](#change_failure_rate), [`tech_debt_ratio`](#tech_debt_ratio)

<a id="cogs_stg"></a>
### COGS — `cogs_stg`

Direct costs attributable to production of goods sold

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cogs_stg.yml) · [sql](dbt/analyses/metrics/finance/cogs_stg.sql)
- **Numerator:** Cost of goods sold
- **Dimensions:** date, product
- **Data sources:** orders, inventory
- **Parents:** [`gross_profit`](#gross_profit), [`dpo`](#dpo), [`inventory_turnover`](#inventory_turnover)
- **Correlated:** [`gross_margin_pct`](#gross_margin_pct), [`inventory_turnover`](#inventory_turnover), [`inventory_value`](#inventory_value)

<a id="contracted_unbilled"></a>
### Contracted Unbilled — `contracted_unbilled`

ARR under contract not yet invoiced

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/contracted_unbilled.yml) · [sql](dbt/analyses/metrics/finance/contracted_unbilled.sql)
- **Numerator:** Contracted value not yet invoiced
- **Dimensions:** date
- **Data sources:** contracts
- **Parents:** [`billings`](#billings)
- **Correlated:** [`arr`](#arr), [`billings`](#billings), [`committed_arr`](#committed_arr)

<a id="customer_count"></a>
### Customer Count — `customer_count`

Total number of active paying customers

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/customer_count.yml) · [sql](dbt/analyses/metrics/finance/customer_count.sql)
- **Numerator:** Active customers at period end
- **Dimensions:** date, segment
- **Data sources:** crm
- **Parents:** [`revenue`](#revenue)
- **Children:** [`stg_customer_count`](#stg_customer_count)
- **Correlated:** [`net_new_customers`](#net_new_customers), [`logo_churn_rate`](#logo_churn_rate), [`customer_churn_rate`](#customer_churn_rate), [`revenue`](#revenue)

<a id="customers_by_channel"></a>
### Customers by Channel — `customers_by_channel`

Count of new customers attributable to each acquisition channel.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/customers_by_channel.yml) · [sql](dbt/analyses/metrics/finance/customers_by_channel.sql)
- **Numerator:** COUNT(customers WHERE acquisition_channel = X)
- **Dimensions:** acquisition_channel, segment, period
- **Data sources:** CRM, Attribution model
- **Parents:** [`cac`](#cac)
- **Children:** [`stg_lead_row`](#stg_lead_row)
- **Correlated:** [`cac`](#cac), [`new_arr`](#new_arr)

<a id="da"></a>
### D&A — `da`

Non-cash charges for the period

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/da.yml) · [sql](dbt/analyses/metrics/finance/da.sql)
- **Numerator:** Depreciation + amortization
- **Dimensions:** date
- **Data sources:** fixed_assets
- **Parents:** [`ebitda`](#ebitda), [`operating_cash_flow`](#operating_cash_flow)
- **Correlated:** [`capex`](#capex), [`free_cash_flow`](#free_cash_flow)

<a id="demo_requests"></a>
### Demo Requests — `demo_requests`

Product demo requests submitted in the period

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/demo_requests.yml) · [sql](dbt/analyses/metrics/finance/demo_requests.sql)
- **Numerator:** Demo requests submitted
- **Dimensions:** date, channel
- **Data sources:** crm, website
- **Parents:** [`mql`](#mql)
- **Correlated:** [`mql`](#mql), [`sql`](#sql), [`form_conversion_rate`](#form_conversion_rate)

<a id="discount_rate"></a>
### Discount Rate — `discount_rate`

Percentage of gross revenue given away as discounts

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/discount_rate.yml) · [sql](dbt/analyses/metrics/finance/discount_rate.sql)
- **Numerator:** Total discounts given
- **Denominator:** Gross revenue
- **Dimensions:** date, product
- **Data sources:** orders
- **Parents:** [`net_revenue`](#net_revenue)
- **Correlated:** [`gross_revenue`](#gross_revenue), [`aov`](#aov)

<a id="ebitda_bridge_price"></a>
### EBITDA Bridge: Price — `ebitda_bridge_price`

Price/mix contribution to EBITDA variance vs prior period.

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/ebitda_bridge_price.yml) · [sql](dbt/analyses/metrics/finance/ebitda_bridge_price.sql)
- **Numerator:** (Current Price - Prior Price) × Prior Volume
- **Dimensions:** company_id, product_line, fiscal_period
- **Data sources:** ERP, Pricing system
- **Parents:** [`ebitda`](#ebitda)
- **Correlated:** [`ebitda_bridge_volume`](#ebitda_bridge_volume)

<a id="ebitda_bridge_volume"></a>
### EBITDA Bridge: Volume — `ebitda_bridge_volume`

Volume contribution to EBITDA variance vs prior period.

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/ebitda_bridge_volume.yml) · [sql](dbt/analyses/metrics/finance/ebitda_bridge_volume.sql)
- **Numerator:** (Current Volume - Prior Volume) × Prior Price
- **Dimensions:** company_id, product_line, fiscal_period
- **Data sources:** ERP
- **Parents:** [`ebitda`](#ebitda)
- **Correlated:** [`ebitda_bridge_price`](#ebitda_bridge_price)

<a id="energy_cost_per_unit"></a>
### Energy Cost per Unit — `energy_cost_per_unit`

Energy expense allocated per unit of output — sustainability and efficiency signal.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/energy_cost_per_unit.yml) · [sql](dbt/analyses/metrics/finance/energy_cost_per_unit.sql)
- **Numerator:** Energy Cost
- **Denominator:** Units Produced
- **Dimensions:** facility_id, production_line, period
- **Data sources:** Energy monitoring, ERP
- **Parents:** [`cost_per_unit`](#cost_per_unit)
- **Correlated:** [`capacity_utilization_rate`](#capacity_utilization_rate), [`carbon_emissions_per_unit`](#carbon_emissions_per_unit)

<a id="event_attendees"></a>
### Event Attendees — `event_attendees`

Total attendees at company-sponsored events in the period

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/event_attendees.yml) · [sql](dbt/analyses/metrics/finance/event_attendees.sql)
- **Numerator:** Event attendees
- **Dimensions:** date, event
- **Data sources:** events_platform
- **Parents:** [`mql`](#mql)
- **Correlated:** [`mql`](#mql), [`cost_per_event_attendee`](#cost_per_event_attendee)

<a id="expulsion_rate"></a>
### Expulsion Rate — `expulsion_rate`

Percentage of students expelled during the school year

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/expulsion_rate.yml) · [sql](dbt/analyses/metrics/finance/expulsion_rate.sql)
- **Numerator:** Students expelled
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school
- **Data sources:** discipline
- **Parents:** [`suspension_rate`](#suspension_rate)
- **Correlated:** [`suspension_rate`](#suspension_rate), [`dropout_rate`](#dropout_rate)

<a id="extracurricular_rate"></a>
### Extracurricular % — `extracurricular_rate`

Percentage of students participating in at least one extracurricular activity

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/extracurricular_rate.yml) · [sql](dbt/analyses/metrics/finance/extracurricular_rate.sql)
- **Numerator:** Students in extracurriculars
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school
- **Data sources:** extracurricular
- **Parents:** [`school_climate_score`](#school_climate_score)
- **Correlated:** [`school_climate_score`](#school_climate_score), [`student_attendance_rate`](#student_attendance_rate)

<a id="family_engagement_rate"></a>
### Family Engagement % — `family_engagement_rate`

Percentage of families attending at least one school event or conference

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/family_engagement_rate.yml) · [sql](dbt/analyses/metrics/finance/family_engagement_rate.sql)
- **Numerator:** Families attending events or conferences
- **Denominator:** Total families
- **Dimensions:** school_year, school
- **Data sources:** family_engagement_log
- **Parents:** [`school_climate_score`](#school_climate_score)
- **Correlated:** [`school_climate_score`](#school_climate_score), [`student_attendance_rate`](#student_attendance_rate)

<a id="feature_request_volume"></a>
### Feature Request Volume — `feature_request_volume`

Count of feature requests submitted via support, NPS verbatims, or feedback tools.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/feature_request_volume.yml) · [sql](dbt/analyses/metrics/finance/feature_request_volume.sql)
- **Numerator:** COUNT(feature requests)
- **Dimensions:** feature_area, segment, channel, period
- **Data sources:** Product feedback tool (Productboard / Canny)
- **Parents:** [`nps`](#nps)
- **Correlated:** [`nps`](#nps), [`feature_adoption_rate`](#feature_adoption_rate)

<a id="funnel_dropoff"></a>
### Funnel Drop-off — `funnel_dropoff`

Percentage of users who exit the conversion funnel at a given step

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/funnel_dropoff.yml) · [sql](dbt/analyses/metrics/finance/funnel_dropoff.sql)
- **Numerator:** Users at step N
- **Denominator:** Users at step N−1
- **Dimensions:** date, funnel_step
- **Data sources:** analytics
- **Parents:** [`activation_rate`](#activation_rate)
- **Correlated:** [`activation_rate`](#activation_rate), [`session_to_lead_rate`](#session_to_lead_rate)

<a id="impressions"></a>
### Impressions — `impressions`

Total ad impressions served in the period.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/impressions.yml) · [sql](dbt/analyses/metrics/finance/impressions.sql)
- **Numerator:** SUM(impressions)
- **Dimensions:** channel, campaign, ad_set, date
- **Data sources:** Google Ads, Meta Ads, LinkedIn Ads
- **Parents:** [`ctr`](#ctr), [`cpm`](#cpm)
- **Children:** [`stg_ad_spend_row`](#stg_ad_spend_row)
- **Correlated:** [`ad_clicks`](#ad_clicks), [`share_of_voice`](#share_of_voice), [`social_followers`](#social_followers)

<a id="marketplace_buyers"></a>
### Active Buyers — `marketplace_buyers`

Number of unique buyers transacting in the period

- **Vertical:** Finance & FP&A · **Industry:** marketplace
- **Files:** [yml](dbt/models/metrics/finance/marketplace_buyers.yml) · [sql](dbt/analyses/metrics/finance/marketplace_buyers.sql)
- **Numerator:** Active buyers in period
- **Dimensions:** date
- **Data sources:** marketplace
- **Parents:** [`gmv`](#gmv)
- **Correlated:** [`marketplace_sellers`](#marketplace_sellers), [`aov`](#aov)

<a id="marketplace_sellers"></a>
### Active Sellers — `marketplace_sellers`

Number of active sellers transacting on the platform in the period

- **Vertical:** Finance & FP&A · **Industry:** marketplace
- **Files:** [yml](dbt/models/metrics/finance/marketplace_sellers.yml) · [sql](dbt/analyses/metrics/finance/marketplace_sellers.sql)
- **Numerator:** Active sellers in period
- **Dimensions:** date
- **Data sources:** marketplace
- **Parents:** [`gmv`](#gmv)
- **Correlated:** [`marketplace_buyers`](#marketplace_buyers), [`take_rate`](#take_rate), [`liquidity_rate`](#liquidity_rate)

<a id="monthly_new_customers"></a>
### Monthly New Customers — `monthly_new_customers`

Number of new unique paying customers acquired in the month

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/monthly_new_customers.yml) · [sql](dbt/analyses/metrics/finance/monthly_new_customers.sql)
- **Numerator:** New customers acquired in month
- **Dimensions:** date, channel
- **Data sources:** crm, orders
- **Parents:** [`net_new_customers`](#net_new_customers), [`cac`](#cac)
- **Correlated:** [`cac`](#cac), [`revenue_growth_rate`](#revenue_growth_rate)

<a id="on_time_lesson_delivery"></a>
### On-Time Lesson Delivery — `on_time_lesson_delivery`

% of planned lessons delivered on schedule per teacher or classroom.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/on_time_lesson_delivery.yml) · [sql](dbt/analyses/metrics/finance/on_time_lesson_delivery.sql)
- **Numerator:** Lessons Delivered on Time
- **Denominator:** Total Lessons Planned
- **Dimensions:** teacher_id, school_id, subject, period
- **Data sources:** Curriculum management system
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`teacher_retention_rate`](#teacher_retention_rate), [`attendance_rate`](#attendance_rate)

<a id="open_requisitions"></a>
### Open Requisitions — `open_requisitions`

Number of currently unfilled job postings

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/open_requisitions.yml) · [sql](dbt/analyses/metrics/finance/open_requisitions.sql)
- **Numerator:** Open job requisitions
- **Dimensions:** date, department
- **Data sources:** ats
- **Parents:** [`time_to_hire`](#time_to_hire)
- **Correlated:** [`time_to_fill`](#time_to_fill), [`headcount_vs_budget`](#headcount_vs_budget)

<a id="oss_stars"></a>
### OSS Stars — `oss_stars`

GitHub stars on the company's primary open source repositories

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/oss_stars.yml) · [sql](dbt/analyses/metrics/finance/oss_stars.sql)
- **Numerator:** GitHub stars on public repositories
- **Dimensions:** date, repo
- **Data sources:** github
- **Parents:** [`viral_coefficient`](#viral_coefficient)
- **Correlated:** [`domain_authority`](#domain_authority), [`viral_coefficient`](#viral_coefficient)

<a id="overtime_hours"></a>
### Overtime Hours — `overtime_hours`

Total overtime hours logged by employees in the period

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/overtime_hours.yml) · [sql](dbt/analyses/metrics/finance/overtime_hours.sql)
- **Numerator:** Overtime hours logged
- **Dimensions:** date, department
- **Data sources:** time_records
- **Parents:** [`workforce_productivity`](#workforce_productivity)
- **Correlated:** [`workforce_productivity`](#workforce_productivity), [`absenteeism_rate`](#absenteeism_rate)

<a id="pr_mentions"></a>
### PR Mentions — `pr_mentions`

Total brand mentions in press or media in the period

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/pr_mentions.yml) · [sql](dbt/analyses/metrics/finance/pr_mentions.sql)
- **Numerator:** PR mentions in period
- **Dimensions:** date, outlet
- **Data sources:** media_monitoring
- **Parents:** [`earned_media_value`](#earned_media_value)
- **Correlated:** [`earned_media_value`](#earned_media_value), [`domain_authority`](#domain_authority), [`social_engagement_rate`](#social_engagement_rate)

<a id="pr_merge_time"></a>
### PR Merge Time — `pr_merge_time`

Average hours from PR opening to merge

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/pr_merge_time.yml) · [sql](dbt/analyses/metrics/finance/pr_merge_time.sql)
- **Numerator:** Time from PR open to merge (hours)
- **Dimensions:** date, team
- **Data sources:** git
- **Parents:** [`lead_time_for_changes`](#lead_time_for_changes)
- **Correlated:** [`deployment_frequency`](#deployment_frequency), [`sprint_velocity`](#sprint_velocity)

<a id="recruiting_pipeline"></a>
### Recruiting Pipeline — `recruiting_pipeline`

Number of active candidates across all open requisitions

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/recruiting_pipeline.yml) · [sql](dbt/analyses/metrics/finance/recruiting_pipeline.sql)
- **Numerator:** Active candidates in pipeline
- **Dimensions:** date, department
- **Data sources:** ats
- **Parents:** [`offer_acceptance_rate`](#offer_acceptance_rate), [`time_to_hire`](#time_to_hire)
- **Correlated:** [`time_to_hire`](#time_to_hire), [`offer_acceptance_rate`](#offer_acceptance_rate)

<a id="referral_sessions"></a>
### Referral Sessions — `referral_sessions`

Web sessions originating from referring websites (non-paid, non-organic).

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/referral_sessions.yml) · [sql](dbt/analyses/metrics/finance/referral_sessions.sql)
- **Numerator:** COUNT(sessions WHERE medium = 'referral')
- **Dimensions:** referrer_domain, landing_page, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`website_sessions`](#website_sessions)
- **Children:** [`stg_session_row`](#stg_session_row)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`backlink_count`](#backlink_count)

<a id="remote_work_rate"></a>
### Remote Work % — `remote_work_rate`

Percentage of employees on fully remote or hybrid schedules

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/remote_work_rate.yml) · [sql](dbt/analyses/metrics/finance/remote_work_rate.sql)
- **Numerator:** Remote and hybrid employees
- **Denominator:** Total headcount
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`engagement_score`](#engagement_score)
- **Correlated:** [`absenteeism_rate`](#absenteeism_rate), [`engagement_score`](#engagement_score)

<a id="sales_cycle_by_segment"></a>
### Sales Cycle (Segment) — `sales_cycle_by_segment`

Average deal cycle by customer segment (SMB, Mid-Market, Enterprise)

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/sales_cycle_by_segment.yml) · [sql](dbt/analyses/metrics/finance/sales_cycle_by_segment.sql)
- **Numerator:** Average sales cycle by customer segment
- **Dimensions:** date, segment
- **Data sources:** crm
- **Parents:** [`avg_sales_cycle`](#avg_sales_cycle)
- **Correlated:** [`avg_sales_cycle`](#avg_sales_cycle), [`win_rate`](#win_rate)

<a id="sam"></a>
### SAM — `sam`

The portion of TAM that the company can realistically serve

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/sam.yml) · [sql](dbt/analyses/metrics/finance/sam.sql)
- **Numerator:** Serviceable addressable market estimate
- **Dimensions:** date
- **Data sources:** market_sizing
- **Parents:** [`market_penetration_rate`](#market_penetration_rate)
- **Correlated:** [`tam`](#tam), [`market_share`](#market_share)

<a id="separations"></a>
### Separations — `separations`

Number of employees who left (voluntarily or involuntarily) in the period

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/separations.yml) · [sql](dbt/analyses/metrics/finance/separations.sql)
- **Numerator:** Employees who left in period
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`turnover_rate`](#turnover_rate), [`regrettable_attrition`](#regrettable_attrition), [`voluntary_turnover`](#voluntary_turnover)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`regrettable_attrition`](#regrettable_attrition)

<a id="shareholder_equity"></a>
### Shareholder Equity — `shareholder_equity`

Total assets minus total liabilities

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/shareholder_equity.yml) · [sql](dbt/analyses/metrics/finance/shareholder_equity.sql)
- **Numerator:** Total assets − total liabilities
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`roe`](#roe), [`debt_to_equity`](#debt_to_equity)
- **Children:** [`total_assets`](#total_assets), [`total_liabilities`](#total_liabilities)
- **Correlated:** [`roe`](#roe), [`net_debt`](#net_debt), [`total_assets`](#total_assets)

<a id="sm_spend"></a>
### S&M Spend — `sm_spend`

Total sales and marketing expenditure in the period

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/sm_spend.yml) · [sql](dbt/analyses/metrics/finance/sm_spend.sql)
- **Numerator:** Sales & marketing total spend
- **Dimensions:** date
- **Data sources:** general_ledger
- **Parents:** [`magic_number`](#magic_number), [`cac_payback`](#cac_payback)
- **Correlated:** [`cac`](#cac), [`marketing_cac`](#marketing_cac)

<a id="stg_attendance_row"></a>
### Raw Attendance Row — `stg_attendance_row`

Single student daily attendance record — present, absent, or tardy.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_attendance_row.yml) · [sql](dbt/analyses/metrics/finance/stg_attendance_row.sql)
- **Numerator:** 1 per record
- **Dimensions:** student_id, school_id, date, status
- **Data sources:** SIS, Attendance system
- **Parents:** [`attendance_rate`](#attendance_rate), [`chronic_absenteeism`](#chronic_absenteeism), [`absenteeism_by_subgroup`](#absenteeism_by_subgroup), [`average_daily_attendance`](#average_daily_attendance)

<a id="stg_cogs_event"></a>
### Raw COGS Event — `stg_cogs_event`

Individual cost-of-goods-sold line item from ERP.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_cogs_event.yml) · [sql](dbt/analyses/metrics/finance/stg_cogs_event.sql)
- **Numerator:** cogs_amount
- **Dimensions:** company_id, cost_center, product_id, period
- **Data sources:** ERP
- **Parents:** [`cogs`](#cogs)

<a id="stg_customer_count"></a>
### Customers — `stg_customer_count`

Raw count of customer records in staging

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_customer_count.yml) · [sql](dbt/analyses/metrics/finance/stg_customer_count.sql)
- **Numerator:** Customer records
- **Dimensions:** date, segment
- **Data sources:** crm
- **Parents:** [`customer_churn_rate`](#customer_churn_rate), [`customer_count`](#customer_count), [`repeat_purchase_rate`](#repeat_purchase_rate)
- **Correlated:** [`customer_churn_rate`](#customer_churn_rate), [`net_new_customers`](#net_new_customers)

<a id="stg_discipline_row"></a>
### Raw Discipline Row — `stg_discipline_row`

Single student discipline incident record with type and consequence.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_discipline_row.yml) · [sql](dbt/analyses/metrics/finance/stg_discipline_row.sql)
- **Numerator:** 1 per incident
- **Dimensions:** student_id, school_id, incident_type, consequence, date
- **Data sources:** SIS, Discipline system
- **Parents:** [`suspension_rate`](#suspension_rate)

<a id="stg_downtime_event_row"></a>
### Raw Downtime Event Row — `stg_downtime_event_row`

Single equipment or system downtime event record with cause and duration.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_downtime_event_row.yml) · [sql](dbt/analyses/metrics/finance/stg_downtime_event_row.sql)
- **Numerator:** 1 per event
- **Dimensions:** event_id, system_id, facility_id, cause, start_time, duration_hours
- **Data sources:** SCADA, CMMS
- **Parents:** [`system_uptime`](#system_uptime), [`mtbf`](#mtbf), [`product_uptime_sla`](#product_uptime_sla)

<a id="stg_employee_row"></a>
### Raw Employee Row — `stg_employee_row`

Single employee record from HRIS with start date, department, and status.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_employee_row.yml) · [sql](dbt/analyses/metrics/finance/stg_employee_row.sql)
- **Numerator:** 1 per active employee
- **Dimensions:** employee_id, department, location, hire_date, status
- **Data sources:** HRIS (Workday / BambooHR)
- **Parents:** [`headcount_fte`](#headcount_fte), [`employee_attrition_rate`](#employee_attrition_rate), [`teacher_retention_rate`](#teacher_retention_rate), [`training_hours_per_employee`](#training_hours_per_employee)

<a id="stg_employees_count"></a>
### Employees — `stg_employees_count`

Raw employee row count in staging HR table

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_employees_count.yml) · [sql](dbt/analyses/metrics/finance/stg_employees_count.sql)
- **Numerator:** Active employee records
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`headcount`](#headcount)
- **Correlated:** [`headcount`](#headcount), [`turnover_rate`](#turnover_rate)

<a id="stg_enrollment_row"></a>
### Raw Enrollment Row — `stg_enrollment_row`

Single student enrollment record with grade, school, and status.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_enrollment_row.yml) · [sql](dbt/analyses/metrics/finance/stg_enrollment_row.sql)
- **Numerator:** 1 per enrollment
- **Dimensions:** student_id, school_id, grade_level, enrollment_date, status
- **Data sources:** SIS
- **Parents:** [`enrollment_count`](#enrollment_count), [`advanced_course_enrollment_rate`](#advanced_course_enrollment_rate), [`seat_fill_rate`](#seat_fill_rate)

<a id="stg_events_count"></a>
### Events — `stg_events_count`

Raw event row count in the staging events table

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_events_count.yml) · [sql](dbt/analyses/metrics/finance/stg_events_count.sql)
- **Numerator:** Event records
- **Dimensions:** date, event_type
- **Data sources:** events
- **Parents:** [`feature_adoption`](#feature_adoption)
- **Correlated:** [`dau`](#dau), [`feature_adoption`](#feature_adoption)

<a id="stg_invoice_row"></a>
### Raw Invoice Row — `stg_invoice_row`

Single accounts receivable invoice record with due date and amount.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_invoice_row.yml) · [sql](dbt/analyses/metrics/finance/stg_invoice_row.sql)
- **Numerator:** invoice_amount
- **Dimensions:** invoice_id, customer_id, due_date, status
- **Data sources:** ERP, Billing system
- **Parents:** [`dso`](#dso), [`ar_aging_90d`](#ar_aging_90d), [`billings`](#billings), [`deferred_revenue`](#deferred_revenue)

<a id="stg_job_requisition_row"></a>
### Raw Job Requisition Row — `stg_job_requisition_row`

Single job requisition record from ATS with open and close dates.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_job_requisition_row.yml) · [sql](dbt/analyses/metrics/finance/stg_job_requisition_row.sql)
- **Numerator:** 1 per requisition
- **Dimensions:** req_id, department, job_level, open_date, status
- **Data sources:** ATS (Greenhouse / Lever)
- **Parents:** [`time_to_fill`](#time_to_fill), [`internal_promotion_rate`](#internal_promotion_rate)

<a id="stg_opex_line"></a>
### Raw OpEx Line — `stg_opex_line`

Individual operating expense line item by GL account.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_opex_line.yml) · [sql](dbt/analyses/metrics/finance/stg_opex_line.sql)
- **Numerator:** opex_amount
- **Dimensions:** company_id, gl_account, department, period
- **Data sources:** ERP, General Ledger
- **Parents:** [`opex`](#opex)

<a id="stg_opportunities_count"></a>
### Opportunities — `stg_opportunities_count`

Raw opportunity count from CRM staging table

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_opportunities_count.yml) · [sql](dbt/analyses/metrics/finance/stg_opportunities_count.sql)
- **Numerator:** Opportunity records
- **Dimensions:** date, stage
- **Data sources:** crm
- **Parents:** [`avg_deal_size`](#avg_deal_size)
- **Correlated:** [`sql`](#sql), [`pipeline_generated`](#pipeline_generated)

<a id="stg_opportunity_row"></a>
### Raw Opportunity Row — `stg_opportunity_row`

Single CRM opportunity record with stage, amount, and dates.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_opportunity_row.yml) · [sql](dbt/analyses/metrics/finance/stg_opportunity_row.sql)
- **Numerator:** arr_value
- **Dimensions:** opportunity_id, account_id, rep_id, stage, close_date
- **Data sources:** CRM (Salesforce / HubSpot)
- **Parents:** [`win_rate`](#win_rate), [`sales_cycle_length`](#sales_cycle_length), [`pipeline_value`](#pipeline_value), [`acv`](#acv), [`bookings`](#bookings), [`marketing_influenced_pipeline`](#marketing_influenced_pipeline), [`quota_attainment`](#quota_attainment)

<a id="stg_order_amount_sum"></a>
### Order Amount — `stg_order_amount_sum`

Sum of order amounts in staging before deduplication

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_order_amount_sum.yml) · [sql](dbt/analyses/metrics/finance/stg_order_amount_sum.sql)
- **Numerator:** Sum of order amounts
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`aov`](#aov), [`gross_revenue`](#gross_revenue)
- **Correlated:** [`gross_revenue`](#gross_revenue), [`aov`](#aov)

<a id="stg_orders_count"></a>
### Orders — `stg_orders_count`

Raw count of order records in the staging orders table

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_orders_count.yml) · [sql](dbt/analyses/metrics/finance/stg_orders_count.sql)
- **Numerator:** Order records
- **Dimensions:** date, channel
- **Data sources:** orders
- **Parents:** [`cycle_time`](#cycle_time), [`order_fulfillment_rate`](#order_fulfillment_rate), [`otd_rate`](#otd_rate), [`throughput`](#throughput)
- **Correlated:** [`total_revenue`](#total_revenue), [`aov`](#aov)

<a id="stg_page_view_row"></a>
### Raw Page View Row — `stg_page_view_row`

Single web page view event with URL, user, and referrer.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_page_view_row.yml) · [sql](dbt/analyses/metrics/finance/stg_page_view_row.sql)
- **Numerator:** 1 per page view
- **Dimensions:** page_id, user_id, referrer, device, date
- **Data sources:** Google Analytics / GA4, Segment
- **Parents:** [`website_sessions`](#website_sessions)

<a id="stg_page_views"></a>
### Page Views — `stg_page_views`

Total page view events in web analytics staging

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_page_views.yml) · [sql](dbt/analyses/metrics/finance/stg_page_views.sql)
- **Numerator:** Page view events
- **Dimensions:** date, page
- **Data sources:** analytics
- **Parents:** [`website_sessions`](#website_sessions)
- **Correlated:** [`website_sessions`](#website_sessions), [`bounce_rate`](#bounce_rate)

<a id="stg_products_active"></a>
### Active Products — `stg_products_active`

Count of active product records in staging catalog

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_products_active.yml) · [sql](dbt/analyses/metrics/finance/stg_products_active.sql)
- **Numerator:** Active product records
- **Dimensions:** date, category
- **Data sources:** catalog
- **Parents:** [`cross_sell_rate`](#cross_sell_rate)
- **Correlated:** [`cross_sell_rate`](#cross_sell_rate), [`aov`](#aov)

<a id="stg_quality_inspection_row"></a>
### Raw Quality Inspection Row — `stg_quality_inspection_row`

Single quality inspection record with pass/fail and defect category.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_quality_inspection_row.yml) · [sql](dbt/analyses/metrics/finance/stg_quality_inspection_row.sql)
- **Numerator:** 1 per inspection
- **Dimensions:** inspection_id, product_id, production_line, date, result
- **Data sources:** Quality management system
- **Parents:** [`defect_rate`](#defect_rate)

<a id="stg_return_row"></a>
### Raw Return Row — `stg_return_row`

Single product return transaction record with reason code and condition.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_return_row.yml) · [sql](dbt/analyses/metrics/finance/stg_return_row.sql)
- **Numerator:** 1 per return
- **Dimensions:** return_id, order_id, product_id, reason_code, return_date
- **Data sources:** ERP, WMS, Returns management system
- **Parents:** [`return_rate`](#return_rate)

<a id="stg_session_row"></a>
### Raw Session Row — `stg_session_row`

Single web session record from analytics platform.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_session_row.yml) · [sql](dbt/analyses/metrics/finance/stg_session_row.sql)
- **Numerator:** 1 per session
- **Dimensions:** session_id, user_id, source, medium, landing_page, date
- **Data sources:** Google Analytics / GA4, Segment
- **Parents:** [`organic_sessions`](#organic_sessions), [`website_sessions`](#website_sessions), [`bounce_rate`](#bounce_rate), [`paid_sessions`](#paid_sessions), [`referral_sessions`](#referral_sessions)

<a id="stg_sessions_count"></a>
### Sessions — `stg_sessions_count`

Raw session row count in staging

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_sessions_count.yml) · [sql](dbt/analyses/metrics/finance/stg_sessions_count.sql)
- **Numerator:** Session records
- **Dimensions:** date, platform
- **Data sources:** sessions
- **Parents:** [`sessions_per_user`](#sessions_per_user)
- **Correlated:** [`dau`](#dau), [`session_length`](#session_length)

<a id="stg_shipment_row"></a>
### Raw Shipment Row — `stg_shipment_row`

Single shipment record with carrier, dates, and status.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_shipment_row.yml) · [sql](dbt/analyses/metrics/finance/stg_shipment_row.sql)
- **Numerator:** 1 per shipment
- **Dimensions:** shipment_id, order_id, carrier, ship_date, committed_date, status
- **Data sources:** WMS, TMS
- **Parents:** [`on_time_delivery_rate`](#on_time_delivery_rate), [`order_accuracy_rate`](#order_accuracy_rate)

<a id="stg_subscription_row"></a>
### Raw Subscription Row — `stg_subscription_row`

Single active subscription record with plan and amount.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_subscription_row.yml) · [sql](dbt/analyses/metrics/finance/stg_subscription_row.sql)
- **Numerator:** monthly_amount
- **Dimensions:** customer_id, plan_tier, start_date, status
- **Data sources:** Billing system
- **Parents:** [`mrr`](#mrr), [`arr`](#arr), [`cohort_revenue_retention`](#cohort_revenue_retention), [`customer_concentration_risk`](#customer_concentration_risk), [`logo_churn_rate`](#logo_churn_rate), [`renewal_rate`](#renewal_rate)

<a id="stg_subscriptions_active"></a>
### Active Subscriptions — `stg_subscriptions_active`

Count of active subscription records before business logic

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_subscriptions_active.yml) · [sql](dbt/analyses/metrics/finance/stg_subscriptions_active.sql)
- **Numerator:** Active subscription records
- **Dimensions:** date, plan
- **Data sources:** subscriptions
- **Parents:** [`active_paying_users`](#active_paying_users), [`new_arr`](#new_arr)
- **Correlated:** [`arr`](#arr), [`mrr`](#mrr), [`logo_churn_rate`](#logo_churn_rate)

<a id="stg_survey_response_row"></a>
### Raw Survey Response — `stg_survey_response_row`

Individual employee survey response record.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_survey_response_row.yml) · [sql](dbt/analyses/metrics/finance/stg_survey_response_row.sql)
- **Numerator:** composite_score
- **Dimensions:** employee_id, survey_id, question_id, response_date
- **Data sources:** Survey platform (Lattice / Culture Amp)
- **Parents:** [`employee_engagement_score`](#employee_engagement_score), [`manager_effectiveness_score`](#manager_effectiveness_score), [`school_culture_score`](#school_culture_score)

<a id="stg_user_event_row"></a>
### Raw User Event Row — `stg_user_event_row`

Single user action event from product analytics instrumentation.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_user_event_row.yml) · [sql](dbt/analyses/metrics/finance/stg_user_event_row.sql)
- **Numerator:** 1 per event
- **Dimensions:** event_id, user_id, event_name, session_id, timestamp, platform
- **Data sources:** Segment, Amplitude, Mixpanel
- **Parents:** [`dau`](#dau), [`mau`](#mau), [`activation_rate`](#activation_rate), [`avg_session_duration`](#avg_session_duration), [`feature_adoption_rate`](#feature_adoption_rate), [`new_user_signups`](#new_user_signups), [`onboarding_completion_rate`](#onboarding_completion_rate), [`retention_d30`](#retention_d30), [`time_to_value`](#time_to_value)

<a id="stg_vehicle_trip_row"></a>
### Raw Vehicle Trip Row — `stg_vehicle_trip_row`

Single vehicle trip record with distance, duration, and driver.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_vehicle_trip_row.yml) · [sql](dbt/analyses/metrics/finance/stg_vehicle_trip_row.sql)
- **Numerator:** 1 per trip
- **Dimensions:** trip_id, vehicle_id, driver_id, start_time, end_time, distance_miles
- **Data sources:** Fleet management system (GPS, telematics)
- **Parents:** [`fleet_utilization_rate`](#fleet_utilization_rate), [`cost_per_mile`](#cost_per_mile)

<a id="stg_work_order_row"></a>
### Raw Work Order Row — `stg_work_order_row`

Single maintenance or facilities work order record.

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/stg_work_order_row.yml) · [sql](dbt/analyses/metrics/finance/stg_work_order_row.sql)
- **Numerator:** 1 per work order
- **Dimensions:** work_order_id, facility_id, category, priority, created_date
- **Data sources:** CMMS (Computerized Maintenance Management System)
- **Parents:** [`work_order_resolution_time`](#work_order_resolution_time), [`preventive_maintenance_rate`](#preventive_maintenance_rate)

<a id="survey_response_rate"></a>
### Survey Response % — `survey_response_rate`

Percentage of customers who responded to surveys sent

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/survey_response_rate.yml) · [sql](dbt/analyses/metrics/finance/survey_response_rate.sql)
- **Numerator:** Responses received
- **Denominator:** Surveys sent
- **Dimensions:** date
- **Data sources:** surveys
- **Parents:** [`nps`](#nps)
- **Correlated:** [`nps`](#nps), [`csat`](#csat), [`engagement_score`](#engagement_score)

<a id="tam"></a>
### TAM — `tam`

Estimated total market opportunity for the product or service

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/tam.yml) · [sql](dbt/analyses/metrics/finance/tam.sql)
- **Numerator:** Total addressable market estimate
- **Dimensions:** date
- **Data sources:** market_sizing
- **Parents:** [`market_penetration_rate`](#market_penetration_rate)
- **Correlated:** [`sam`](#sam), [`market_share`](#market_share)

<a id="testimonials_count"></a>
### Testimonials — `testimonials_count`

Number of customer testimonials or case studies collected YTD

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/testimonials_count.yml) · [sql](dbt/analyses/metrics/finance/testimonials_count.sql)
- **Numerator:** Testimonials published
- **Dimensions:** date
- **Data sources:** crm, review_platforms
- **Parents:** [`nps`](#nps)
- **Correlated:** [`review_rating`](#review_rating), [`nps`](#nps)

<a id="total_assets"></a>
### Total Assets — `total_assets`

Total value of assets on the balance sheet

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/total_assets.yml) · [sql](dbt/analyses/metrics/finance/total_assets.sql)
- **Numerator:** Sum of all asset values
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`roa`](#roa), [`current_ratio`](#current_ratio), [`roic`](#roic), [`shareholder_equity`](#shareholder_equity)
- **Correlated:** [`total_liabilities`](#total_liabilities), [`shareholder_equity`](#shareholder_equity)

<a id="total_debt"></a>
### Total Debt — `total_debt`

Sum of short-term and long-term debt obligations

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/total_debt.yml) · [sql](dbt/analyses/metrics/finance/total_debt.sql)
- **Numerator:** Short-term + long-term debt
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`debt_to_equity`](#debt_to_equity), [`net_debt`](#net_debt), [`interest_coverage`](#interest_coverage), [`roic`](#roic)
- **Correlated:** [`leverage_ratio`](#leverage_ratio), [`interest_coverage`](#interest_coverage)

<a id="total_liabilities"></a>
### Total Liabilities — `total_liabilities`

Total value of liabilities on the balance sheet

- **Vertical:** Finance & FP&A · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/total_liabilities.yml) · [sql](dbt/analyses/metrics/finance/total_liabilities.sql)
- **Numerator:** Sum of all liability values
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`shareholder_equity`](#shareholder_equity)
- **Correlated:** [`total_assets`](#total_assets), [`debt_to_equity`](#debt_to_equity)

<a id="trial_signups"></a>
### Trial Signups — `trial_signups`

New free trial registrations in the period

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/trial_signups.yml) · [sql](dbt/analyses/metrics/finance/trial_signups.sql)
- **Numerator:** Trial account signups
- **Dimensions:** date, channel
- **Data sources:** users
- **Parents:** [`plg_rate`](#plg_rate), [`trial_to_paid_rate`](#trial_to_paid_rate), [`free_to_paid_rate`](#free_to_paid_rate)
- **Correlated:** [`activation_rate`](#activation_rate), [`free_to_paid_rate`](#free_to_paid_rate), [`user_signups`](#user_signups)

<a id="user_signups"></a>
### New Signups — `user_signups`

New user registrations in the period

- **Vertical:** Finance & FP&A · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/user_signups.yml) · [sql](dbt/analyses/metrics/finance/user_signups.sql)
- **Numerator:** New user registrations
- **Dimensions:** date, channel
- **Data sources:** users
- **Parents:** [`d30_retention`](#d30_retention), [`d7_retention`](#d7_retention), [`viral_coefficient`](#viral_coefficient)
- **Correlated:** [`activation_rate`](#activation_rate), [`trial_signups`](#trial_signups)

<a id="competitive_win_rate"></a>
### Competitive Win % — `competitive_win_rate`

Win rate in deals that involved a named competitor

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/competitive_win_rate.yml) · [sql](dbt/analyses/metrics/hr/competitive_win_rate.sql)
- **Numerator:** Wins in competitive deals
- **Denominator:** Total competitive opportunities
- **Dimensions:** date, competitor
- **Data sources:** crm
- **Parents:** [`win_rate`](#win_rate)
- **Correlated:** [`win_rate`](#win_rate), [`avg_deal_size`](#avg_deal_size)

<a id="complaints_count"></a>
### Complaints — `complaints_count`

Total formal complaints received in the period

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/complaints_count.yml) · [sql](dbt/analyses/metrics/hr/complaints_count.sql)
- **Numerator:** Formal complaints received
- **Dimensions:** date
- **Data sources:** crm
- **Parents:** [`cx_csat`](#cx_csat)
- **Correlated:** [`complaint_resolution_rate`](#complaint_resolution_rate), [`csat`](#csat)

<a id="headcount_by_dept"></a>
### Headcount (Dept) — `headcount_by_dept`

Employee count broken down by department

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/headcount_by_dept.yml) · [sql](dbt/analyses/metrics/hr/headcount_by_dept.sql)
- **Numerator:** Active employees by department
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`headcount`](#headcount)
- **Correlated:** [`headcount`](#headcount), [`rd_headcount_pct`](#rd_headcount_pct)

<a id="headcount_fte"></a>
### Headcount FTE — `headcount_fte`

Full-time equivalent employee count at end of period.

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/headcount_fte.yml) · [sql](dbt/analyses/metrics/hr/headcount_fte.sql)
- **Numerator:** COUNT(active_employees) weighted by employment fraction
- **Dimensions:** company_id, department, location, period
- **Data sources:** HRIS
- **Parents:** [`revenue_per_employee`](#revenue_per_employee), [`teacher_student_ratio`](#teacher_student_ratio)
- **Children:** [`stg_employee_row`](#stg_employee_row)
- **Correlated:** [`headcount_cost`](#headcount_cost), [`opex`](#opex), [`employee_attrition_rate`](#employee_attrition_rate), [`time_to_fill`](#time_to_fill)

<a id="new_hires"></a>
### New Hires — `new_hires`

Number of employees who started in the period

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/new_hires.yml) · [sql](dbt/analyses/metrics/hr/new_hires.sql)
- **Numerator:** Employees started in period
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`headcount`](#headcount), [`cost_per_hire`](#cost_per_hire), [`offer_acceptance_rate`](#offer_acceptance_rate)
- **Correlated:** [`cost_per_hire`](#cost_per_hire), [`time_to_fill`](#time_to_fill)

<a id="rd_headcount"></a>
### R&D Headcount — `rd_headcount`

Number of employees in engineering, product, and research roles

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/rd_headcount.yml) · [sql](dbt/analyses/metrics/hr/rd_headcount.sql)
- **Numerator:** R&D/engineering/product employees
- **Dimensions:** date
- **Data sources:** hris
- **Parents:** [`rd_headcount_pct`](#rd_headcount_pct)
- **Correlated:** [`rd_headcount_pct`](#rd_headcount_pct), [`deployment_frequency`](#deployment_frequency)

<a id="sales_headcount"></a>
### Sales Headcount — `sales_headcount`

Number of quota-carrying sales representatives

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/sales_headcount.yml) · [sql](dbt/analyses/metrics/hr/sales_headcount.sql)
- **Numerator:** Quota-carrying sales reps
- **Dimensions:** date
- **Data sources:** hris
- **Parents:** [`arr_per_rep`](#arr_per_rep)
- **Correlated:** [`arr_per_rep`](#arr_per_rep), [`quota_attainment`](#quota_attainment)

<a id="stg_payroll_row"></a>
### Raw Payroll Row — `stg_payroll_row`

Single payroll record per employee per pay period.

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/stg_payroll_row.yml) · [sql](dbt/analyses/metrics/hr/stg_payroll_row.sql)
- **Numerator:** gross_pay
- **Dimensions:** employee_id, pay_period, pay_type, department
- **Data sources:** Payroll system (ADP / Gusto)
- **Parents:** [`headcount_cost`](#headcount_cost), [`compensation_ratio`](#compensation_ratio), [`sales_spend`](#sales_spend)

<a id="stg_payroll_total"></a>
### Payroll Total — `stg_payroll_total`

Total payroll disbursements in staging payroll table

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/stg_payroll_total.yml) · [sql](dbt/analyses/metrics/hr/stg_payroll_total.sql)
- **Numerator:** Sum of payroll amounts
- **Dimensions:** date, department
- **Data sources:** payroll
- **Parents:** [`total_comp_expense`](#total_comp_expense)
- **Correlated:** [`total_comp_expense`](#total_comp_expense), [`headcount`](#headcount)

<a id="total_comp_expense"></a>
### Total Comp Expense — `total_comp_expense`

Total salaries, benefits, and equity costs for the period

- **Vertical:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/total_comp_expense.yml) · [sql](dbt/analyses/metrics/hr/total_comp_expense.sql)
- **Numerator:** Total compensation and benefits cost
- **Dimensions:** date, department
- **Data sources:** payroll
- **Parents:** [`opex`](#opex), [`hr_cost_pct_revenue`](#hr_cost_pct_revenue), [`cost_per_hire`](#cost_per_hire), [`gender_pay_gap`](#gender_pay_gap), [`support_cost_per_ticket`](#support_cost_per_ticket)
- **Children:** [`stg_payroll_total`](#stg_payroll_total)
- **Correlated:** [`headcount`](#headcount), [`cost_per_hire`](#cost_per_hire), [`benefits_utilization`](#benefits_utilization), [`stg_payroll_total`](#stg_payroll_total)

<a id="ad_clicks"></a>
### Ad Clicks — `ad_clicks`

Total clicks on paid ads in the period.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/ad_clicks.yml) · [sql](dbt/analyses/metrics/marketing/ad_clicks.sql)
- **Numerator:** SUM(clicks)
- **Dimensions:** channel, campaign, ad_set, date
- **Data sources:** Google Ads, Meta Ads
- **Parents:** [`ctr`](#ctr), [`cpc`](#cpc)
- **Children:** [`stg_ad_spend_row`](#stg_ad_spend_row)
- **Correlated:** [`impressions`](#impressions), [`web_conversion_rate`](#web_conversion_rate)

<a id="ad_impressions"></a>
### Ad Impressions — `ad_impressions`

Total number of times paid ads were displayed

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/ad_impressions.yml) · [sql](dbt/analyses/metrics/marketing/ad_impressions.sql)
- **Numerator:** Ad impressions served
- **Dimensions:** date, channel, ad
- **Data sources:** ad_platforms
- **Parents:** [`ad_ctr`](#ad_ctr), [`cpc`](#cpc)
- **Correlated:** [`ad_ctr`](#ad_ctr), [`cpc`](#cpc)

<a id="content_published"></a>
### Content Published — `content_published`

Total pieces of content published in the period (blogs, videos, etc.)

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/content_published.yml) · [sql](dbt/analyses/metrics/marketing/content_published.sql)
- **Numerator:** Content pieces published
- **Dimensions:** date, type
- **Data sources:** cms
- **Parents:** [`organic_traffic`](#organic_traffic)
- **Correlated:** [`domain_authority`](#domain_authority), [`organic_traffic`](#organic_traffic)

<a id="content_published_count"></a>
### Content Published — `content_published_count`

Count of content assets published in the period (blogs, whitepapers, videos).

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/content_published_count.yml) · [sql](dbt/analyses/metrics/marketing/content_published_count.sql)
- **Numerator:** COUNT(published content assets)
- **Dimensions:** content_type, topic, channel, period
- **Data sources:** CMS (Contentful / WordPress)
- **Parents:** [`organic_sessions`](#organic_sessions)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`mql_count`](#mql_count), [`top10_keyword_count`](#top10_keyword_count)

<a id="email_unsub_rate"></a>
### Unsub Rate — `email_unsub_rate`

Percentage of recipients who unsubscribed

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/email_unsub_rate.yml) · [sql](dbt/analyses/metrics/marketing/email_unsub_rate.sql)
- **Numerator:** Unsubscribes
- **Denominator:** Emails delivered
- **Dimensions:** date, campaign
- **Data sources:** email_platform
- **Parents:** [`unsubscribe_rate`](#unsubscribe_rate)
- **Correlated:** [`email_open_rate`](#email_open_rate), [`email_ctr`](#email_ctr)

<a id="organic_traffic"></a>
### Organic Traffic — `organic_traffic`

Website sessions sourced from organic search

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/organic_traffic.yml) · [sql](dbt/analyses/metrics/marketing/organic_traffic.sql)
- **Parents:** [`website_sessions`](#website_sessions), [`organic_attribution_pct`](#organic_attribution_pct)
- **Children:** [`content_published`](#content_published)
- **Correlated:** [`backlinks_count`](#backlinks_count), [`content_published`](#content_published), [`domain_authority`](#domain_authority), [`keywords_top10`](#keywords_top10)

<a id="paid_traffic"></a>
### Paid Traffic — `paid_traffic`

Website sessions sourced from paid channels

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/paid_traffic.yml) · [sql](dbt/analyses/metrics/marketing/paid_traffic.sql)
- **Parents:** [`website_sessions`](#website_sessions)

<a id="social_followers"></a>
### Social Followers — `social_followers`

Total followers across social platforms at end of period.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/social_followers.yml) · [sql](dbt/analyses/metrics/marketing/social_followers.sql)
- **Numerator:** SUM(followers)
- **Dimensions:** platform, account, period
- **Data sources:** Social media APIs (LinkedIn, X, Instagram)
- **Parents:** [`share_of_voice`](#share_of_voice), [`social_engagement_rate`](#social_engagement_rate)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`impressions`](#impressions)

<a id="stg_ad_spend"></a>
### Ad Spend — `stg_ad_spend`

Raw ad spend total from all connected ad platforms in staging

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/stg_ad_spend.yml) · [sql](dbt/analyses/metrics/marketing/stg_ad_spend.sql)
- **Numerator:** Total ad spend
- **Dimensions:** date, channel, campaign
- **Data sources:** ad_platforms
- **Parents:** [`cost_per_mql`](#cost_per_mql), [`cpc`](#cpc), [`cpl`](#cpl), [`marketing_cac`](#marketing_cac), [`marketing_roi`](#marketing_roi), [`paid_attribution_pct`](#paid_attribution_pct)
- **Correlated:** [`roas`](#roas), [`cpc`](#cpc), [`marketing_cac`](#marketing_cac)

<a id="stg_ad_spend_row"></a>
### Raw Ad Spend Row — `stg_ad_spend_row`

Daily ad spend record by campaign from ad platform.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/stg_ad_spend_row.yml) · [sql](dbt/analyses/metrics/marketing/stg_ad_spend_row.sql)
- **Numerator:** spend
- **Dimensions:** campaign_id, channel, date, ad_set_id
- **Data sources:** Google Ads, Meta Ads, LinkedIn Ads
- **Parents:** [`marketing_spend`](#marketing_spend), [`ad_clicks`](#ad_clicks), [`impressions`](#impressions)

<a id="stg_email_send_row"></a>
### Raw Email Send Row — `stg_email_send_row`

Single email send event with delivery, open, and click status.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/stg_email_send_row.yml) · [sql](dbt/analyses/metrics/marketing/stg_email_send_row.sql)
- **Numerator:** 1 per send
- **Dimensions:** send_id, contact_id, campaign_id, send_date, status
- **Data sources:** Email platform (HubSpot / Klaviyo)
- **Parents:** [`email_open_rate`](#email_open_rate), [`email_click_rate`](#email_click_rate), [`unsubscribe_rate`](#unsubscribe_rate)

<a id="stg_lead_row"></a>
### Raw Lead Row — `stg_lead_row`

Single lead record from CRM or marketing automation with source and score.

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/stg_lead_row.yml) · [sql](dbt/analyses/metrics/marketing/stg_lead_row.sql)
- **Numerator:** 1 per lead
- **Dimensions:** lead_id, source, channel, created_date, score
- **Data sources:** CRM, Marketing automation
- **Parents:** [`mql_count`](#mql_count), [`customers_by_channel`](#customers_by_channel)

<a id="stg_leads_count"></a>
### Leads — `stg_leads_count`

Raw lead count from CRM staging table

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/stg_leads_count.yml) · [sql](dbt/analyses/metrics/marketing/stg_leads_count.sql)
- **Numerator:** Lead records created
- **Dimensions:** date, channel
- **Data sources:** crm
- **Parents:** [`cpl`](#cpl), [`form_conversion_rate`](#form_conversion_rate), [`lead_to_mql_rate`](#lead_to_mql_rate), [`mql`](#mql), [`session_to_lead_rate`](#session_to_lead_rate)
- **Correlated:** [`mql`](#mql), [`cpl`](#cpl)

<a id="webinar_registrants"></a>
### Webinar Registrants — `webinar_registrants`

Total registrations across all webinars in the period

- **Vertical:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/webinar_registrants.yml) · [sql](dbt/analyses/metrics/marketing/webinar_registrants.sql)
- **Numerator:** Webinar registrations
- **Dimensions:** date, webinar
- **Data sources:** webinar_platform
- **Parents:** [`webinar_attendance_rate`](#webinar_attendance_rate)
- **Correlated:** [`webinar_attendance_rate`](#webinar_attendance_rate), [`mql`](#mql)

<a id="incident_count"></a>
### Incident Count — `incident_count`

Total production or safety incidents in the period

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/incident_count.yml) · [sql](dbt/analyses/metrics/ops/incident_count.sql)
- **Numerator:** Production/safety incidents in period
- **Dimensions:** date
- **Data sources:** incident_management
- **Parents:** [`mttd`](#mttd), [`mttr`](#mttr), [`uptime`](#uptime)
- **Correlated:** [`mttr`](#mttr), [`mttd`](#mttd), [`rcr_rate`](#rcr_rate)

<a id="inventory_value"></a>
### Inventory Value — `inventory_value`

Total cost basis of inventory on hand

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/inventory_value.yml) · [sql](dbt/analyses/metrics/ops/inventory_value.sql)
- **Numerator:** Units on hand × unit cost
- **Dimensions:** date, product
- **Data sources:** inventory
- **Parents:** [`inventory_turnover`](#inventory_turnover)
- **Correlated:** [`inventory_turnover`](#inventory_turnover), [`cogs_stg`](#cogs_stg), [`shrinkage_rate`](#shrinkage_rate), [`warehouse_utilization`](#warehouse_utilization)

<a id="stg_csat_response_row"></a>
### Raw CSAT Response — `stg_csat_response_row`

Individual CSAT survey response record.

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/stg_csat_response_row.yml) · [sql](dbt/analyses/metrics/ops/stg_csat_response_row.sql)
- **Numerator:** satisfaction_score
- **Dimensions:** response_id, customer_id, interaction_id, date
- **Data sources:** Survey platform, CRM
- **Parents:** [`csat`](#csat), [`cx_csat`](#cx_csat)

<a id="stg_inventory_items"></a>
### Inventory Items — `stg_inventory_items`

Total SKU count in inventory staging table

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/stg_inventory_items.yml) · [sql](dbt/analyses/metrics/ops/stg_inventory_items.sql)
- **Numerator:** Inventory item records
- **Dimensions:** date, product, location
- **Data sources:** inventory
- **Parents:** [`inventory_turnover`](#inventory_turnover), [`stockout_rate`](#stockout_rate)
- **Correlated:** [`inventory_turnover`](#inventory_turnover), [`stockout_rate`](#stockout_rate)

<a id="stg_order_line_row"></a>
### Raw Order Line Row — `stg_order_line_row`

Single order line item with product, quantity, and fulfillment status.

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/stg_order_line_row.yml) · [sql](dbt/analyses/metrics/ops/stg_order_line_row.sql)
- **Numerator:** 1 per line
- **Dimensions:** order_id, line_id, product_id, qty_ordered, qty_shipped, warehouse_id
- **Data sources:** ERP, WMS
- **Parents:** [`fill_rate`](#fill_rate)

<a id="stg_purchase_order_row"></a>
### Raw PO Row — `stg_purchase_order_row`

Single purchase order record with supplier, items, and receipt date.

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/stg_purchase_order_row.yml) · [sql](dbt/analyses/metrics/ops/stg_purchase_order_row.sql)
- **Numerator:** po_amount
- **Dimensions:** po_id, supplier_id, product_id, po_date, receipt_date, status
- **Data sources:** ERP, Purchasing system
- **Parents:** [`supplier_lead_time`](#supplier_lead_time), [`procurement_savings_rate`](#procurement_savings_rate), [`vendor_compliance_rate`](#vendor_compliance_rate)

<a id="stg_safety_incident_row"></a>
### Raw Safety Incident Row — `stg_safety_incident_row`

Single workplace safety incident record with type, severity, and department.

- **Vertical:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/ops/stg_safety_incident_row.yml) · [sql](dbt/analyses/metrics/ops/stg_safety_incident_row.sql)
- **Numerator:** 1 per incident
- **Dimensions:** incident_id, employee_id, facility_id, incident_type, severity, date
- **Data sources:** Safety management system
- **Parents:** [`safety_incident_rate`](#safety_incident_rate)

<a id="stg_support_tickets"></a>
### Support Tickets — `stg_support_tickets`

Raw ticket count from helpdesk staging table

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/stg_support_tickets.yml) · [sql](dbt/analyses/metrics/ops/stg_support_tickets.sql)
- **Numerator:** Support ticket records
- **Dimensions:** date, priority
- **Data sources:** helpdesk
- **Parents:** [`escalation_rate`](#escalation_rate), [`fcr_rate`](#fcr_rate), [`ticket_resolution_time`](#ticket_resolution_time), [`tickets_per_agent`](#tickets_per_agent)
- **Correlated:** [`ticket_resolution_time`](#ticket_resolution_time), [`first_response_time`](#first_response_time), [`fcr_rate`](#fcr_rate)

<a id="stg_ticket_row"></a>
### Raw Ticket Row — `stg_ticket_row`

Single support ticket record with category, priority, and resolution data.

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/stg_ticket_row.yml) · [sql](dbt/analyses/metrics/ops/stg_ticket_row.sql)
- **Numerator:** 1 per ticket
- **Dimensions:** ticket_id, customer_id, category, priority, channel, created_date
- **Data sources:** Zendesk, Intercom, Freshdesk
- **Parents:** [`support_tickets_opened`](#support_tickets_opened), [`first_response_time`](#first_response_time), [`time_to_resolution`](#time_to_resolution)

<a id="support_tickets_opened"></a>
### Tickets Opened — `support_tickets_opened`

Count of new support tickets opened in the period.

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/support_tickets_opened.yml) · [sql](dbt/analyses/metrics/ops/support_tickets_opened.sql)
- **Numerator:** COUNT(tickets WHERE status = 'opened')
- **Dimensions:** category, priority, channel, product, period
- **Data sources:** Support platform (Zendesk / Intercom)
- **Parents:** [`ticket_resolution_rate`](#ticket_resolution_rate)
- **Children:** [`stg_ticket_row`](#stg_ticket_row)
- **Correlated:** [`csat`](#csat), [`churn_rate`](#churn_rate)

<a id="tickets_created"></a>
### Tickets Created — `tickets_created`

Total new support tickets opened in the period

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/tickets_created.yml) · [sql](dbt/analyses/metrics/ops/tickets_created.sql)
- **Numerator:** Support tickets opened
- **Dimensions:** date, priority
- **Data sources:** helpdesk
- **Parents:** [`tickets_per_customer`](#tickets_per_customer)
- **Correlated:** [`ticket_resolution_time`](#ticket_resolution_time), [`sla_breach_rate`](#sla_breach_rate)

<a id="tickets_resolved"></a>
### Tickets Resolved — `tickets_resolved`

Total support tickets closed in the period

- **Vertical:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/ops/tickets_resolved.yml) · [sql](dbt/analyses/metrics/ops/tickets_resolved.sql)
- **Numerator:** Support tickets closed
- **Dimensions:** date
- **Data sources:** helpdesk
- **Parents:** [`support_cost_per_ticket`](#support_cost_per_ticket)
- **Correlated:** [`fcr_rate`](#fcr_rate), [`support_cost_per_ticket`](#support_cost_per_ticket)

<a id="churned_arr"></a>
### Churned ARR — `churned_arr`

ARR lost from customers who cancelled in the period

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/churned_arr.yml) · [sql](dbt/analyses/metrics/pe/churned_arr.sql)
- **Numerator:** ARR from cancelled contracts
- **Dimensions:** date, customer_segment
- **Data sources:** subscriptions
- **Parents:** [`arr`](#arr), [`grr`](#grr), [`mrr_churn_rate`](#mrr_churn_rate), [`nrr`](#nrr), [`nrr_monthly`](#nrr_monthly), [`saas_quick_ratio`](#saas_quick_ratio)
- **Correlated:** [`contraction_arr`](#contraction_arr), [`customer_churn_rate`](#customer_churn_rate), [`logo_churn_rate`](#logo_churn_rate)

<a id="cohort_churn"></a>
### Cohort Churn — `cohort_churn`

Cumulative churn for a given acquisition cohort at N months

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/cohort_churn.yml) · [sql](dbt/analyses/metrics/pe/cohort_churn.sql)
- **Numerator:** Churned users in cohort
- **Denominator:** Cohort starting size
- **Dimensions:** date, cohort
- **Data sources:** subscriptions, users
- **Parents:** [`churn_rate`](#churn_rate)
- **Correlated:** [`logo_churn_rate`](#logo_churn_rate), [`d30_retention`](#d30_retention)

<a id="committed_arr"></a>
### Committed ARR — `committed_arr`

ARR under signed contracts not yet recognized

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/committed_arr.yml) · [sql](dbt/analyses/metrics/pe/committed_arr.sql)
- **Numerator:** ARR under signed contracts not yet active
- **Dimensions:** date
- **Data sources:** contracts, subscriptions
- **Parents:** [`arr`](#arr)
- **Correlated:** [`arr`](#arr), [`bookings`](#bookings), [`contracted_unbilled`](#contracted_unbilled)

<a id="contraction_arr"></a>
### Contraction ARR — `contraction_arr`

ARR lost from downgrades by existing customers

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/contraction_arr.yml) · [sql](dbt/analyses/metrics/pe/contraction_arr.sql)
- **Numerator:** ARR lost to downgrades
- **Dimensions:** date, customer_segment
- **Data sources:** subscriptions
- **Parents:** [`arr`](#arr), [`nrr`](#nrr), [`grr`](#grr), [`nrr_monthly`](#nrr_monthly), [`saas_quick_ratio`](#saas_quick_ratio)
- **Correlated:** [`churned_arr`](#churned_arr), [`logo_churn_rate`](#logo_churn_rate)

<a id="gross_revenue"></a>
### Gross Revenue — `gross_revenue`

Total revenue before any discounts or returns

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/gross_revenue.yml) · [sql](dbt/analyses/metrics/pe/gross_revenue.sql)
- **Numerator:** Sum of gross order amounts
- **Dimensions:** date, channel
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue), [`net_revenue`](#net_revenue)
- **Children:** [`stg_order_amount_sum`](#stg_order_amount_sum)
- **Correlated:** [`net_revenue`](#net_revenue), [`discount_rate`](#discount_rate), [`stg_order_amount_sum`](#stg_order_amount_sum)

<a id="implementation_revenue"></a>
### Implementation Revenue — `implementation_revenue`

One-time revenue from customer onboarding and implementation

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/implementation_revenue.yml) · [sql](dbt/analyses/metrics/pe/implementation_revenue.sql)
- **Numerator:** Onboarding/implementation fees
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Correlated:** [`services_revenue`](#services_revenue)

<a id="prior_year_revenue"></a>
### PY Revenue — `prior_year_revenue`

Full-year revenue from the prior fiscal year

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/prior_year_revenue.yml) · [sql](dbt/analyses/metrics/pe/prior_year_revenue.sql)
- **Numerator:** Full prior year revenue
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_vs_py`](#revenue_vs_py)
- **Correlated:** [`revenue_vs_py`](#revenue_vs_py), [`total_revenue`](#total_revenue)

<a id="q1_revenue"></a>
### Q1 Revenue — `q1_revenue`

Revenue recognized in Q1

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/q1_revenue.yml) · [sql](dbt/analyses/metrics/pe/q1_revenue.sql)
- **Numerator:** Revenue recognized in Q1
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_ytd`](#revenue_ytd)
- **Correlated:** [`q2_revenue`](#q2_revenue), [`total_revenue`](#total_revenue)

<a id="q2_revenue"></a>
### Q2 Revenue — `q2_revenue`

Revenue recognized in Q2

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/q2_revenue.yml) · [sql](dbt/analyses/metrics/pe/q2_revenue.sql)
- **Numerator:** Revenue recognized in Q2
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_ytd`](#revenue_ytd)
- **Correlated:** [`q1_revenue`](#q1_revenue), [`q3_revenue`](#q3_revenue)

<a id="q3_revenue"></a>
### Q3 Revenue — `q3_revenue`

Revenue recognized in Q3

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/q3_revenue.yml) · [sql](dbt/analyses/metrics/pe/q3_revenue.sql)
- **Numerator:** Revenue recognized in Q3
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_ytd`](#revenue_ytd)
- **Correlated:** [`q2_revenue`](#q2_revenue), [`q4_revenue`](#q4_revenue)

<a id="q4_revenue"></a>
### Q4 Revenue — `q4_revenue`

Revenue recognized in Q4

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/q4_revenue.yml) · [sql](dbt/analyses/metrics/pe/q4_revenue.sql)
- **Numerator:** Revenue recognized in Q4
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_ytd`](#revenue_ytd)
- **Correlated:** [`q3_revenue`](#q3_revenue), [`total_revenue`](#total_revenue)

<a id="recognized_revenue"></a>
### Recognized Revenue — `recognized_revenue`

Revenue recognized under ASC 606 in the period

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/recognized_revenue.yml) · [sql](dbt/analyses/metrics/pe/recognized_revenue.sql)
- **Numerator:** Revenue earned and recognized in period
- **Dimensions:** date
- **Data sources:** subscriptions, invoices
- **Parents:** [`billings`](#billings)
- **Correlated:** [`deferred_revenue`](#deferred_revenue), [`arr`](#arr), [`stg_invoices_amount`](#stg_invoices_amount)

<a id="revenue_by_channel"></a>
### Revenue by Channel — `revenue_by_channel`

Revenue attributed to each sales channel (direct, partner, self-serve)

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/revenue_by_channel.yml) · [sql](dbt/analyses/metrics/pe/revenue_by_channel.sql)
- **Numerator:** Revenue by sales channel
- **Dimensions:** date, channel
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Correlated:** [`total_revenue`](#total_revenue), [`cac`](#cac), [`partner_revenue_pct`](#partner_revenue_pct)

<a id="revenue_by_product"></a>
### Revenue by Product — `revenue_by_product`

Revenue broken out by product or service line

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/revenue_by_product.yml) · [sql](dbt/analyses/metrics/pe/revenue_by_product.sql)
- **Numerator:** Revenue by product line
- **Dimensions:** date, product_line
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Correlated:** [`total_revenue`](#total_revenue), [`gross_margin_pct`](#gross_margin_pct)

<a id="revenue_by_region"></a>
### Revenue by Region — `revenue_by_region`

Revenue broken out by geographic region

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/revenue_by_region.yml) · [sql](dbt/analyses/metrics/pe/revenue_by_region.sql)
- **Numerator:** Revenue by geographic region
- **Dimensions:** date, region
- **Data sources:** orders
- **Parents:** [`total_revenue`](#total_revenue)
- **Correlated:** [`total_revenue`](#total_revenue), [`market_share`](#market_share)

<a id="stg_revenue_event_amount"></a>
### Raw Revenue Event — `stg_revenue_event_amount`

Individual recognized revenue transaction row from billing system.

- **Vertical:** Private Equity / SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/pe/stg_revenue_event_amount.yml) · [sql](dbt/analyses/metrics/pe/stg_revenue_event_amount.sql)
- **Numerator:** amount
- **Dimensions:** company_id, order_id, customer_id, product_id, recognized_date
- **Data sources:** Billing system, ERP
- **Parents:** [`revenue`](#revenue), [`asp`](#asp), [`gmv`](#gmv)

<a id="api_calls_total"></a>
### API Calls (Total) — `api_calls_total`

Total API calls made by all integrations and users in the period

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/api_calls_total.yml) · [sql](dbt/analyses/metrics/product/api_calls_total.sql)
- **Numerator:** Total API calls
- **Dimensions:** date, endpoint
- **Data sources:** api_gateway
- **Parents:** [`api_latency_p95`](#api_latency_p95)
- **Correlated:** [`api_consumers`](#api_consumers), [`api_latency_p95`](#api_latency_p95)

<a id="api_consumers"></a>
### API Consumers — `api_consumers`

Distinct applications or users making API calls in the period

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/api_consumers.yml) · [sql](dbt/analyses/metrics/product/api_consumers.sql)
- **Numerator:** Unique API consumers
- **Dimensions:** date
- **Data sources:** api_gateway
- **Parents:** [`mau`](#mau)
- **Correlated:** [`api_calls_total`](#api_calls_total), [`dau`](#dau)

<a id="sprint_velocity"></a>
### Sprint Velocity — `sprint_velocity`

Average story points completed per two-week sprint

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/sprint_velocity.yml) · [sql](dbt/analyses/metrics/product/sprint_velocity.sql)
- **Numerator:** Story points completed per sprint
- **Dimensions:** date, team
- **Data sources:** project_management
- **Parents:** [`deployment_frequency`](#deployment_frequency)
- **Correlated:** [`deployment_frequency`](#deployment_frequency), [`tech_debt_ratio`](#tech_debt_ratio), [`pr_merge_time`](#pr_merge_time)

<a id="stg_error_event_row"></a>
### Raw Error Event Row — `stg_error_event_row`

Single application error event from monitoring system.

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/stg_error_event_row.yml) · [sql](dbt/analyses/metrics/product/stg_error_event_row.sql)
- **Numerator:** 1 per error
- **Dimensions:** error_id, user_id, endpoint, error_type, timestamp
- **Data sources:** Sentry, Datadog, Rollbar
- **Parents:** [`error_rate`](#error_rate), [`mttd`](#mttd)

<a id="stg_nps_response_row"></a>
### Raw NPS Response — `stg_nps_response_row`

Individual NPS survey response with score and verbatim.

- **Vertical:** Product & Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/stg_nps_response_row.yml) · [sql](dbt/analyses/metrics/product/stg_nps_response_row.sql)
- **Numerator:** score (0–10)
- **Dimensions:** respondent_id, customer_id, survey_date, score
- **Data sources:** Survey platform (Delighted / Qualtrics)
- **Parents:** [`nps`](#nps)
