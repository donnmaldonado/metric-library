# Metric Catalog

375 metrics.

## North Star (22)

### North Star · Commerce (4)

<a id="clv"></a>
#### Customer LTV — `clv`

Total expected revenue from a customer over their lifetime

- **Domain:** Commerce · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/commerce/clv.yml) · [sql](dbt/analyses/metrics/commerce/clv.sql)
- **Numerator:** Avg purchase value × frequency × lifespan
- **Dimensions:** date, customer_segment, cohort
- **Data sources:** orders, customers
- **Children:** [`aov`](#aov), [`purchase_frequency`](#purchase_frequency), [`customer_churn_rate`](#customer_churn_rate), [`cohort_ltv_12m`](#cohort_ltv_12m), [`cohort_ltv_24m`](#cohort_ltv_24m), [`cross_sell_rate`](#cross_sell_rate), [`customer_retention_rate`](#customer_retention_rate), [`refund_rate`](#refund_rate)
- **Correlated:** [`cac`](#cac), [`nrr`](#nrr), [`cohort_ltv_12m`](#cohort_ltv_12m), [`aov`](#aov)

<a id="customer_ltv"></a>
#### Realized Customer LTV — `customer_ltv`

Realized average revenue per customer to date (lifetime order revenue / customers who have ordered).

- **Domain:** Commerce · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/commerce/customer_ltv.yml) · [sql](dbt/analyses/metrics/commerce/customer_ltv.sql)
- **Numerator:** SUM(lifetime revenue per customer)
- **Dimensions:** customer_id, segment, cohort_month, acquisition_channel
- **Data sources:** Transactional DB, CRM, Data warehouse
- **Children:** [`arpu`](#arpu), [`churn_rate`](#churn_rate)
- **Correlated:** [`ltv_cac`](#ltv_cac), [`nrr`](#nrr), [`arpu`](#arpu)

<a id="on_time_delivery_rate"></a>
#### On-Time Delivery Rate — `on_time_delivery_rate`

Percentage of orders or deliverables completed by the committed date

- **Domain:** Commerce · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/commerce/on_time_delivery_rate.yml) · [sql](dbt/analyses/metrics/commerce/on_time_delivery_rate.sql)
- **Numerator:** On-time deliveries
- **Denominator:** Total deliveries
- **Dimensions:** date, region, carrier, product_category, period
- **Data sources:** orders, logistics
- **Children:** [`cycle_time`](#cycle_time), [`lead_time`](#lead_time)
- **Correlated:** [`order_fulfillment_rate`](#order_fulfillment_rate), [`cycle_time`](#cycle_time), [`inventory_turnover`](#inventory_turnover), [`lead_time`](#lead_time), [`fill_rate`](#fill_rate), [`order_accuracy_rate`](#order_accuracy_rate), [`sla_compliance_rate`](#sla_compliance_rate), [`ops_north_star`](#ops_north_star)

<a id="ops_north_star"></a>
#### Perfect Order Rate — `ops_north_star`

% of orders that are on time, complete, accurate, and undamaged — the gold standard ops metric.

- **Domain:** Commerce · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/commerce/ops_north_star.yml) · [sql](dbt/analyses/metrics/commerce/ops_north_star.sql)
- **Numerator:** Orders meeting all criteria
- **Denominator:** Total Orders
- **Dimensions:** warehouse_id, carrier, period
- **Data sources:** WMS, TMS, ERP
- **Children:** [`fill_rate`](#fill_rate), [`order_accuracy_rate`](#order_accuracy_rate), [`capacity_utilization`](#capacity_utilization), [`defect_rate`](#defect_rate), [`order_fulfillment_rate`](#order_fulfillment_rate), [`return_rate`](#return_rate), [`sla_compliance_rate`](#sla_compliance_rate), [`uptime`](#uptime), [`vendor_scorecard_rating`](#vendor_scorecard_rating)
- **Correlated:** [`csat`](#csat), [`on_time_delivery_rate`](#on_time_delivery_rate)

### North Star · Education (4)

<a id="college_enrollment_rate"></a>
#### College Enrollment % — `college_enrollment_rate`

Percentage of graduates enrolled in a 2- or 4-year college within 16 months

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/college_enrollment_rate.yml) · [sql](dbt/analyses/metrics/education/college_enrollment_rate.sql)
- **Numerator:** Graduates enrolling in college
- **Denominator:** Graduates
- **Dimensions:** school_year, school
- **Data sources:** transcripts, nscc
- **Children:** [`fafsa_completion_rate`](#fafsa_completion_rate), [`ap_participation_rate`](#ap_participation_rate), [`ap_pass_rate`](#ap_pass_rate), [`college_enrollment`](#college_enrollment)
- **Correlated:** [`four_year_grad_rate`](#four_year_grad_rate), [`ap_pass_rate`](#ap_pass_rate), [`ap_participation_rate`](#ap_participation_rate)

<a id="cost_per_outcome"></a>
#### Cost per Outcome — `cost_per_outcome`

Per-pupil expenditure divided by % of students meeting proficiency — efficiency of investment.

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/cost_per_outcome.yml) · [sql](dbt/analyses/metrics/education/cost_per_outcome.sql)
- **Numerator:** Per-Pupil Expenditure
- **Denominator:** Proficiency Rate
- **Dimensions:** school_id, period
- **Data sources:** Finance, SIS, Assessment platform
- **Children:** [`per_pupil_expenditure`](#per_pupil_expenditure)
- **Formula inputs:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`per_pupil_expenditure`](#per_pupil_expenditure), [`student_proficiency`](#student_proficiency)

<a id="four_year_grad_rate"></a>
#### 4-Year Grad Rate — `four_year_grad_rate`

Percentage of students graduating within 4 years of entering 9th grade

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/four_year_grad_rate.yml) · [sql](dbt/analyses/metrics/education/four_year_grad_rate.sql)
- **Numerator:** On-time graduates
- **Denominator:** Entering 9th grade cohort
- **Dimensions:** school_year, school, subgroup, school_id, cohort_year
- **Data sources:** enrollment, transcripts
- **Children:** [`student_attendance_rate`](#student_attendance_rate), [`dropout_rate`](#dropout_rate), [`advanced_course_enrollment_rate`](#advanced_course_enrollment_rate), [`credit_accumulation_rate`](#credit_accumulation_rate)
- **Correlated:** [`college_enrollment_rate`](#college_enrollment_rate), [`dropout_rate`](#dropout_rate), [`student_proficiency`](#student_proficiency), [`student_attendance_rate`](#student_attendance_rate), [`college_enrollment`](#college_enrollment), [`credit_accumulation_rate`](#credit_accumulation_rate), [`enrollment_count`](#enrollment_count), [`fafsa_completion_rate`](#fafsa_completion_rate)

<a id="student_proficiency"></a>
#### Student Proficiency Rate — `student_proficiency`

% of tested students scoring at or above proficiency on state assessments.

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/student_proficiency.yml) · [sql](dbt/analyses/metrics/education/student_proficiency.sql)
- **Numerator:** Students scoring ≥ Level 3
- **Denominator:** Total students tested
- **Dimensions:** school_id, subject, grade_level, subgroup, academic_year, school_year, grade
- **Data sources:** State assessment platform, SIS (PowerSchool / Infinite Campus)
- **Children:** [`student_attendance_rate`](#student_attendance_rate), [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`instructional_minutes`](#instructional_minutes), [`avg_teacher_experience`](#avg_teacher_experience), [`ell_pct`](#ell_pct), [`ell_proficiency_growth`](#ell_proficiency_growth), [`frl_pct`](#frl_pct), [`iep_goal_mastery_rate`](#iep_goal_mastery_rate), [`iep_pct`](#iep_pct), [`on_time_lesson_delivery`](#on_time_lesson_delivery), [`per_pupil_expenditure`](#per_pupil_expenditure), [`school_climate_score`](#school_climate_score), [`student_growth_percentile`](#student_growth_percentile), [`teacher_retention_rate`](#teacher_retention_rate), [`ela_proficiency_rate`](#ela_proficiency_rate), [`math_proficiency_rate`](#math_proficiency_rate), [`science_proficiency_rate`](#science_proficiency_rate)
- **Correlated:** [`four_year_grad_rate`](#four_year_grad_rate), [`college_enrollment`](#college_enrollment), [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`advanced_course_enrollment_rate`](#advanced_course_enrollment_rate), [`student_attendance_rate`](#student_attendance_rate), [`cost_per_outcome`](#cost_per_outcome), [`ell_proficiency_growth`](#ell_proficiency_growth), [`iep_goal_mastery_rate`](#iep_goal_mastery_rate), [`student_growth_percentile`](#student_growth_percentile), [`teacher_retention_rate`](#teacher_retention_rate), [`student_teacher_ratio`](#student_teacher_ratio), [`ap_pass_rate`](#ap_pass_rate)

### North Star · Finance (7)

<a id="ebitda"></a>
#### EBITDA — `ebitda`

Earnings before interest, taxes, depreciation & amortization.

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/ebitda.yml) · [sql](dbt/analyses/metrics/finance/ebitda.sql)
- **Numerator:** EBIT + Depreciation + Amortization
- **Dimensions:** date, segment
- **Data sources:** income_statement
- **Children:** [`gross_profit`](#gross_profit), [`opex`](#opex), [`da`](#da), [`bad_debt_rate`](#bad_debt_rate), [`cogs`](#cogs), [`ebit`](#ebit), [`ebitda_bridge_price`](#ebitda_bridge_price), [`ebitda_bridge_volume`](#ebitda_bridge_volume), [`ebitda_margin`](#ebitda_margin), [`forecast_accuracy`](#forecast_accuracy), [`gross_margin_pct`](#gross_margin_pct), [`revenue_per_employee`](#revenue_per_employee)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`free_cash_flow`](#free_cash_flow), [`net_income`](#net_income), [`capex`](#capex), [`effective_tax_rate`](#effective_tax_rate), [`enterprise_value`](#enterprise_value), [`nrr`](#nrr), [`operating_cash_flow`](#operating_cash_flow), [`roe`](#roe), [`revenue`](#revenue)

<a id="enterprise_value"></a>
#### Enterprise Value — `enterprise_value`

Market cap plus net debt — basis for EV/EBITDA multiples

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/enterprise_value.yml) · [sql](dbt/analyses/metrics/finance/enterprise_value.sql)
- **Numerator:** Market cap + net debt
- **Dimensions:** date
- **Data sources:** cap_table, balance_sheet
- **Children:** [`net_debt`](#net_debt), [`customer_concentration_risk`](#customer_concentration_risk), [`ev_ebitda`](#ev_ebitda), [`roic`](#roic)
- **Correlated:** [`ev_ebitda`](#ev_ebitda), [`rule_of_40`](#rule_of_40), [`ebitda`](#ebitda)

<a id="free_cash_flow"></a>
#### Free Cash Flow — `free_cash_flow`

Operating cash flow minus capital expenditures.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/free_cash_flow.yml) · [sql](dbt/analyses/metrics/finance/free_cash_flow.sql)
- **Numerator:** Operating Cash Flow − CapEx
- **Dimensions:** date
- **Data sources:** cash_flow_statement
- **Children:** [`operating_cash_flow`](#operating_cash_flow), [`capex`](#capex), [`capex_pct_revenue`](#capex_pct_revenue), [`runway_months`](#runway_months), [`working_capital`](#working_capital)
- **Correlated:** [`burn_rate`](#burn_rate), [`ebitda`](#ebitda), [`net_income`](#net_income), [`billings`](#billings), [`capex_pct_revenue`](#capex_pct_revenue), [`da`](#da), [`debt_ebitda`](#debt_ebitda), [`effective_tax_rate`](#effective_tax_rate), [`interest_coverage_ratio`](#interest_coverage_ratio), [`operating_cash_flow`](#operating_cash_flow), [`runway_months`](#runway_months), [`working_capital`](#working_capital)

<a id="ops_efficiency_ratio"></a>
#### Ops Efficiency — `ops_efficiency_ratio`

Output produced per unit of cost — higher is better

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/ops_efficiency_ratio.yml) · [sql](dbt/analyses/metrics/finance/ops_efficiency_ratio.sql)
- **Numerator:** OpEx
- **Denominator:** Revenue
- **Dimensions:** date
- **Data sources:** finance
- **Children:** [`opex`](#opex), [`budget_variance_pct`](#budget_variance_pct), [`carbon_emissions_per_unit`](#carbon_emissions_per_unit), [`cost_per_mile`](#cost_per_mile), [`support_cost_per_ticket`](#support_cost_per_ticket), [`warehouse_utilization`](#warehouse_utilization)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`gross_margin_pct`](#gross_margin_pct), [`throughput`](#throughput)

<a id="revenue"></a>
#### Revenue — `revenue`

Total recognized revenue in the period.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/revenue.yml) · [sql](dbt/analyses/metrics/finance/revenue.sql)
- **Numerator:** SUM(recognized_amount)
- **Dimensions:** company_id, product_line, geography, channel, date, region
- **Data sources:** ERP, CRM, Billing system
- **Children:** [`arr`](#arr), [`mrr`](#mrr), [`arpu`](#arpu), [`asp`](#asp), [`billings`](#billings), [`customer_count`](#customer_count), [`gmv`](#gmv), [`iap_revenue`](#iap_revenue), [`take_rate`](#take_rate), [`net_revenue`](#net_revenue), [`gross_revenue`](#gross_revenue), [`services_revenue`](#services_revenue), [`license_revenue`](#license_revenue), [`subscription_revenue`](#subscription_revenue), [`implementation_revenue`](#implementation_revenue), [`partner_revenue`](#partner_revenue), [`partner_revenue_pct`](#partner_revenue_pct), [`rev_from_existing`](#rev_from_existing), [`rev_from_new_customers`](#rev_from_new_customers), [`revenue_ytd`](#revenue_ytd)
- **Correlated:** [`customer_count`](#customer_count), [`arpu`](#arpu), [`asp`](#asp), [`billings`](#billings), [`bookings`](#bookings), [`cogs`](#cogs), [`deferred_revenue`](#deferred_revenue), [`gmv`](#gmv), [`marketing_spend`](#marketing_spend), [`take_rate`](#take_rate), [`revenue_growth_rate`](#revenue_growth_rate), [`revenue_vs_py`](#revenue_vs_py), [`arr`](#arr), [`ebitda`](#ebitda), [`prior_year_revenue`](#prior_year_revenue), [`q1_revenue`](#q1_revenue), [`q4_revenue`](#q4_revenue), [`cac`](#cac), [`partner_revenue_pct`](#partner_revenue_pct), [`gross_margin_pct`](#gross_margin_pct), [`market_share`](#market_share)

<a id="roe"></a>
#### ROE — `roe`

Net income as a percentage of shareholders equity

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/roe.yml) · [sql](dbt/analyses/metrics/finance/roe.sql)
- **Numerator:** Net Income
- **Denominator:** Shareholders' Equity
- **Dimensions:** date, company_id, fiscal_period
- **Data sources:** income_statement, balance_sheet
- **Children:** [`net_income`](#net_income), [`shareholder_equity`](#shareholder_equity), [`debt_to_equity`](#debt_to_equity), [`interest_coverage_ratio`](#interest_coverage_ratio), [`leverage_ratio`](#leverage_ratio), [`net_income_margin`](#net_income_margin), [`roa`](#roa)
- **Correlated:** [`roa`](#roa), [`roic`](#roic), [`shareholder_equity`](#shareholder_equity), [`debt_ebitda`](#debt_ebitda), [`ebitda`](#ebitda)

<a id="rule_of_40"></a>
#### Rule of 40 — `rule_of_40`

Revenue growth rate + EBITDA margin — benchmark for SaaS health. ≥40 = healthy.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/rule_of_40.yml) · [sql](dbt/analyses/metrics/finance/rule_of_40.sql)
- **Numerator:** Revenue Growth % + EBITDA Margin %
- **Dimensions:** company_id, fiscal_period
- **Data sources:** ERP, Billing system
- **Children:** [`ebitda_margin`](#ebitda_margin), [`revenue_growth_rate`](#revenue_growth_rate), [`arr_growth_rate`](#arr_growth_rate), [`magic_number`](#magic_number), [`nrr`](#nrr)
- **Correlated:** [`arr`](#arr), [`nrr`](#nrr), [`enterprise_value`](#enterprise_value), [`saas_quick_ratio`](#saas_quick_ratio)

### North Star · People & HR (3)

<a id="employee_lifetime_value"></a>
#### Employee Lifetime Value — `employee_lifetime_value`

Estimated total value an employee contributes over their tenure minus fully-loaded employment cost.

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/employee_lifetime_value.yml) · [sql](dbt/analyses/metrics/hr/employee_lifetime_value.sql)
- **Numerator:** Revenue Contribution over Tenure
- **Denominator:** Fully-Loaded Employment Cost over Tenure
- **Dimensions:** job_level, department, hire_cohort
- **Data sources:** HRIS, Finance
- **Children:** [`headcount_cost`](#headcount_cost), [`revenue_per_employee`](#revenue_per_employee), [`avg_tenure`](#avg_tenure), [`gross_profit_per_employee`](#gross_profit_per_employee), [`workforce_productivity`](#workforce_productivity)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`employee_engagement_score`](#employee_engagement_score)

<a id="headcount"></a>
#### Headcount — `headcount`

Total active full-time employees at end of period

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/headcount.yml) · [sql](dbt/analyses/metrics/hr/headcount.sql)
- **Numerator:** Active employees at period end
- **Dimensions:** date, department, location
- **Data sources:** hris
- **Children:** [`diversity_hire_rate`](#diversity_hire_rate), [`headcount_vs_budget`](#headcount_vs_budget), [`new_hires`](#new_hires)
- **Correlated:** [`turnover_rate`](#turnover_rate), [`headcount_vs_budget`](#headcount_vs_budget), [`total_comp_expense`](#total_comp_expense), [`rd_headcount_pct`](#rd_headcount_pct)

<a id="turnover_rate"></a>
#### Turnover Rate — `turnover_rate`

Percentage of employees who left during the period (voluntary + involuntary)

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/turnover_rate.yml) · [sql](dbt/analyses/metrics/hr/turnover_rate.sql)
- **Numerator:** Separations
- **Denominator:** Average headcount
- **Dimensions:** date, department
- **Data sources:** hris
- **Children:** [`separations`](#separations), [`voluntary_turnover`](#voluntary_turnover), [`regrettable_attrition`](#regrettable_attrition)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`regrettable_attrition`](#regrettable_attrition), [`employee_engagement_score`](#employee_engagement_score), [`absenteeism_rate`](#absenteeism_rate), [`headcount`](#headcount)

### North Star · Marketing (1)

<a id="marketing_roi"></a>
#### Marketing ROI — `marketing_roi`

Return on total marketing investment — revenue driven per dollar spent.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/marketing_roi.yml) · [sql](dbt/analyses/metrics/marketing/marketing_roi.sql)
- **Numerator:** Pipeline generated
- **Denominator:** Marketing spend
- **Dimensions:** date, campaign
- **Data sources:** ad_platforms, crm
- **Children:** [`ltv_cac`](#ltv_cac), [`marketing_influenced_pipeline`](#marketing_influenced_pipeline), [`organic_attribution_pct`](#organic_attribution_pct), [`paid_attribution_pct`](#paid_attribution_pct), [`referral_attribution_pct`](#referral_attribution_pct), [`roas`](#roas), [`share_of_voice`](#share_of_voice), [`marketing_spend`](#marketing_spend)
- **Formula inputs:** [`pipeline_generated`](#pipeline_generated)
- **Correlated:** [`roas`](#roas), [`marketing_cac`](#marketing_cac)

### North Star · Product (2)

<a id="cx_csat"></a>
#### CX CSAT — `cx_csat`

Satisfaction score from customer service interactions

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/cx_csat.yml) · [sql](dbt/analyses/metrics/product/cx_csat.sql)
- **Numerator:** Satisfied customers
- **Denominator:** Survey responses
- **Dimensions:** date, product, channel
- **Data sources:** surveys
- **Children:** [`complaint_resolution_rate`](#complaint_resolution_rate), [`complaints_count`](#complaints_count), [`csat`](#csat)
- **Correlated:** [`nps`](#nps), [`ces`](#ces), [`csat`](#csat)

<a id="nps"></a>
#### NPS — `nps`

Net Promoter Score — % Promoters minus % Detractors on 0–10 likelihood-to-recommend scale.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/nps.yml) · [sql](dbt/analyses/metrics/product/nps.sql)
- **Numerator:** % Promoters (9-10) - % Detractors (0-6)
- **Dimensions:** segment, product, survey_period
- **Data sources:** NPS survey platform (Delighted / Qualtrics)
- **Children:** [`app_store_rating`](#app_store_rating), [`feature_request_volume`](#feature_request_volume), [`review_rating`](#review_rating), [`survey_response_rate`](#survey_response_rate), [`testimonials_count`](#testimonials_count)
- **Correlated:** [`account_health_score`](#account_health_score), [`churn_rate`](#churn_rate), [`app_store_rating`](#app_store_rating), [`ces`](#ces), [`csat`](#csat), [`cx_csat`](#cx_csat), [`enps`](#enps), [`feature_adoption_rate`](#feature_adoption_rate), [`feature_request_volume`](#feature_request_volume), [`review_rating`](#review_rating), [`survey_response_rate`](#survey_response_rate), [`testimonials_count`](#testimonials_count)

### North Star · Sales (1)

<a id="pipeline_generated"></a>
#### Pipeline Generated — `pipeline_generated`

Total value of opportunities sourced by marketing

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/pipeline_generated.yml) · [sql](dbt/analyses/metrics/sales/pipeline_generated.sql)
- **Numerator:** Sum of opportunity values created
- **Dimensions:** date, channel
- **Data sources:** crm
- **Children:** [`sql`](#sql), [`avg_deal_size`](#avg_deal_size), [`mql`](#mql)
- **Correlated:** [`bookings`](#bookings), [`mql`](#mql), [`pipeline_coverage`](#pipeline_coverage)

## KPI (266)

### KPI · Commerce (15)

<a id="aov"></a>
#### AOV — `aov`

Average value per transaction

- **Domain:** Commerce · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/commerce/aov.yml) · [sql](dbt/analyses/metrics/commerce/aov.sql)
- **Numerator:** Total order revenue
- **Denominator:** Number of orders
- **Dimensions:** date, customer_segment, channel
- **Data sources:** orders
- **Parents:** [`clv`](#clv), [`cohort_ltv_12m`](#cohort_ltv_12m)
- **Children:** [`gross_revenue`](#gross_revenue)
- **Correlated:** [`purchase_frequency`](#purchase_frequency), [`clv`](#clv), [`cross_sell_rate`](#cross_sell_rate), [`discount_rate`](#discount_rate), [`iap_revenue`](#iap_revenue), [`marketplace_buyers`](#marketplace_buyers), [`gross_revenue`](#gross_revenue)

<a id="cross_sell_rate"></a>
#### Cross-Sell Rate — `cross_sell_rate`

Percentage of customers who purchased products from more than one category

- **Domain:** Commerce · **Industry:** education
- **Files:** [yml](dbt/models/metrics/commerce/cross_sell_rate.yml) · [sql](dbt/analyses/metrics/commerce/cross_sell_rate.sql)
- **Numerator:** Customers buying across categories
- **Denominator:** Total customers
- **Dimensions:** date, product_category
- **Data sources:** orders
- **Parents:** [`clv`](#clv)
- **Correlated:** [`upsell_rate`](#upsell_rate), [`aov`](#aov)

<a id="fill_rate"></a>
#### Fill Rate — `fill_rate`

% of order lines fulfilled completely from available inventory.

- **Domain:** Commerce · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/commerce/fill_rate.yml) · [sql](dbt/analyses/metrics/commerce/fill_rate.sql)
- **Numerator:** Order Lines Fully Shipped
- **Denominator:** Total Order Lines
- **Dimensions:** warehouse_id, product_category, period
- **Data sources:** WMS, ERP
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Children:** [`order_lines`](#order_lines), [`stockout_rate`](#stockout_rate)
- **Correlated:** [`on_time_delivery_rate`](#on_time_delivery_rate), [`inventory_turnover`](#inventory_turnover), [`defect_rate`](#defect_rate), [`order_accuracy_rate`](#order_accuracy_rate), [`supplier_lead_time`](#supplier_lead_time), [`vendor_scorecard_rating`](#vendor_scorecard_rating), [`warehouse_utilization`](#warehouse_utilization)

<a id="gmv"></a>
#### GMV — `gmv`

Total value of merchandise sold through a marketplace before returns and fees.

- **Domain:** Commerce · **Industry:** marketplace
- **Files:** [yml](dbt/models/metrics/commerce/gmv.yml) · [sql](dbt/analyses/metrics/commerce/gmv.sql)
- **Numerator:** SUM(transaction_value)
- **Dimensions:** category, channel, seller_id, period
- **Data sources:** Marketplace platform, ERP
- **Parents:** [`revenue`](#revenue), [`take_rate`](#take_rate)
- **Children:** [`liquidity_rate`](#liquidity_rate), [`marketplace_buyers`](#marketplace_buyers), [`marketplace_sellers`](#marketplace_sellers)
- **Correlated:** [`revenue`](#revenue), [`take_rate`](#take_rate)

<a id="lead_time"></a>
#### Lead Time — `lead_time`

Average time from request to delivery

- **Domain:** Commerce · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/commerce/lead_time.yml) · [sql](dbt/analyses/metrics/commerce/lead_time.sql)
- **Numerator:** Time from order to delivery
- **Dimensions:** date, product
- **Data sources:** production
- **Parents:** [`on_time_delivery_rate`](#on_time_delivery_rate)
- **Correlated:** [`cycle_time`](#cycle_time), [`on_time_delivery_rate`](#on_time_delivery_rate)

<a id="liquidity_rate"></a>
#### Marketplace Liquidity % — `liquidity_rate`

Percentage of listings that resulted in a transaction

- **Domain:** Commerce · **Industry:** marketplace
- **Files:** [yml](dbt/models/metrics/commerce/liquidity_rate.yml) · [sql](dbt/analyses/metrics/commerce/liquidity_rate.sql)
- **Numerator:** Transacting listings
- **Denominator:** Total active listings
- **Dimensions:** date, category
- **Data sources:** marketplace
- **Parents:** [`gmv`](#gmv)
- **Correlated:** [`take_rate`](#take_rate), [`marketplace_sellers`](#marketplace_sellers)

<a id="net_revenue"></a>
#### Net Revenue — `net_revenue`

Gross revenue minus returns, allowances, and discounts

- **Domain:** Commerce · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/commerce/net_revenue.yml) · [sql](dbt/analyses/metrics/commerce/net_revenue.sql)
- **Numerator:** Gross revenue − returns − discounts
- **Dimensions:** date, channel
- **Data sources:** orders
- **Parents:** [`revenue`](#revenue)
- **Children:** [`gross_revenue`](#gross_revenue), [`discount_rate`](#discount_rate)
- **Correlated:** [`gross_revenue`](#gross_revenue), [`refund_rate`](#refund_rate)

<a id="order_accuracy_rate"></a>
#### Order Accuracy Rate — `order_accuracy_rate`

% of orders shipped without errors (wrong item, quantity, or address).

- **Domain:** Commerce · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/commerce/order_accuracy_rate.yml) · [sql](dbt/analyses/metrics/commerce/order_accuracy_rate.sql)
- **Numerator:** Error-Free Orders
- **Denominator:** Total Orders Shipped
- **Dimensions:** warehouse_id, carrier, period
- **Data sources:** WMS, Customer service system
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Correlated:** [`fill_rate`](#fill_rate), [`on_time_delivery_rate`](#on_time_delivery_rate), [`defect_rate`](#defect_rate), [`return_rate`](#return_rate)

<a id="order_fulfillment_rate"></a>
#### Order Fulfillment % — `order_fulfillment_rate`

Percentage of orders fulfilled completely and on time

- **Domain:** Commerce · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/commerce/order_fulfillment_rate.yml) · [sql](dbt/analyses/metrics/commerce/order_fulfillment_rate.sql)
- **Numerator:** Fulfilled orders
- **Denominator:** Total orders
- **Dimensions:** date, region
- **Data sources:** orders, inventory
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Correlated:** [`on_time_delivery_rate`](#on_time_delivery_rate), [`stockout_rate`](#stockout_rate)

<a id="purchase_frequency"></a>
#### Purchase Frequency — `purchase_frequency`

Average number of orders per customer per year

- **Domain:** Commerce · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/commerce/purchase_frequency.yml) · [sql](dbt/analyses/metrics/commerce/purchase_frequency.sql)
- **Numerator:** Total orders
- **Denominator:** Unique customers
- **Dimensions:** date, customer_segment
- **Data sources:** orders
- **Parents:** [`clv`](#clv), [`cohort_ltv_12m`](#cohort_ltv_12m)
- **Children:** [`repeat_purchase_rate`](#repeat_purchase_rate)
- **Correlated:** [`aov`](#aov), [`repeat_purchase_rate`](#repeat_purchase_rate)

<a id="refund_rate"></a>
#### Refund Rate — `refund_rate`

Percentage of transactions that were refunded

- **Domain:** Commerce · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/commerce/refund_rate.yml) · [sql](dbt/analyses/metrics/commerce/refund_rate.sql)
- **Numerator:** Refunds processed
- **Denominator:** Total orders
- **Dimensions:** date, product
- **Data sources:** orders, returns
- **Parents:** [`clv`](#clv)
- **Correlated:** [`return_rate`](#return_rate), [`csat`](#csat), [`net_revenue`](#net_revenue)

<a id="repeat_purchase_rate"></a>
#### Repeat Purchase % — `repeat_purchase_rate`

Percentage of customers who made more than one purchase

- **Domain:** Commerce · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/commerce/repeat_purchase_rate.yml) · [sql](dbt/analyses/metrics/commerce/repeat_purchase_rate.sql)
- **Numerator:** Customers with 2+ orders
- **Denominator:** Total customers
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`purchase_frequency`](#purchase_frequency)
- **Correlated:** [`purchase_frequency`](#purchase_frequency), [`customer_retention_rate`](#customer_retention_rate)

<a id="return_rate"></a>
#### Return Rate — `return_rate`

% of units sold that are returned by customers.

- **Domain:** Commerce · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/commerce/return_rate.yml) · [sql](dbt/analyses/metrics/commerce/return_rate.sql)
- **Numerator:** Units Returned
- **Denominator:** Units Sold
- **Dimensions:** product_category, channel, period, date, product
- **Data sources:** ERP, WMS
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Correlated:** [`defect_rate`](#defect_rate), [`order_accuracy_rate`](#order_accuracy_rate), [`refund_rate`](#refund_rate), [`csat`](#csat)

<a id="stockout_rate"></a>
#### Stockout Rate — `stockout_rate`

Percentage of orders that could not be fulfilled due to zero inventory

- **Domain:** Commerce · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/commerce/stockout_rate.yml) · [sql](dbt/analyses/metrics/commerce/stockout_rate.sql)
- **Numerator:** Stockout events
- **Denominator:** Total SKUs
- **Dimensions:** date, product, location
- **Data sources:** inventory, orders
- **Parents:** [`fill_rate`](#fill_rate)
- **Children:** [`inventory_items`](#inventory_items)
- **Correlated:** [`inventory_turnover`](#inventory_turnover), [`order_fulfillment_rate`](#order_fulfillment_rate), [`inventory_items`](#inventory_items)

<a id="take_rate"></a>
#### Take Rate — `take_rate`

Platform revenue as a % of GMV — marketplace monetization efficiency.

- **Domain:** Commerce · **Industry:** marketplace
- **Files:** [yml](dbt/models/metrics/commerce/take_rate.yml) · [sql](dbt/analyses/metrics/commerce/take_rate.sql)
- **Numerator:** Platform Revenue (Fees)
- **Denominator:** GMV
- **Dimensions:** category, tier, period
- **Data sources:** Marketplace platform
- **Parents:** [`revenue`](#revenue)
- **Children:** [`gmv`](#gmv)
- **Correlated:** [`gmv`](#gmv), [`revenue`](#revenue), [`liquidity_rate`](#liquidity_rate), [`marketplace_sellers`](#marketplace_sellers)

### KPI · Customer (16)

<a id="account_health_score"></a>
#### Account Health — `account_health_score`

Composite score combining product usage, support tickets, NPS, and contract size

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/account_health_score.yml) · [sql](dbt/analyses/metrics/customer/account_health_score.sql)
- **Numerator:** Composite score (usage + NPS + support)
- **Dimensions:** date, account, customer_id, segment, plan_tier, cohort_month
- **Data sources:** crm, events, surveys
- **Parents:** [`at_risk_accounts`](#at_risk_accounts), [`churn_rate`](#churn_rate)
- **Children:** [`dau`](#dau), [`renewal_rate`](#renewal_rate), [`ces`](#ces), [`churn_prediction_score`](#churn_prediction_score), [`csat`](#csat), [`customer_onboarding_time`](#customer_onboarding_time), [`dau_mau_ratio`](#dau_mau_ratio), [`feature_adoption_rate`](#feature_adoption_rate)
- **Formula inputs:** [`nps`](#nps)
- **Correlated:** [`at_risk_accounts`](#at_risk_accounts), [`nrr`](#nrr), [`qbr_completion_rate`](#qbr_completion_rate), [`arpu`](#arpu), [`churn_prediction_score`](#churn_prediction_score), [`churn_rate`](#churn_rate), [`customer_churn_rate`](#customer_churn_rate), [`nps`](#nps)

<a id="at_risk_accounts"></a>
#### At-Risk Accounts — `at_risk_accounts`

Number of accounts with health score below the risk threshold

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/at_risk_accounts.yml) · [sql](dbt/analyses/metrics/customer/at_risk_accounts.sql)
- **Numerator:** Accounts below health score threshold
- **Dimensions:** date
- **Data sources:** crm
- **Parents:** [`churn_rate`](#churn_rate)
- **Children:** [`account_health_score`](#account_health_score)
- **Correlated:** [`churn_rate`](#churn_rate), [`renewal_rate`](#renewal_rate), [`account_health_score`](#account_health_score), [`expansion_pipeline`](#expansion_pipeline)

<a id="complaint_resolution_rate"></a>
#### Complaint Resolution % — `complaint_resolution_rate`

Percentage of complaints resolved within the SLA

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/complaint_resolution_rate.yml) · [sql](dbt/analyses/metrics/customer/complaint_resolution_rate.sql)
- **Numerator:** Complaints resolved within SLA
- **Denominator:** Total complaints
- **Dimensions:** date
- **Data sources:** crm
- **Parents:** [`cx_csat`](#cx_csat)
- **Correlated:** [`csat`](#csat), [`sla_breach_rate`](#sla_breach_rate), [`complaints_count`](#complaints_count)

<a id="customer_onboarding_time"></a>
#### Customer Onboarding Time — `customer_onboarding_time`

Average days from contract signed to customer fully live and using the product.

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/customer_onboarding_time.yml) · [sql](dbt/analyses/metrics/customer/customer_onboarding_time.sql)
- **Numerator:** SUM(go_live_date - contract_date)
- **Denominator:** COUNT(onboarded customers)
- **Dimensions:** segment, product, cs_rep_id, period, date, customer_segment
- **Data sources:** CRM, Product analytics
- **Parents:** [`account_health_score`](#account_health_score), [`time_to_value`](#time_to_value)
- **Correlated:** [`time_to_value`](#time_to_value), [`churn_rate`](#churn_rate), [`activation_rate`](#activation_rate)

<a id="escalation_rate"></a>
#### Escalation Rate — `escalation_rate`

Percentage of tickets escalated to tier 2 or above

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/escalation_rate.yml) · [sql](dbt/analyses/metrics/customer/escalation_rate.sql)
- **Numerator:** Escalated tickets
- **Denominator:** Total tickets
- **Dimensions:** date
- **Data sources:** helpdesk
- **Parents:** [`time_to_resolution`](#time_to_resolution)
- **Children:** [`tickets_created`](#tickets_created)
- **Correlated:** [`sla_breach_rate`](#sla_breach_rate), [`time_to_resolution`](#time_to_resolution)

<a id="fcr_rate"></a>
#### FCR Rate — `fcr_rate`

Percentage of support cases resolved on the first contact

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/fcr_rate.yml) · [sql](dbt/analyses/metrics/customer/fcr_rate.sql)
- **Numerator:** Tickets resolved on first contact
- **Denominator:** Total tickets
- **Dimensions:** date, channel
- **Data sources:** helpdesk
- **Parents:** [`csat`](#csat)
- **Children:** [`tickets_created`](#tickets_created)
- **Correlated:** [`time_to_resolution`](#time_to_resolution), [`csat`](#csat), [`tickets_per_agent`](#tickets_per_agent), [`tickets_resolved`](#tickets_resolved), [`tickets_created`](#tickets_created)

<a id="first_response_time"></a>
#### First Response Time — `first_response_time`

Average hours from ticket creation to first agent response.

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/first_response_time.yml) · [sql](dbt/analyses/metrics/customer/first_response_time.sql)
- **Numerator:** SUM(first_response_at - created_at)
- **Denominator:** COUNT(tickets)
- **Dimensions:** priority, channel, team, period
- **Data sources:** Support platform
- **Parents:** [`csat`](#csat), [`sla_breach_rate`](#sla_breach_rate)
- **Children:** [`tickets_created`](#tickets_created)
- **Correlated:** [`ces`](#ces), [`csat`](#csat), [`ticket_backlog`](#ticket_backlog), [`ticket_resolution_rate`](#ticket_resolution_rate), [`time_to_resolution`](#time_to_resolution), [`tickets_created`](#tickets_created)

<a id="qbr_completion_rate"></a>
#### QBR Completion % — `qbr_completion_rate`

Percentage of accounts that had a quarterly business review in the period

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/qbr_completion_rate.yml) · [sql](dbt/analyses/metrics/customer/qbr_completion_rate.sql)
- **Numerator:** QBRs completed
- **Denominator:** QBRs scheduled
- **Dimensions:** date, csm
- **Data sources:** crm
- **Parents:** [`renewal_rate`](#renewal_rate)
- **Correlated:** [`renewal_rate`](#renewal_rate), [`account_health_score`](#account_health_score)

<a id="sla_breach_rate"></a>
#### SLA Breach % — `sla_breach_rate`

Percentage of tickets that exceeded the committed SLA response or resolution time

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/sla_breach_rate.yml) · [sql](dbt/analyses/metrics/customer/sla_breach_rate.sql)
- **Numerator:** SLA breaches
- **Denominator:** Total tickets
- **Dimensions:** date, priority
- **Data sources:** helpdesk
- **Parents:** [`csat`](#csat)
- **Children:** [`time_to_resolution`](#time_to_resolution), [`first_response_time`](#first_response_time), [`ticket_backlog`](#ticket_backlog)
- **Correlated:** [`escalation_rate`](#escalation_rate), [`csat`](#csat), [`complaint_resolution_rate`](#complaint_resolution_rate), [`support_cost_per_ticket`](#support_cost_per_ticket), [`ticket_backlog`](#ticket_backlog), [`tickets_created`](#tickets_created), [`tickets_per_agent`](#tickets_per_agent)

<a id="sla_compliance_rate"></a>
#### SLA Compliance Rate — `sla_compliance_rate`

% of service commitments delivered within contracted SLA windows.

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/sla_compliance_rate.yml) · [sql](dbt/analyses/metrics/customer/sla_compliance_rate.sql)
- **Numerator:** SLA-Compliant Events
- **Denominator:** Total SLA-Tracked Events
- **Dimensions:** service_type, client_id, period
- **Data sources:** Operations platform, CRM
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Correlated:** [`on_time_delivery_rate`](#on_time_delivery_rate), [`csat`](#csat)

<a id="support_cost_per_ticket"></a>
#### Support Cost / Ticket — `support_cost_per_ticket`

Total support cost divided by tickets resolved

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/support_cost_per_ticket.yml) · [sql](dbt/analyses/metrics/customer/support_cost_per_ticket.sql)
- **Numerator:** Support team cost
- **Denominator:** Tickets resolved
- **Dimensions:** date
- **Data sources:** helpdesk, finance
- **Parents:** [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Children:** [`total_comp_expense`](#total_comp_expense), [`tickets_resolved`](#tickets_resolved), [`tickets_per_agent`](#tickets_per_agent)
- **Correlated:** [`hr_cost_pct_revenue`](#hr_cost_pct_revenue), [`sla_breach_rate`](#sla_breach_rate), [`tickets_per_agent`](#tickets_per_agent), [`tickets_per_customer`](#tickets_per_customer), [`tickets_resolved`](#tickets_resolved)

<a id="ticket_backlog"></a>
#### Ticket Backlog — `ticket_backlog`

Open tickets that have been unresolved beyond standard SLA

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/ticket_backlog.yml) · [sql](dbt/analyses/metrics/customer/ticket_backlog.sql)
- **Numerator:** Open tickets beyond SLA threshold
- **Dimensions:** date
- **Data sources:** helpdesk
- **Parents:** [`sla_breach_rate`](#sla_breach_rate)
- **Correlated:** [`sla_breach_rate`](#sla_breach_rate), [`first_response_time`](#first_response_time)

<a id="ticket_resolution_rate"></a>
#### Ticket Resolution Rate — `ticket_resolution_rate`

% of opened tickets resolved within SLA window.

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/ticket_resolution_rate.yml) · [sql](dbt/analyses/metrics/customer/ticket_resolution_rate.sql)
- **Numerator:** Tickets Resolved within SLA
- **Denominator:** Total Tickets Opened
- **Dimensions:** priority, category, team, period
- **Data sources:** Support platform
- **Parents:** [`csat`](#csat)
- **Children:** [`tickets_created`](#tickets_created)
- **Correlated:** [`first_response_time`](#first_response_time), [`ces`](#ces)

<a id="tickets_per_agent"></a>
#### Tickets / Agent / Day — `tickets_per_agent`

Agent productivity measured by tickets closed

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/tickets_per_agent.yml) · [sql](dbt/analyses/metrics/customer/tickets_per_agent.sql)
- **Numerator:** Tickets handled
- **Denominator:** Support agents
- **Dimensions:** date
- **Data sources:** helpdesk
- **Parents:** [`support_cost_per_ticket`](#support_cost_per_ticket)
- **Children:** [`tickets_created`](#tickets_created)
- **Correlated:** [`support_cost_per_ticket`](#support_cost_per_ticket), [`fcr_rate`](#fcr_rate), [`sla_breach_rate`](#sla_breach_rate)

<a id="tickets_per_customer"></a>
#### Tickets / Customer — `tickets_per_customer`

Average support burden per customer — proxy for product quality

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/tickets_per_customer.yml) · [sql](dbt/analyses/metrics/customer/tickets_per_customer.sql)
- **Numerator:** Support tickets
- **Denominator:** Active customers
- **Dimensions:** date, segment
- **Data sources:** helpdesk, crm
- **Parents:** [`csat`](#csat)
- **Children:** [`tickets_created`](#tickets_created)
- **Correlated:** [`csat`](#csat), [`support_cost_per_ticket`](#support_cost_per_ticket)

<a id="time_to_resolution"></a>
#### Time to Resolution — `time_to_resolution`

Average total hours from ticket creation to final resolution.

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/time_to_resolution.yml) · [sql](dbt/analyses/metrics/customer/time_to_resolution.sql)
- **Numerator:** SUM(resolved_at - created_at)
- **Denominator:** COUNT(resolved tickets)
- **Dimensions:** priority, category, channel, team, period, date
- **Data sources:** Support platform
- **Parents:** [`csat`](#csat), [`sla_breach_rate`](#sla_breach_rate)
- **Children:** [`tickets_created`](#tickets_created), [`escalation_rate`](#escalation_rate)
- **Correlated:** [`first_response_time`](#first_response_time), [`csat`](#csat), [`fcr_rate`](#fcr_rate), [`escalation_rate`](#escalation_rate), [`tickets_created`](#tickets_created)

### KPI · Education (27)

<a id="advanced_course_enrollment_rate"></a>
#### Advanced Course Enrollment — `advanced_course_enrollment_rate`

% of students enrolled in AP, IB, or dual-enrollment courses.

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/advanced_course_enrollment_rate.yml) · [sql](dbt/analyses/metrics/education/advanced_course_enrollment_rate.sql)
- **Numerator:** Students in Advanced Courses
- **Denominator:** Total Enrollment
- **Dimensions:** school_id, grade_level, demographic_group, period
- **Data sources:** SIS
- **Parents:** [`four_year_grad_rate`](#four_year_grad_rate)
- **Correlated:** [`college_enrollment`](#college_enrollment), [`student_proficiency`](#student_proficiency)

<a id="ap_participation_rate"></a>
#### AP Participation % — `ap_participation_rate`

Percentage of 11th and 12th graders enrolled in at least one AP course

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/ap_participation_rate.yml) · [sql](dbt/analyses/metrics/education/ap_participation_rate.sql)
- **Numerator:** Students in AP courses
- **Denominator:** 11th–12th grade enrollment
- **Dimensions:** school_year, school
- **Data sources:** course_enrollment
- **Parents:** [`college_enrollment_rate`](#college_enrollment_rate)
- **Children:** [`enrollment_count`](#enrollment_count)
- **Correlated:** [`ap_pass_rate`](#ap_pass_rate), [`college_enrollment_rate`](#college_enrollment_rate)

<a id="ap_pass_rate"></a>
#### AP Pass Rate — `ap_pass_rate`

Percentage of AP exam takers scoring 3, 4, or 5

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/ap_pass_rate.yml) · [sql](dbt/analyses/metrics/education/ap_pass_rate.sql)
- **Numerator:** AP scores of 3+
- **Denominator:** AP tests taken
- **Dimensions:** school_year, subject
- **Data sources:** assessment_data
- **Parents:** [`college_enrollment_rate`](#college_enrollment_rate)
- **Correlated:** [`college_enrollment_rate`](#college_enrollment_rate), [`student_proficiency`](#student_proficiency), [`ap_participation_rate`](#ap_participation_rate)

<a id="chronic_absenteeism_rate"></a>
#### Chronic Absence % — `chronic_absenteeism_rate`

Percentage of students missing 10% or more of enrolled days

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/chronic_absenteeism_rate.yml) · [sql](dbt/analyses/metrics/education/chronic_absenteeism_rate.sql)
- **Numerator:** Students missing 10%+ of school days
- **Denominator:** Enrolled students
- **Dimensions:** school_year, grade, school, school_id, subgroup, grade_level, period, academic_year
- **Data sources:** attendance
- **Parents:** [`student_attendance_rate`](#student_attendance_rate), [`dropout_rate`](#dropout_rate), [`student_proficiency`](#student_proficiency)
- **Children:** [`suspension_rate`](#suspension_rate)
- **Correlated:** [`student_attendance_rate`](#student_attendance_rate), [`dropout_rate`](#dropout_rate), [`ell_pct`](#ell_pct), [`frl_pct`](#frl_pct), [`suspension_rate`](#suspension_rate), [`student_proficiency`](#student_proficiency), [`credit_accumulation_rate`](#credit_accumulation_rate)

<a id="college_enrollment"></a>
#### College Enrollment Rate — `college_enrollment`

% of graduates enrolling in 2- or 4-year college within 1 year.

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/college_enrollment.yml) · [sql](dbt/analyses/metrics/education/college_enrollment.sql)
- **Numerator:** Graduates enrolled in college
- **Denominator:** Total graduates
- **Dimensions:** school_id, grad_year, college_type, subgroup
- **Data sources:** National Student Clearinghouse, SIS
- **Parents:** [`college_enrollment_rate`](#college_enrollment_rate)
- **Children:** [`fafsa_completion_rate`](#fafsa_completion_rate)
- **Correlated:** [`student_proficiency`](#student_proficiency), [`four_year_grad_rate`](#four_year_grad_rate), [`advanced_course_enrollment_rate`](#advanced_course_enrollment_rate), [`fafsa_completion_rate`](#fafsa_completion_rate)

<a id="course_completion_rate"></a>
#### Course Completion % — `course_completion_rate`

Percentage of enrolled students who successfully completed a course

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/course_completion_rate.yml) · [sql](dbt/analyses/metrics/education/course_completion_rate.sql)
- **Numerator:** Courses completed
- **Denominator:** Courses enrolled
- **Dimensions:** school_year, school
- **Data sources:** transcripts
- **Parents:** [`credit_accumulation_rate`](#credit_accumulation_rate)
- **Correlated:** [`dropout_rate`](#dropout_rate), [`ela_proficiency_rate`](#ela_proficiency_rate)

<a id="credit_accumulation_rate"></a>
#### Credit Accumulation Rate — `credit_accumulation_rate`

% of students on track to graduate based on credit accumulation milestones.

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/credit_accumulation_rate.yml) · [sql](dbt/analyses/metrics/education/credit_accumulation_rate.sql)
- **Numerator:** Students on credit pace
- **Denominator:** Total Students
- **Dimensions:** school_id, grade_level, period
- **Data sources:** SIS, Transcript system
- **Parents:** [`four_year_grad_rate`](#four_year_grad_rate)
- **Children:** [`course_completion_rate`](#course_completion_rate)
- **Correlated:** [`four_year_grad_rate`](#four_year_grad_rate), [`chronic_absenteeism_rate`](#chronic_absenteeism_rate)

<a id="dropout_rate"></a>
#### Dropout Rate — `dropout_rate`

Percentage of students who left school without graduating or transferring

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/dropout_rate.yml) · [sql](dbt/analyses/metrics/education/dropout_rate.sql)
- **Numerator:** Dropouts in cohort
- **Denominator:** Beginning enrollment
- **Dimensions:** school_year, school, subgroup
- **Data sources:** enrollment, transcripts
- **Parents:** [`four_year_grad_rate`](#four_year_grad_rate)
- **Children:** [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`suspension_rate`](#suspension_rate)
- **Correlated:** [`four_year_grad_rate`](#four_year_grad_rate), [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`course_completion_rate`](#course_completion_rate), [`expulsion_rate`](#expulsion_rate)

<a id="ela_proficiency_rate"></a>
#### ELA Proficiency % — `ela_proficiency_rate`

Percentage of students scoring proficient or advanced on ELA state assessments

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/ela_proficiency_rate.yml) · [sql](dbt/analyses/metrics/education/ela_proficiency_rate.sql)
- **Numerator:** Proficient in ELA
- **Denominator:** Enrolled students tested
- **Dimensions:** school_year, grade, school
- **Data sources:** assessment_data
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Children:** [`grade3_reading`](#grade3_reading), [`student_growth_percentile`](#student_growth_percentile), [`student_attendance_rate`](#student_attendance_rate)
- **Correlated:** [`math_proficiency_rate`](#math_proficiency_rate), [`student_attendance_rate`](#student_attendance_rate), [`avg_teacher_experience`](#avg_teacher_experience), [`course_completion_rate`](#course_completion_rate), [`ell_pct`](#ell_pct), [`grade3_reading`](#grade3_reading), [`iep_pct`](#iep_pct), [`instructional_spend_ratio`](#instructional_spend_ratio)

<a id="ell_proficiency_growth"></a>
#### ELL Proficiency Growth — `ell_proficiency_growth`

% of English Language Learners who advance at least one proficiency level annually.

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/ell_proficiency_growth.yml) · [sql](dbt/analyses/metrics/education/ell_proficiency_growth.sql)
- **Numerator:** ELLs advancing one or more levels
- **Denominator:** Total ELL Students
- **Dimensions:** school_id, grade_level, home_language, period
- **Data sources:** SIS, ELL assessment system
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`student_proficiency`](#student_proficiency), [`student_attendance_rate`](#student_attendance_rate)

<a id="enrollment_count"></a>
#### Enrollment Count — `enrollment_count`

Total enrolled students at a school or district as of census date.

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/enrollment_count.yml) · [sql](dbt/analyses/metrics/education/enrollment_count.sql)
- **Numerator:** COUNT(active enrollments)
- **Dimensions:** school_id, grade_level, demographic_group, period, school_year, school
- **Data sources:** SIS
- **Parents:** [`per_pupil_expenditure`](#per_pupil_expenditure), [`student_teacher_ratio`](#student_teacher_ratio), [`ap_participation_rate`](#ap_participation_rate)
- **Correlated:** [`four_year_grad_rate`](#four_year_grad_rate), [`student_attendance_rate`](#student_attendance_rate), [`seat_fill_rate`](#seat_fill_rate), [`adm`](#adm), [`per_pupil_expenditure`](#per_pupil_expenditure)

<a id="fafsa_completion_rate"></a>
#### FAFSA Completion Rate — `fafsa_completion_rate`

% of 12th graders who complete the FAFSA — college access predictor.

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/fafsa_completion_rate.yml) · [sql](dbt/analyses/metrics/education/fafsa_completion_rate.sql)
- **Numerator:** Seniors who completed FAFSA
- **Denominator:** Total 12th Grade Enrollment
- **Dimensions:** school_id, demographic_group, period
- **Data sources:** SIS, College guidance system
- **Parents:** [`college_enrollment`](#college_enrollment), [`college_enrollment_rate`](#college_enrollment_rate)
- **Correlated:** [`college_enrollment`](#college_enrollment), [`four_year_grad_rate`](#four_year_grad_rate)

<a id="grade3_reading"></a>
#### Gr3 Reading % — `grade3_reading`

Percentage of 3rd graders reading at or above grade level

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/grade3_reading.yml) · [sql](dbt/analyses/metrics/education/grade3_reading.sql)
- **Numerator:** Grade 3 reading proficient
- **Denominator:** Grade 3 enrolled
- **Dimensions:** school_year, school
- **Data sources:** assessment_data
- **Parents:** [`ela_proficiency_rate`](#ela_proficiency_rate)
- **Children:** [`kinder_readiness`](#kinder_readiness)
- **Correlated:** [`ela_proficiency_rate`](#ela_proficiency_rate), [`student_attendance_rate`](#student_attendance_rate), [`kinder_readiness`](#kinder_readiness)

<a id="iep_goal_mastery_rate"></a>
#### IEP Goal Mastery Rate — `iep_goal_mastery_rate`

% of IEP goals marked as mastered by end of evaluation period.

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/iep_goal_mastery_rate.yml) · [sql](dbt/analyses/metrics/education/iep_goal_mastery_rate.sql)
- **Numerator:** Mastered IEP Goals
- **Denominator:** Total IEP Goals
- **Dimensions:** school_id, disability_category, grade_level, period
- **Data sources:** Special education management system
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`student_proficiency`](#student_proficiency), [`student_attendance_rate`](#student_attendance_rate)

<a id="instructional_spend_ratio"></a>
#### Instructional Spend % — `instructional_spend_ratio`

Percentage of operating budget spent directly on instruction

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/instructional_spend_ratio.yml) · [sql](dbt/analyses/metrics/education/instructional_spend_ratio.sql)
- **Numerator:** Instructional spending
- **Denominator:** Total expenditure
- **Dimensions:** school_year
- **Data sources:** finance
- **Parents:** [`per_pupil_expenditure`](#per_pupil_expenditure)
- **Correlated:** [`per_pupil_expenditure`](#per_pupil_expenditure), [`ela_proficiency_rate`](#ela_proficiency_rate)

<a id="kinder_readiness"></a>
#### K-Readiness % — `kinder_readiness`

Percentage of entering kindergarteners scoring ready on standardized screening

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/kinder_readiness.yml) · [sql](dbt/analyses/metrics/education/kinder_readiness.sql)
- **Numerator:** Kindergarteners testing ready
- **Denominator:** Total kindergarteners
- **Dimensions:** school_year, school
- **Data sources:** assessment_data
- **Parents:** [`grade3_reading`](#grade3_reading)
- **Correlated:** [`grade3_reading`](#grade3_reading), [`student_attendance_rate`](#student_attendance_rate)

<a id="math_proficiency_rate"></a>
#### Math Proficiency % — `math_proficiency_rate`

Percentage of students scoring proficient or advanced on math state assessments

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/math_proficiency_rate.yml) · [sql](dbt/analyses/metrics/education/math_proficiency_rate.sql)
- **Numerator:** Proficient in math
- **Denominator:** Enrolled students tested
- **Dimensions:** school_year, grade, school
- **Data sources:** assessment_data
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Children:** [`student_growth_percentile`](#student_growth_percentile)
- **Correlated:** [`ela_proficiency_rate`](#ela_proficiency_rate), [`student_attendance_rate`](#student_attendance_rate)

<a id="per_pupil_expenditure"></a>
#### Per Pupil Expenditure — `per_pupil_expenditure`

Total operating spend divided by average daily membership.

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/per_pupil_expenditure.yml) · [sql](dbt/analyses/metrics/education/per_pupil_expenditure.sql)
- **Numerator:** Total expenditures
- **Denominator:** Average daily membership (ADM)
- **Dimensions:** school_id, fiscal_year, function_code, fund
- **Data sources:** Finance system (Infinite Visions / QuickBooks), State reporting
- **Parents:** [`cost_per_outcome`](#cost_per_outcome), [`student_proficiency`](#student_proficiency)
- **Children:** [`enrollment_count`](#enrollment_count), [`instructional_spend_ratio`](#instructional_spend_ratio), [`seat_fill_rate`](#seat_fill_rate), [`staff_student_cost_ratio`](#staff_student_cost_ratio), [`student_teacher_ratio`](#student_teacher_ratio)
- **Correlated:** [`student_attendance_rate`](#student_attendance_rate), [`adm`](#adm), [`cost_per_outcome`](#cost_per_outcome), [`frl_pct`](#frl_pct), [`iep_pct`](#iep_pct), [`instructional_spend_ratio`](#instructional_spend_ratio), [`enrollment_count`](#enrollment_count), [`seat_fill_rate`](#seat_fill_rate), [`staff_student_cost_ratio`](#staff_student_cost_ratio), [`student_teacher_ratio`](#student_teacher_ratio)

<a id="school_climate_score"></a>
#### Climate Score — `school_climate_score`

Average score from student, staff, and family school climate surveys

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/school_climate_score.yml) · [sql](dbt/analyses/metrics/education/school_climate_score.sql)
- **Numerator:** Composite climate survey score (0–100)
- **Dimensions:** school_year, school, school_id, respondent_type, survey_cycle
- **Data sources:** surveys
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Children:** [`extracurricular_rate`](#extracurricular_rate), [`family_engagement_rate`](#family_engagement_rate)
- **Correlated:** [`teacher_retention_rate`](#teacher_retention_rate), [`suspension_rate`](#suspension_rate), [`student_attendance_rate`](#student_attendance_rate), [`extracurricular_rate`](#extracurricular_rate), [`family_engagement_rate`](#family_engagement_rate), [`employee_engagement_score`](#employee_engagement_score)

<a id="science_proficiency_rate"></a>
#### Science Proficiency % — `science_proficiency_rate`

Percentage of students scoring proficient on science state assessments

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/science_proficiency_rate.yml) · [sql](dbt/analyses/metrics/education/science_proficiency_rate.sql)
- **Parents:** [`student_proficiency`](#student_proficiency)

<a id="seat_fill_rate"></a>
#### Seat Fill Rate — `seat_fill_rate`

% of available enrollment seats filled by students at a school.

- **Domain:** Education · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/education/seat_fill_rate.yml) · [sql](dbt/analyses/metrics/education/seat_fill_rate.sql)
- **Numerator:** Enrolled Students
- **Denominator:** Available Seats
- **Dimensions:** school_id, grade_level, period
- **Data sources:** SIS, Facilities system
- **Parents:** [`per_pupil_expenditure`](#per_pupil_expenditure)
- **Correlated:** [`enrollment_count`](#enrollment_count), [`per_pupil_expenditure`](#per_pupil_expenditure)

<a id="staff_student_cost_ratio"></a>
#### Staff-to-Student Cost Ratio — `staff_student_cost_ratio`

Personnel costs as a share of total per-pupil expenditure — staffing investment intensity.

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/staff_student_cost_ratio.yml) · [sql](dbt/analyses/metrics/education/staff_student_cost_ratio.sql)
- **Numerator:** Total Personnel Cost
- **Denominator:** Total Operating Budget
- **Dimensions:** school_id, fiscal_year
- **Data sources:** Finance, HRIS
- **Parents:** [`per_pupil_expenditure`](#per_pupil_expenditure)
- **Children:** [`headcount_cost`](#headcount_cost)
- **Correlated:** [`teacher_retention_rate`](#teacher_retention_rate), [`per_pupil_expenditure`](#per_pupil_expenditure)

<a id="student_attendance_rate"></a>
#### Attendance Rate — `student_attendance_rate`

Percentage of scheduled school days attended across all students

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/student_attendance_rate.yml) · [sql](dbt/analyses/metrics/education/student_attendance_rate.sql)
- **Numerator:** Days attended
- **Denominator:** Days enrolled
- **Dimensions:** school_year, grade, school, school_id, grade_level, subgroup, month, period
- **Data sources:** attendance
- **Parents:** [`four_year_grad_rate`](#four_year_grad_rate), [`ela_proficiency_rate`](#ela_proficiency_rate), [`student_proficiency`](#student_proficiency)
- **Children:** [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`adm`](#adm)
- **Correlated:** [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`student_growth_percentile`](#student_growth_percentile), [`ela_proficiency_rate`](#ela_proficiency_rate), [`extracurricular_rate`](#extracurricular_rate), [`family_engagement_rate`](#family_engagement_rate), [`grade3_reading`](#grade3_reading), [`kinder_readiness`](#kinder_readiness), [`math_proficiency_rate`](#math_proficiency_rate), [`school_climate_score`](#school_climate_score), [`student_proficiency`](#student_proficiency), [`suspension_rate`](#suspension_rate), [`ell_proficiency_growth`](#ell_proficiency_growth), [`enrollment_count`](#enrollment_count), [`four_year_grad_rate`](#four_year_grad_rate), [`iep_goal_mastery_rate`](#iep_goal_mastery_rate), [`on_time_lesson_delivery`](#on_time_lesson_delivery), [`per_pupil_expenditure`](#per_pupil_expenditure)

<a id="student_growth_percentile"></a>
#### Student Growth Percentile — `student_growth_percentile`

Median Student Growth Percentile — measures growth relative to academic peers

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/student_growth_percentile.yml) · [sql](dbt/analyses/metrics/education/student_growth_percentile.sql)
- **Numerator:** Student's percentile relative to academic peers
- **Dimensions:** school_year, grade, school, student_id, subject, grade_level, period
- **Data sources:** assessment_data
- **Parents:** [`ela_proficiency_rate`](#ela_proficiency_rate), [`math_proficiency_rate`](#math_proficiency_rate), [`student_proficiency`](#student_proficiency)
- **Correlated:** [`student_proficiency`](#student_proficiency), [`student_attendance_rate`](#student_attendance_rate), [`student_teacher_ratio`](#student_teacher_ratio)

<a id="student_teacher_ratio"></a>
#### Student:Teacher Ratio — `student_teacher_ratio`

Number of enrolled students per FTE classroom teacher

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/student_teacher_ratio.yml) · [sql](dbt/analyses/metrics/education/student_teacher_ratio.sql)
- **Numerator:** Students
- **Denominator:** Full-time-equivalent teachers
- **Dimensions:** school_year, school, school_id, grade_level, period
- **Data sources:** enrollment, hris
- **Parents:** [`per_pupil_expenditure`](#per_pupil_expenditure)
- **Children:** [`enrollment_count`](#enrollment_count), [`headcount_fte`](#headcount_fte)
- **Correlated:** [`per_pupil_expenditure`](#per_pupil_expenditure), [`student_growth_percentile`](#student_growth_percentile), [`student_proficiency`](#student_proficiency), [`teacher_retention_rate`](#teacher_retention_rate)

<a id="suspension_rate"></a>
#### Suspension Rate — `suspension_rate`

% of students who received at least one out-of-school suspension in a year.

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/suspension_rate.yml) · [sql](dbt/analyses/metrics/education/suspension_rate.sql)
- **Numerator:** Students suspended
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school, subgroup
- **Data sources:** discipline
- **Parents:** [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`dropout_rate`](#dropout_rate)
- **Children:** [`expulsion_rate`](#expulsion_rate)
- **Correlated:** [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`school_climate_score`](#school_climate_score), [`student_attendance_rate`](#student_attendance_rate), [`expulsion_rate`](#expulsion_rate)

<a id="teacher_retention_rate"></a>
#### Teacher Retention Rate — `teacher_retention_rate`

% of teachers who return the following school year.

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/teacher_retention_rate.yml) · [sql](dbt/analyses/metrics/education/teacher_retention_rate.sql)
- **Numerator:** Teachers returning next year
- **Denominator:** Teachers at end of prior year
- **Dimensions:** school_id, subject_area, experience_band, period
- **Data sources:** HRIS, SIS
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`student_proficiency`](#student_proficiency), [`avg_teacher_experience`](#avg_teacher_experience), [`on_time_lesson_delivery`](#on_time_lesson_delivery), [`school_climate_score`](#school_climate_score), [`staff_student_cost_ratio`](#staff_student_cost_ratio), [`student_teacher_ratio`](#student_teacher_ratio)

### KPI · Engineering (10)

<a id="bug_escape_rate"></a>
#### Bug Escape Rate — `bug_escape_rate`

Percentage of released code that contained production bugs

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/bug_escape_rate.yml) · [sql](dbt/analyses/metrics/engineering/bug_escape_rate.sql)
- **Numerator:** Bugs found in prod
- **Denominator:** Total bugs
- **Dimensions:** date, severity
- **Data sources:** bug_tracker
- **Parents:** [`error_rate`](#error_rate)
- **Children:** [`code_coverage`](#code_coverage)
- **Correlated:** [`change_failure_rate`](#change_failure_rate), [`code_coverage`](#code_coverage), [`tech_debt_ratio`](#tech_debt_ratio)

<a id="change_failure_rate"></a>
#### Change Failure % — `change_failure_rate`

Percentage of deployments causing production incidents (DORA metric)

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/change_failure_rate.yml) · [sql](dbt/analyses/metrics/engineering/change_failure_rate.sql)
- **Numerator:** Failed deployments
- **Denominator:** Total deployments
- **Dimensions:** date
- **Data sources:** ci_cd, incident_management
- **Parents:** [`uptime`](#uptime)
- **Children:** [`deployment_frequency`](#deployment_frequency), [`tech_debt_ratio`](#tech_debt_ratio)
- **Correlated:** [`mttr`](#mttr), [`bug_escape_rate`](#bug_escape_rate), [`code_coverage`](#code_coverage), [`deployment_frequency`](#deployment_frequency)

<a id="deployment_frequency"></a>
#### Deployment Frequency — `deployment_frequency`

Number of production deployments per week — DORA engineering velocity metric.

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/deployment_frequency.yml) · [sql](dbt/analyses/metrics/engineering/deployment_frequency.sql)
- **Numerator:** Deployments in period
- **Dimensions:** date, service
- **Data sources:** ci_cd
- **Parents:** [`change_failure_rate`](#change_failure_rate)
- **Children:** [`lead_time_for_changes`](#lead_time_for_changes), [`sprint_velocity`](#sprint_velocity)
- **Correlated:** [`change_failure_rate`](#change_failure_rate), [`pr_merge_time`](#pr_merge_time), [`lead_time_for_changes`](#lead_time_for_changes), [`rd_headcount`](#rd_headcount), [`rd_headcount_pct`](#rd_headcount_pct), [`sprint_velocity`](#sprint_velocity)

<a id="lead_time_for_changes"></a>
#### Lead Time for Changes — `lead_time_for_changes`

Median time from code commit to production deployment — DORA metric.

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/lead_time_for_changes.yml) · [sql](dbt/analyses/metrics/engineering/lead_time_for_changes.sql)
- **Numerator:** MEDIAN(deploy_time - commit_time)
- **Dimensions:** team, service, period
- **Data sources:** CI/CD platform, Version control
- **Parents:** [`deployment_frequency`](#deployment_frequency)
- **Children:** [`pr_merge_time`](#pr_merge_time)
- **Correlated:** [`deployment_frequency`](#deployment_frequency), [`error_rate`](#error_rate)

<a id="mtbf"></a>
#### MTBF — `mtbf`

Mean Time Between Failures — average operating time between unplanned stoppages.

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/mtbf.yml) · [sql](dbt/analyses/metrics/engineering/mtbf.sql)
- **Numerator:** Total Uptime Hours
- **Denominator:** Number of Failures
- **Dimensions:** system_id, facility_id, period
- **Data sources:** CMMS, SCADA
- **Parents:** [`uptime`](#uptime)
- **Children:** [`preventive_maintenance_rate`](#preventive_maintenance_rate)
- **Correlated:** [`preventive_maintenance_rate`](#preventive_maintenance_rate), [`uptime`](#uptime)

<a id="mttd"></a>
#### MTTD — `mttd`

Average hours from incident start to detection

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/mttd.yml) · [sql](dbt/analyses/metrics/engineering/mttd.sql)
- **Numerator:** Sum of detection times
- **Denominator:** Number of incidents
- **Dimensions:** date
- **Data sources:** monitoring
- **Parents:** [`uptime`](#uptime)
- **Children:** [`incident_count`](#incident_count)
- **Correlated:** [`mttr`](#mttr), [`error_rate`](#error_rate), [`incident_count`](#incident_count)

<a id="mttr"></a>
#### MTTR — `mttr`

Mean Time to Repair — average time to restore equipment after failure.

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/mttr.yml) · [sql](dbt/analyses/metrics/engineering/mttr.sql)
- **Numerator:** Sum of resolution times
- **Denominator:** Number of incidents
- **Dimensions:** date
- **Data sources:** incident_management
- **Parents:** [`uptime`](#uptime)
- **Children:** [`incident_count`](#incident_count)
- **Correlated:** [`mttd`](#mttd), [`uptime`](#uptime), [`change_failure_rate`](#change_failure_rate), [`incident_count`](#incident_count), [`rcr_rate`](#rcr_rate)

<a id="rcr_rate"></a>
#### Root Cause Resolution % — `rcr_rate`

Percentage of incidents with documented root cause and resolution

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/rcr_rate.yml) · [sql](dbt/analyses/metrics/engineering/rcr_rate.sql)
- **Numerator:** Incidents with documented root cause
- **Denominator:** Total incidents
- **Dimensions:** date
- **Data sources:** incident_management
- **Parents:** [`uptime`](#uptime)
- **Correlated:** [`incident_count`](#incident_count), [`mttr`](#mttr)

<a id="tech_debt_ratio"></a>
#### Tech Debt Ratio — `tech_debt_ratio`

Estimated remediation cost of tech debt relative to development cost

- **Domain:** Engineering · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/engineering/tech_debt_ratio.yml) · [sql](dbt/analyses/metrics/engineering/tech_debt_ratio.sql)
- **Numerator:** Technical debt hours
- **Denominator:** Total dev hours
- **Dimensions:** date, service
- **Data sources:** code_analysis
- **Parents:** [`change_failure_rate`](#change_failure_rate)
- **Correlated:** [`code_coverage`](#code_coverage), [`bug_escape_rate`](#bug_escape_rate), [`sprint_velocity`](#sprint_velocity)

<a id="uptime"></a>
#### Uptime % — `uptime`

Percentage of scheduled uptime the service was available

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/uptime.yml) · [sql](dbt/analyses/metrics/engineering/uptime.sql)
- **Numerator:** Minutes available
- **Denominator:** Total minutes
- **Dimensions:** date, service, environment, period, system_id, facility_id
- **Data sources:** monitoring
- **Parents:** [`error_rate`](#error_rate), [`ops_north_star`](#ops_north_star)
- **Children:** [`incident_count`](#incident_count), [`change_failure_rate`](#change_failure_rate), [`mttd`](#mttd), [`rcr_rate`](#rcr_rate), [`mtbf`](#mtbf), [`mttr`](#mttr), [`work_order_resolution_time`](#work_order_resolution_time)
- **Correlated:** [`error_rate`](#error_rate), [`mttr`](#mttr), [`api_latency_p95`](#api_latency_p95), [`preventive_maintenance_rate`](#preventive_maintenance_rate), [`mtbf`](#mtbf)

### KPI · Finance (62)

<a id="ar_aging_90d"></a>
#### AR Aging 90d+ — `ar_aging_90d`

Total outstanding receivables past 90 days — bad debt risk indicator.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/ar_aging_90d.yml) · [sql](dbt/analyses/metrics/finance/ar_aging_90d.sql)
- **Numerator:** SUM(invoice_amount WHERE days_outstanding > 90)
- **Dimensions:** company_id, customer_segment, period
- **Data sources:** ERP, AR aging report
- **Parents:** [`dso`](#dso), [`bad_debt_rate`](#bad_debt_rate)
- **Children:** [`billings`](#billings)
- **Correlated:** [`dso`](#dso), [`working_capital`](#working_capital), [`bad_debt_rate`](#bad_debt_rate)

<a id="arpu"></a>
#### ARPU — `arpu`

Average Revenue Per User — revenue efficiency across the base.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/arpu.yml) · [sql](dbt/analyses/metrics/finance/arpu.sql)
- **Numerator:** Total Revenue
- **Denominator:** Active Customers (period)
- **Dimensions:** segment, product_category, channel, month
- **Data sources:** Transactional DB, Billing system
- **Parents:** [`customer_ltv`](#customer_ltv), [`revenue`](#revenue), [`cac_payback`](#cac_payback)
- **Children:** [`revenue_per_account`](#revenue_per_account)
- **Correlated:** [`customer_ltv`](#customer_ltv), [`churn_rate`](#churn_rate), [`account_health_score`](#account_health_score), [`iap_revenue`](#iap_revenue), [`revenue`](#revenue), [`revenue_per_account`](#revenue_per_account)

<a id="asp"></a>
#### ASP — `asp`

Average selling price per unit or transaction — pricing health signal.

- **Domain:** Finance · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/finance/asp.yml) · [sql](dbt/analyses/metrics/finance/asp.sql)
- **Numerator:** Total Revenue
- **Denominator:** Units Sold
- **Dimensions:** product_line, channel, geography, period
- **Data sources:** ERP, Billing system
- **Parents:** [`revenue`](#revenue)
- **Correlated:** [`revenue`](#revenue), [`gross_margin_pct`](#gross_margin_pct)

<a id="bad_debt_rate"></a>
#### Bad Debt Rate — `bad_debt_rate`

% of revenue written off as uncollectible bad debt.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/bad_debt_rate.yml) · [sql](dbt/analyses/metrics/finance/bad_debt_rate.sql)
- **Numerator:** Bad Debt Write-Offs
- **Denominator:** Revenue
- **Dimensions:** company_id, customer_segment, fiscal_period
- **Data sources:** ERP, Finance
- **Parents:** [`ebitda`](#ebitda)
- **Children:** [`ar_aging_90d`](#ar_aging_90d)
- **Correlated:** [`dso`](#dso), [`ar_aging_90d`](#ar_aging_90d)

<a id="billings"></a>
#### Billings — `billings`

Total amounts invoiced to customers in a period — cash collection indicator.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/billings.yml) · [sql](dbt/analyses/metrics/finance/billings.sql)
- **Numerator:** SUM(invoiced amounts)
- **Dimensions:** segment, product_tier, period
- **Data sources:** Billing system
- **Parents:** [`revenue`](#revenue), [`dso`](#dso), [`ar_aging_90d`](#ar_aging_90d), [`deferred_revenue`](#deferred_revenue)
- **Children:** [`contracted_unbilled`](#contracted_unbilled)
- **Correlated:** [`arr`](#arr), [`revenue`](#revenue), [`free_cash_flow`](#free_cash_flow), [`accounts_receivable`](#accounts_receivable), [`contracted_unbilled`](#contracted_unbilled), [`deferred_revenue`](#deferred_revenue)

<a id="budget_variance"></a>
#### Budget Variance — `budget_variance`

Actual spend vs budget — positive = over budget, negative = under budget.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/budget_variance.yml) · [sql](dbt/analyses/metrics/finance/budget_variance.sql)
- **Numerator:** Actual spend − Budgeted spend
- **Denominator:** Budgeted spend
- **Dimensions:** date, department
- **Data sources:** budget_tracking, general_ledger
- **Parents:** [`budget_variance_pct`](#budget_variance_pct)
- **Children:** [`annual_budget`](#annual_budget)
- **Correlated:** [`forecast_accuracy`](#forecast_accuracy), [`opex`](#opex), [`annual_budget`](#annual_budget), [`headcount_vs_budget`](#headcount_vs_budget)

<a id="budget_variance_pct"></a>
#### Budget Variance % — `budget_variance_pct`

Budget variance as a % of budget — normalized over/under indicator.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/budget_variance_pct.yml) · [sql](dbt/analyses/metrics/finance/budget_variance_pct.sql)
- **Numerator:** Actual - Budget
- **Denominator:** Budget
- **Dimensions:** department, cost_center, fiscal_period
- **Data sources:** ERP, Budgeting system
- **Parents:** [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Children:** [`budget_variance`](#budget_variance)
- **Correlated:** [`opex`](#opex), [`ebitda_margin`](#ebitda_margin)

<a id="burn_rate"></a>
#### Burn Rate — `burn_rate`

Monthly net cash outflow — critical for pre-revenue or high-growth companies.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/burn_rate.yml) · [sql](dbt/analyses/metrics/finance/burn_rate.sql)
- **Numerator:** Monthly net cash outflow
- **Dimensions:** date
- **Data sources:** bank_transactions, general_ledger
- **Parents:** [`runway_months`](#runway_months)
- **Children:** [`opex`](#opex), [`capex`](#capex)
- **Correlated:** [`free_cash_flow`](#free_cash_flow), [`runway_months`](#runway_months), [`cash_and_equivalents`](#cash_and_equivalents)

<a id="cac"></a>
#### CAC — `cac`

Customer Acquisition Cost — total sales & marketing spend per new customer.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cac.yml) · [sql](dbt/analyses/metrics/finance/cac.sql)
- **Numerator:** Total sales & marketing spend
- **Denominator:** New customers
- **Dimensions:** date, channel
- **Data sources:** general_ledger, customers
- **Parents:** [`ltv_cac`](#ltv_cac), [`cac_payback`](#cac_payback)
- **Children:** [`marketing_cac`](#marketing_cac), [`monthly_new_customers`](#monthly_new_customers), [`cost_per_mql`](#cost_per_mql), [`cost_per_sql`](#cost_per_sql), [`marketing_spend`](#marketing_spend), [`mql`](#mql), [`sales_spend`](#sales_spend)
- **Correlated:** [`cac_payback`](#cac_payback), [`magic_number`](#magic_number), [`ltv_cac`](#ltv_cac), [`arr_per_rep`](#arr_per_rep), [`clv`](#clv), [`cost_per_sql`](#cost_per_sql), [`monthly_new_customers`](#monthly_new_customers), [`marketing_cac`](#marketing_cac), [`mql_to_sql_rate`](#mql_to_sql_rate), [`net_new_customers`](#net_new_customers), [`rev_from_new_customers`](#rev_from_new_customers), [`revenue`](#revenue), [`roas`](#roas), [`sales_cycle_length`](#sales_cycle_length), [`sales_spend`](#sales_spend), [`sm_spend`](#sm_spend), [`time_to_fill`](#time_to_fill), [`win_rate`](#win_rate)

<a id="cac_payback"></a>
#### CAC Payback (mo) — `cac_payback`

Months to recover customer acquisition cost from gross margin

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cac_payback.yml) · [sql](dbt/analyses/metrics/finance/cac_payback.sql)
- **Numerator:** CAC
- **Denominator:** MRR × Gross Margin %
- **Dimensions:** date, channel, segment, cohort
- **Data sources:** subscriptions, general_ledger
- **Parents:** [`ltv_cac`](#ltv_cac)
- **Children:** [`cac`](#cac), [`gross_margin_pct`](#gross_margin_pct), [`arpu`](#arpu), [`sm_spend`](#sm_spend), [`mrr`](#mrr)
- **Correlated:** [`magic_number`](#magic_number), [`ltv_cac`](#ltv_cac), [`avg_sales_cycle`](#avg_sales_cycle), [`cac`](#cac), [`churn_rate`](#churn_rate), [`arr`](#arr)

<a id="capex"></a>
#### CapEx — `capex`

Capital expenditures — spend on fixed assets and infrastructure.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/capex.yml) · [sql](dbt/analyses/metrics/finance/capex.sql)
- **Numerator:** SUM(capex_amount)
- **Dimensions:** company_id, asset_category, fiscal_period
- **Data sources:** ERP, Fixed asset register
- **Parents:** [`free_cash_flow`](#free_cash_flow), [`burn_rate`](#burn_rate), [`capex_pct_revenue`](#capex_pct_revenue)
- **Correlated:** [`ebitda`](#ebitda), [`rd_expense`](#rd_expense), [`da`](#da)

<a id="capex_pct_revenue"></a>
#### CapEx % Revenue — `capex_pct_revenue`

Capital spend intensity relative to revenue.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/capex_pct_revenue.yml) · [sql](dbt/analyses/metrics/finance/capex_pct_revenue.sql)
- **Numerator:** CapEx
- **Denominator:** Revenue
- **Dimensions:** company_id, fiscal_period
- **Data sources:** ERP
- **Parents:** [`free_cash_flow`](#free_cash_flow)
- **Children:** [`capex`](#capex)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`free_cash_flow`](#free_cash_flow)

<a id="cogs"></a>
#### COGS — `cogs`

Total cost of goods sold in a period.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cogs.yml) · [sql](dbt/analyses/metrics/finance/cogs.sql)
- **Numerator:** SUM(cogs_amount)
- **Dimensions:** company_id, product_line, fiscal_period
- **Data sources:** ERP
- **Parents:** [`ebitda`](#ebitda), [`gross_margin_pct`](#gross_margin_pct), [`gross_profit`](#gross_profit), [`dpo`](#dpo), [`inventory_turnover`](#inventory_turnover)
- **Children:** [`procurement_savings_rate`](#procurement_savings_rate), [`shrinkage_rate`](#shrinkage_rate)
- **Correlated:** [`revenue`](#revenue), [`gross_margin_pct`](#gross_margin_pct), [`inventory_turnover`](#inventory_turnover), [`inventory_value`](#inventory_value)

<a id="current_ratio"></a>
#### Current Ratio — `current_ratio`

Current assets divided by current liabilities — liquidity benchmark (>1 = solvent).

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/current_ratio.yml) · [sql](dbt/analyses/metrics/finance/current_ratio.sql)
- **Numerator:** Current Assets
- **Denominator:** Current Liabilities
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`working_capital`](#working_capital)
- **Children:** [`cash_and_equivalents`](#cash_and_equivalents), [`accounts_receivable`](#accounts_receivable), [`accounts_payable`](#accounts_payable), [`total_assets`](#total_assets)
- **Correlated:** [`working_capital`](#working_capital), [`debt_to_equity`](#debt_to_equity), [`net_debt`](#net_debt), [`quick_ratio`](#quick_ratio)

<a id="customer_concentration_risk"></a>
#### Customer Concentration — `customer_concentration_risk`

Top 10 customers’ ARR as % of total ARR — revenue dependency risk indicator.

- **Domain:** Finance · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/finance/customer_concentration_risk.yml) · [sql](dbt/analyses/metrics/finance/customer_concentration_risk.sql)
- **Numerator:** ARR from Top 10 Customers
- **Denominator:** Total ARR
- **Dimensions:** company_id, period
- **Data sources:** Billing system, CRM
- **Parents:** [`enterprise_value`](#enterprise_value)
- **Children:** [`rev_concentration_top10`](#rev_concentration_top10), [`mrr`](#mrr)
- **Correlated:** [`churn_rate`](#churn_rate), [`arr`](#arr), [`rev_concentration_top10`](#rev_concentration_top10)

<a id="debt_ebitda"></a>
#### Debt / EBITDA — `debt_ebitda`

Leverage ratio — total debt divided by trailing twelve-month EBITDA.

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/debt_ebitda.yml) · [sql](dbt/analyses/metrics/finance/debt_ebitda.sql)
- **Numerator:** Total Debt
- **Denominator:** TTM EBITDA
- **Dimensions:** company_id, quarter
- **Data sources:** Balance sheet, ERP
- **Parents:** [`leverage_ratio`](#leverage_ratio)
- **Formula inputs:** [`ebitda`](#ebitda)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`free_cash_flow`](#free_cash_flow), [`interest_coverage_ratio`](#interest_coverage_ratio), [`roa`](#roa), [`roe`](#roe)

<a id="debt_to_equity"></a>
#### D/E Ratio — `debt_to_equity`

Total debt divided by shareholder equity

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/debt_to_equity.yml) · [sql](dbt/analyses/metrics/finance/debt_to_equity.sql)
- **Numerator:** Total Debt
- **Denominator:** Shareholders' Equity
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`roe`](#roe)
- **Children:** [`total_debt`](#total_debt), [`shareholder_equity`](#shareholder_equity)
- **Correlated:** [`leverage_ratio`](#leverage_ratio), [`current_ratio`](#current_ratio), [`interest_coverage_ratio`](#interest_coverage_ratio), [`ev_ebitda`](#ev_ebitda), [`total_liabilities`](#total_liabilities)

<a id="deferred_revenue"></a>
#### Deferred Revenue — `deferred_revenue`

Cash collected but not yet recognized as revenue — forward revenue visibility.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/deferred_revenue.yml) · [sql](dbt/analyses/metrics/finance/deferred_revenue.sql)
- **Numerator:** SUM(unrecognized billed amounts)
- **Dimensions:** company_id, product_tier, period
- **Data sources:** ERP, Billing system
- **Parents:** [`operating_cash_flow`](#operating_cash_flow)
- **Children:** [`billings`](#billings)
- **Correlated:** [`arr`](#arr), [`billings`](#billings), [`revenue`](#revenue)

<a id="dpo"></a>
#### DPO — `dpo`

Average days taken to pay suppliers

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/dpo.yml) · [sql](dbt/analyses/metrics/finance/dpo.sql)
- **Numerator:** Accounts Payable × 365
- **Denominator:** COGS
- **Dimensions:** date, vendor
- **Data sources:** purchase_orders, payments
- **Parents:** [`working_capital`](#working_capital)
- **Children:** [`accounts_payable`](#accounts_payable), [`cogs`](#cogs)
- **Correlated:** [`dso`](#dso), [`working_capital`](#working_capital), [`accounts_payable`](#accounts_payable), [`inventory_turnover`](#inventory_turnover)

<a id="dso"></a>
#### Days Sales Outstanding — `dso`

Average days to collect payment after a sale — cash conversion speed.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/dso.yml) · [sql](dbt/analyses/metrics/finance/dso.sql)
- **Numerator:** Accounts Receivable × 365
- **Denominator:** Annual Revenue
- **Dimensions:** date, customer_segment
- **Data sources:** invoices, payments
- **Parents:** [`working_capital`](#working_capital)
- **Children:** [`accounts_receivable`](#accounts_receivable), [`ar_aging_90d`](#ar_aging_90d), [`billings`](#billings)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`dpo`](#dpo), [`cash_and_equivalents`](#cash_and_equivalents), [`accounts_receivable`](#accounts_receivable), [`ar_aging_90d`](#ar_aging_90d), [`bad_debt_rate`](#bad_debt_rate)

<a id="ebit"></a>
#### EBIT — `ebit`

Earnings before interest and taxes

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/ebit.yml) · [sql](dbt/analyses/metrics/finance/ebit.sql)
- **Numerator:** Gross Profit minus OpEx
- **Parents:** [`ebitda`](#ebitda), [`interest_coverage_ratio`](#interest_coverage_ratio)

<a id="ebitda_margin"></a>
#### EBITDA Margin — `ebitda_margin`

EBITDA as a % of revenue — core PE performance lens.

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/ebitda_margin.yml) · [sql](dbt/analyses/metrics/finance/ebitda_margin.sql)
- **Numerator:** EBITDA
- **Denominator:** Revenue
- **Dimensions:** company_id, fiscal_period, segment
- **Data sources:** ERP, Portfolio data room
- **Parents:** [`ebitda`](#ebitda), [`rule_of_40`](#rule_of_40)
- **Correlated:** [`gross_margin_pct`](#gross_margin_pct), [`budget_variance_pct`](#budget_variance_pct), [`debt_ebitda`](#debt_ebitda), [`ebitda`](#ebitda), [`gna_pct_revenue`](#gna_pct_revenue), [`net_income_margin`](#net_income_margin), [`rd_as_pct_revenue`](#rd_as_pct_revenue), [`revenue_per_employee`](#revenue_per_employee), [`sg_and_a`](#sg_and_a)

<a id="effective_tax_rate"></a>
#### Effective Tax Rate — `effective_tax_rate`

Actual income taxes paid divided by pre-tax income.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/effective_tax_rate.yml) · [sql](dbt/analyses/metrics/finance/effective_tax_rate.sql)
- **Numerator:** Income Tax Expense
- **Denominator:** Pre-Tax Income (EBT)
- **Dimensions:** company_id, fiscal_period, jurisdiction
- **Data sources:** ERP, Tax system
- **Parents:** [`net_income`](#net_income)
- **Correlated:** [`ebitda`](#ebitda), [`free_cash_flow`](#free_cash_flow)

<a id="ev_ebitda"></a>
#### EV/EBITDA — `ev_ebitda`

Enterprise value divided by EBITDA — primary valuation multiple

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/ev_ebitda.yml) · [sql](dbt/analyses/metrics/finance/ev_ebitda.sql)
- **Numerator:** Enterprise Value
- **Denominator:** EBITDA
- **Dimensions:** date
- **Data sources:** cap_table, income_statement
- **Parents:** [`enterprise_value`](#enterprise_value)
- **Formula inputs:** [`ebitda`](#ebitda), [`enterprise_value`](#enterprise_value)
- **Correlated:** [`debt_to_equity`](#debt_to_equity), [`leverage_ratio`](#leverage_ratio), [`enterprise_value`](#enterprise_value)

<a id="forecast_accuracy"></a>
#### Forecast Accuracy % — `forecast_accuracy`

Actual revenue versus forecast, expressed as an error percentage

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/forecast_accuracy.yml) · [sql](dbt/analyses/metrics/finance/forecast_accuracy.sql)
- **Numerator:** 1 − |Actual − Forecast|
- **Denominator:** Forecast
- **Dimensions:** date, segment
- **Data sources:** revenue_forecasts
- **Parents:** [`ebitda`](#ebitda)
- **Children:** [`annual_budget`](#annual_budget)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`budget_variance`](#budget_variance), [`revenue_vs_py`](#revenue_vs_py), [`revenue_ytd`](#revenue_ytd)

<a id="gna_pct_revenue"></a>
#### G&A % Revenue — `gna_pct_revenue`

General and administrative expenses as a share of revenue — overhead efficiency.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/gna_pct_revenue.yml) · [sql](dbt/analyses/metrics/finance/gna_pct_revenue.sql)
- **Numerator:** G&A Spend
- **Denominator:** Revenue
- **Dimensions:** company_id, fiscal_period, date
- **Data sources:** ERP
- **Parents:** [`opex`](#opex)
- **Children:** [`sg_and_a`](#sg_and_a)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`opex`](#opex)

<a id="gross_margin_pct"></a>
#### Gross Margin % — `gross_margin_pct`

Gross profit as a percentage of revenue

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/gross_margin_pct.yml) · [sql](dbt/analyses/metrics/finance/gross_margin_pct.sql)
- **Numerator:** Gross Profit
- **Denominator:** Revenue
- **Dimensions:** date, product_line, company_id, fiscal_period, segment, channel
- **Data sources:** orders, cogs
- **Parents:** [`ebitda`](#ebitda), [`cac_payback`](#cac_payback)
- **Children:** [`gross_profit`](#gross_profit), [`cogs`](#cogs), [`cost_per_unit`](#cost_per_unit)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`net_income_margin`](#net_income_margin), [`gross_profit`](#gross_profit), [`ops_efficiency_ratio`](#ops_efficiency_ratio), [`revenue`](#revenue), [`cogs`](#cogs), [`asp`](#asp), [`procurement_savings_rate`](#procurement_savings_rate)

<a id="gross_profit"></a>
#### Gross Profit — `gross_profit`

Revenue minus COGS — contribution before operating expenses.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/gross_profit.yml) · [sql](dbt/analyses/metrics/finance/gross_profit.sql)
- **Numerator:** Revenue
- **Denominator:** COGS
- **Dimensions:** date, product_line
- **Data sources:** orders, cogs
- **Parents:** [`ebitda`](#ebitda), [`gross_margin_pct`](#gross_margin_pct), [`gross_profit_per_employee`](#gross_profit_per_employee)
- **Children:** [`cogs`](#cogs)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`gross_margin_pct`](#gross_margin_pct), [`gross_profit_per_employee`](#gross_profit_per_employee)

<a id="gross_profit_per_employee"></a>
#### GP / Employee — `gross_profit_per_employee`

Gross profit divided by headcount — productivity indicator

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/gross_profit_per_employee.yml) · [sql](dbt/analyses/metrics/finance/gross_profit_per_employee.sql)
- **Numerator:** Gross Profit
- **Denominator:** Headcount
- **Dimensions:** date
- **Data sources:** income_statement, employees
- **Parents:** [`employee_lifetime_value`](#employee_lifetime_value)
- **Children:** [`gross_profit`](#gross_profit)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`revenue_per_employee`](#revenue_per_employee), [`workforce_productivity`](#workforce_productivity), [`gross_profit`](#gross_profit)

<a id="hr_cost_pct_revenue"></a>
#### HR Cost % of Revenue — `hr_cost_pct_revenue`

Total HR department cost as a fraction of company revenue

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/hr_cost_pct_revenue.yml) · [sql](dbt/analyses/metrics/finance/hr_cost_pct_revenue.sql)
- **Numerator:** HR total cost
- **Denominator:** Revenue
- **Dimensions:** date
- **Data sources:** hris, finance
- **Parents:** [`opex`](#opex)
- **Children:** [`total_comp_expense`](#total_comp_expense), [`cost_per_hire`](#cost_per_hire)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`cost_per_hire`](#cost_per_hire), [`opex`](#opex), [`support_cost_per_ticket`](#support_cost_per_ticket)

<a id="interest_coverage_ratio"></a>
#### Interest Coverage Ratio — `interest_coverage_ratio`

EBIT divided by interest expense — ability to service debt. <1.5x is distress signal.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/interest_coverage_ratio.yml) · [sql](dbt/analyses/metrics/finance/interest_coverage_ratio.sql)
- **Numerator:** EBIT
- **Denominator:** Interest Expense
- **Dimensions:** company_id, fiscal_period, date
- **Data sources:** Income statement, ERP
- **Parents:** [`roe`](#roe)
- **Children:** [`ebit`](#ebit), [`total_debt`](#total_debt)
- **Formula inputs:** [`ebitda`](#ebitda)
- **Correlated:** [`debt_ebitda`](#debt_ebitda), [`free_cash_flow`](#free_cash_flow), [`debt_to_equity`](#debt_to_equity), [`leverage_ratio`](#leverage_ratio), [`total_debt`](#total_debt)

<a id="inventory_turnover"></a>
#### Inventory Turnover — `inventory_turnover`

COGS divided by average inventory — how many times inventory was sold and replaced

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/inventory_turnover.yml) · [sql](dbt/analyses/metrics/finance/inventory_turnover.sql)
- **Numerator:** COGS
- **Denominator:** Average inventory value
- **Dimensions:** date, product, location
- **Data sources:** inventory, orders
- **Parents:** [`working_capital`](#working_capital)
- **Children:** [`inventory_value`](#inventory_value), [`inventory_items`](#inventory_items), [`cogs`](#cogs)
- **Correlated:** [`stockout_rate`](#stockout_rate), [`dpo`](#dpo), [`on_time_delivery_rate`](#on_time_delivery_rate), [`fill_rate`](#fill_rate), [`inventory_value`](#inventory_value), [`inventory_items`](#inventory_items), [`supplier_lead_time`](#supplier_lead_time), [`warehouse_utilization`](#warehouse_utilization), [`cogs`](#cogs)

<a id="leverage_ratio"></a>
#### Leverage Ratio — `leverage_ratio`

Net debt relative to EBITDA — key PE portfolio health metric

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/leverage_ratio.yml) · [sql](dbt/analyses/metrics/finance/leverage_ratio.sql)
- **Numerator:** Net Debt
- **Denominator:** EBITDA
- **Dimensions:** date
- **Data sources:** balance_sheet, income_statement
- **Parents:** [`roe`](#roe)
- **Children:** [`net_debt`](#net_debt), [`debt_ebitda`](#debt_ebitda)
- **Formula inputs:** [`ebitda`](#ebitda)
- **Correlated:** [`debt_to_equity`](#debt_to_equity), [`interest_coverage_ratio`](#interest_coverage_ratio), [`ev_ebitda`](#ev_ebitda), [`total_debt`](#total_debt)

<a id="license_revenue"></a>
#### License Revenue — `license_revenue`

Revenue from perpetual license sales

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/license_revenue.yml) · [sql](dbt/analyses/metrics/finance/license_revenue.sql)
- **Numerator:** Revenue from perpetual licenses
- **Dimensions:** date, product
- **Data sources:** orders
- **Parents:** [`revenue`](#revenue)
- **Correlated:** [`services_revenue`](#services_revenue), [`arr`](#arr)

<a id="ltv_cac"></a>
#### LTV : CAC — `ltv_cac`

Ratio of customer lifetime value to acquisition cost — PE efficiency lens.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/ltv_cac.yml) · [sql](dbt/analyses/metrics/finance/ltv_cac.sql)
- **Numerator:** Customer LTV
- **Denominator:** CAC
- **Dimensions:** date, channel
- **Data sources:** orders, customers, general_ledger
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Children:** [`cac`](#cac), [`cac_payback`](#cac_payback)
- **Formula inputs:** [`clv`](#clv)
- **Correlated:** [`cac_payback`](#cac_payback), [`magic_number`](#magic_number), [`cac`](#cac), [`churn_rate`](#churn_rate), [`customer_ltv`](#customer_ltv), [`nrr`](#nrr), [`roas`](#roas)

<a id="market_share"></a>
#### Market Share — `market_share`

Company revenue as a percentage of total addressable market

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/market_share.yml) · [sql](dbt/analyses/metrics/finance/market_share.sql)
- **Numerator:** Company revenue
- **Denominator:** Total addressable market
- **Dimensions:** date, region
- **Data sources:** market_analysis
- **Parents:** [`revenue_growth_rate`](#revenue_growth_rate)
- **Children:** [`market_penetration_rate`](#market_penetration_rate)
- **Correlated:** [`revenue_growth_rate`](#revenue_growth_rate), [`tam`](#tam), [`revenue`](#revenue), [`sam`](#sam)

<a id="net_debt"></a>
#### Net Debt — `net_debt`

Total debt minus cash and equivalents

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/net_debt.yml) · [sql](dbt/analyses/metrics/finance/net_debt.sql)
- **Numerator:** Total Debt − Cash
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`enterprise_value`](#enterprise_value), [`leverage_ratio`](#leverage_ratio)
- **Children:** [`total_debt`](#total_debt), [`cash_and_equivalents`](#cash_and_equivalents)
- **Correlated:** [`current_ratio`](#current_ratio), [`runway_months`](#runway_months), [`shareholder_equity`](#shareholder_equity)

<a id="net_income"></a>
#### Net Income — `net_income`

Bottom-line profit after all expenses and taxes.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/net_income.yml) · [sql](dbt/analyses/metrics/finance/net_income.sql)
- **Numerator:** Revenue - All Expenses - Taxes
- **Dimensions:** company_id, fiscal_period
- **Data sources:** Income statement, ERP
- **Parents:** [`roe`](#roe), [`net_income_margin`](#net_income_margin), [`operating_cash_flow`](#operating_cash_flow), [`roa`](#roa), [`roic`](#roic)
- **Children:** [`effective_tax_rate`](#effective_tax_rate)
- **Formula inputs:** [`ebitda`](#ebitda)
- **Correlated:** [`free_cash_flow`](#free_cash_flow), [`ebitda`](#ebitda)

<a id="net_income_margin"></a>
#### Net Income Margin — `net_income_margin`

Net income as a % of revenue — bottom-line profitability.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/net_income_margin.yml) · [sql](dbt/analyses/metrics/finance/net_income_margin.sql)
- **Numerator:** Net Income
- **Denominator:** Revenue
- **Dimensions:** company_id, fiscal_period, date
- **Data sources:** Income statement
- **Parents:** [`roe`](#roe)
- **Children:** [`net_income`](#net_income)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`gross_margin_pct`](#gross_margin_pct)

<a id="operating_cash_flow"></a>
#### Operating Cash Flow — `operating_cash_flow`

Cash generated from core business operations

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/operating_cash_flow.yml) · [sql](dbt/analyses/metrics/finance/operating_cash_flow.sql)
- **Numerator:** Net income + D&A − working capital changes
- **Dimensions:** date
- **Data sources:** cash_flow_statement
- **Parents:** [`free_cash_flow`](#free_cash_flow)
- **Children:** [`net_income`](#net_income), [`da`](#da), [`deferred_revenue`](#deferred_revenue)
- **Correlated:** [`ebitda`](#ebitda), [`free_cash_flow`](#free_cash_flow)

<a id="opex"></a>
#### OpEx — `opex`

Total operating expenses excluding COGS in a period.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/opex.yml) · [sql](dbt/analyses/metrics/finance/opex.sql)
- **Numerator:** Total operating expenses
- **Dimensions:** date, department
- **Data sources:** general_ledger
- **Parents:** [`ebitda`](#ebitda), [`burn_rate`](#burn_rate), [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Children:** [`sg_and_a`](#sg_and_a), [`total_comp_expense`](#total_comp_expense), [`gna_pct_revenue`](#gna_pct_revenue), [`headcount_cost`](#headcount_cost), [`hr_cost_pct_revenue`](#hr_cost_pct_revenue), [`rd_as_pct_revenue`](#rd_as_pct_revenue), [`rd_expense`](#rd_expense)
- **Correlated:** [`gna_pct_revenue`](#gna_pct_revenue), [`rd_as_pct_revenue`](#rd_as_pct_revenue), [`annual_budget`](#annual_budget), [`budget_variance`](#budget_variance), [`budget_variance_pct`](#budget_variance_pct), [`headcount_fte`](#headcount_fte), [`headcount_vs_budget`](#headcount_vs_budget), [`hr_cost_pct_revenue`](#hr_cost_pct_revenue)

<a id="partner_revenue"></a>
#### Partner Revenue — `partner_revenue`

Revenue sourced or influenced by channel partners

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/partner_revenue.yml) · [sql](dbt/analyses/metrics/finance/partner_revenue.sql)
- **Numerator:** Revenue sourced via partners
- **Dimensions:** date, partner
- **Data sources:** orders, partner_registry
- **Parents:** [`revenue`](#revenue), [`partner_revenue_pct`](#partner_revenue_pct)
- **Correlated:** [`partner_revenue_pct`](#partner_revenue_pct), [`new_arr`](#new_arr)

<a id="partner_revenue_pct"></a>
#### Partner Revenue % — `partner_revenue_pct`

Partner-sourced revenue as a share of total revenue

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/partner_revenue_pct.yml) · [sql](dbt/analyses/metrics/finance/partner_revenue_pct.sql)
- **Numerator:** Partner revenue
- **Denominator:** Total revenue
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue`](#revenue)
- **Children:** [`partner_revenue`](#partner_revenue)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`partner_revenue`](#partner_revenue), [`revenue`](#revenue)

<a id="quick_ratio"></a>
#### Quick Ratio — `quick_ratio`

(Cash + Receivables) / Current Liabilities — excludes inventory from liquidity test.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/quick_ratio.yml) · [sql](dbt/analyses/metrics/finance/quick_ratio.sql)
- **Numerator:** Cash + Accounts Receivable
- **Denominator:** Current Liabilities
- **Dimensions:** company_id, quarter
- **Data sources:** Balance sheet
- **Parents:** [`working_capital`](#working_capital)
- **Correlated:** [`current_ratio`](#current_ratio), [`working_capital`](#working_capital)

<a id="rd_as_pct_revenue"></a>
#### R&D % of Revenue — `rd_as_pct_revenue`

R&D spend as a share of total revenue — tech investment intensity.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/rd_as_pct_revenue.yml) · [sql](dbt/analyses/metrics/finance/rd_as_pct_revenue.sql)
- **Numerator:** R&D Expense
- **Denominator:** Revenue
- **Dimensions:** company_id, fiscal_period, date
- **Data sources:** ERP
- **Parents:** [`opex`](#opex)
- **Children:** [`rd_expense`](#rd_expense), [`rd_headcount_pct`](#rd_headcount_pct)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`rd_expense`](#rd_expense), [`rd_headcount_pct`](#rd_headcount_pct), [`opex`](#opex)

<a id="rd_expense"></a>
#### R&D Expense — `rd_expense`

Research and development spend in the period.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/rd_expense.yml) · [sql](dbt/analyses/metrics/finance/rd_expense.sql)
- **Numerator:** SUM(opex_amount WHERE gl_category = 'R&D')
- **Dimensions:** company_id, department, fiscal_period
- **Data sources:** ERP, General Ledger
- **Parents:** [`opex`](#opex), [`rd_as_pct_revenue`](#rd_as_pct_revenue)
- **Correlated:** [`rd_as_pct_revenue`](#rd_as_pct_revenue), [`capex`](#capex)

<a id="rev_concentration_top10"></a>
#### Top 10 Customer Rev % — `rev_concentration_top10`

Percentage of total revenue from the top 10 customers

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/rev_concentration_top10.yml) · [sql](dbt/analyses/metrics/finance/rev_concentration_top10.sql)
- **Numerator:** Revenue from top 10 customers
- **Denominator:** Total revenue
- **Dimensions:** date
- **Data sources:** orders, customers
- **Parents:** [`customer_concentration_risk`](#customer_concentration_risk)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`customer_concentration_risk`](#customer_concentration_risk), [`nrr`](#nrr)

<a id="rev_from_existing"></a>
#### Existing Customer Revenue — `rev_from_existing`

Revenue from customers acquired prior to the current period

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/rev_from_existing.yml) · [sql](dbt/analyses/metrics/finance/rev_from_existing.sql)
- **Numerator:** Revenue from existing customers
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue`](#revenue)
- **Correlated:** [`nrr`](#nrr), [`expansion_arr`](#expansion_arr)

<a id="rev_from_new_customers"></a>
#### New Customer Revenue — `rev_from_new_customers`

Revenue from customers acquired in the period

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/rev_from_new_customers.yml) · [sql](dbt/analyses/metrics/finance/rev_from_new_customers.sql)
- **Numerator:** Revenue from new customer acquisitions
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue`](#revenue)
- **Correlated:** [`cac`](#cac), [`new_arr`](#new_arr)

<a id="revenue_growth_rate"></a>
#### Revenue Growth Rate — `revenue_growth_rate`

YoY or QoQ revenue growth percentage.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/revenue_growth_rate.yml) · [sql](dbt/analyses/metrics/finance/revenue_growth_rate.sql)
- **Numerator:** Revenue(t) − Revenue(t−1)
- **Denominator:** Revenue(t−1)
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`rule_of_40`](#rule_of_40)
- **Children:** [`market_share`](#market_share), [`revenue_vs_py`](#revenue_vs_py)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`arr_growth_rate`](#arr_growth_rate), [`revenue_vs_py`](#revenue_vs_py), [`arr`](#arr), [`market_penetration_rate`](#market_penetration_rate), [`market_share`](#market_share), [`monthly_new_customers`](#monthly_new_customers), [`revenue`](#revenue)

<a id="revenue_per_account"></a>
#### Revenue / Account — `revenue_per_account`

Average monthly revenue per active account

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/revenue_per_account.yml) · [sql](dbt/analyses/metrics/finance/revenue_per_account.sql)
- **Numerator:** Revenue
- **Denominator:** Active accounts
- **Dimensions:** date, segment
- **Data sources:** orders, customers
- **Parents:** [`arpu`](#arpu)
- **Correlated:** [`arpu`](#arpu), [`acv`](#acv)

<a id="revenue_per_employee"></a>
#### Revenue per Employee — `revenue_per_employee`

Total revenue divided by headcount — operating leverage metric.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/revenue_per_employee.yml) · [sql](dbt/analyses/metrics/finance/revenue_per_employee.sql)
- **Numerator:** Revenue
- **Denominator:** Full-Time Equivalent Headcount
- **Dimensions:** company_id, fiscal_period, department
- **Data sources:** ERP, HRIS
- **Parents:** [`ebitda`](#ebitda), [`employee_lifetime_value`](#employee_lifetime_value)
- **Children:** [`headcount_fte`](#headcount_fte), [`arr_per_rep`](#arr_per_rep), [`employees_per_1m_arr`](#employees_per_1m_arr)
- **Formula inputs:** [`headcount`](#headcount), [`revenue`](#revenue)
- **Correlated:** [`ebitda_margin`](#ebitda_margin), [`employees_per_1m_arr`](#employees_per_1m_arr), [`gross_profit_per_employee`](#gross_profit_per_employee), [`headcount_cost`](#headcount_cost), [`workforce_productivity`](#workforce_productivity)

<a id="revenue_vs_py"></a>
#### Revenue vs PY — `revenue_vs_py`

Current year revenue vs prior year — year-over-year growth

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/revenue_vs_py.yml) · [sql](dbt/analyses/metrics/finance/revenue_vs_py.sql)
- **Numerator:** Current revenue − Prior year revenue
- **Denominator:** Prior year revenue
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_growth_rate`](#revenue_growth_rate)
- **Children:** [`prior_year_revenue`](#prior_year_revenue)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`revenue_growth_rate`](#revenue_growth_rate), [`forecast_accuracy`](#forecast_accuracy), [`prior_year_revenue`](#prior_year_revenue), [`revenue_ytd`](#revenue_ytd), [`revenue`](#revenue)

<a id="revenue_ytd"></a>
#### Revenue YTD — `revenue_ytd`

Cumulative revenue from the start of the fiscal year to current date

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/revenue_ytd.yml) · [sql](dbt/analyses/metrics/finance/revenue_ytd.sql)
- **Numerator:** Revenue from fiscal year start to date
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue`](#revenue)
- **Children:** [`q1_revenue`](#q1_revenue), [`q2_revenue`](#q2_revenue), [`q3_revenue`](#q3_revenue), [`q4_revenue`](#q4_revenue)
- **Formula inputs:** [`revenue`](#revenue)
- **Correlated:** [`revenue_vs_py`](#revenue_vs_py), [`forecast_accuracy`](#forecast_accuracy)

<a id="roa"></a>
#### ROA — `roa`

Net income as a percentage of total assets

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/roa.yml) · [sql](dbt/analyses/metrics/finance/roa.sql)
- **Numerator:** Net Income
- **Denominator:** Total Assets
- **Dimensions:** date, company_id, fiscal_period
- **Data sources:** income_statement, balance_sheet
- **Parents:** [`roe`](#roe)
- **Children:** [`net_income`](#net_income), [`total_assets`](#total_assets)
- **Correlated:** [`roe`](#roe), [`roic`](#roic), [`debt_ebitda`](#debt_ebitda)

<a id="roic"></a>
#### ROIC — `roic`

NOPAT divided by invested capital

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/roic.yml) · [sql](dbt/analyses/metrics/finance/roic.sql)
- **Numerator:** NOPAT
- **Denominator:** Invested Capital
- **Dimensions:** date
- **Data sources:** income_statement, balance_sheet
- **Parents:** [`enterprise_value`](#enterprise_value)
- **Children:** [`net_income`](#net_income), [`total_assets`](#total_assets), [`total_debt`](#total_debt)
- **Correlated:** [`roe`](#roe), [`roa`](#roa)

<a id="runway_months"></a>
#### Runway (Months) — `runway_months`

How many months of runway at current burn rate — survival horizon metric.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/runway_months.yml) · [sql](dbt/analyses/metrics/finance/runway_months.sql)
- **Numerator:** Cash on Hand
- **Denominator:** Monthly Burn Rate
- **Dimensions:** company_id, as_of_date
- **Data sources:** Bank statements, Finance
- **Parents:** [`free_cash_flow`](#free_cash_flow)
- **Children:** [`burn_rate`](#burn_rate)
- **Correlated:** [`burn_rate`](#burn_rate), [`free_cash_flow`](#free_cash_flow), [`cash_and_equivalents`](#cash_and_equivalents), [`net_debt`](#net_debt)

<a id="services_revenue"></a>
#### Services Revenue — `services_revenue`

Revenue from professional services engagements

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/services_revenue.yml) · [sql](dbt/analyses/metrics/finance/services_revenue.sql)
- **Numerator:** Revenue from professional services
- **Dimensions:** date, client
- **Data sources:** orders
- **Parents:** [`revenue`](#revenue)
- **Correlated:** [`license_revenue`](#license_revenue), [`implementation_revenue`](#implementation_revenue)

<a id="sg_and_a"></a>
#### SG&A — `sg_and_a`

Sales, general and administrative expenses in the period.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/sg_and_a.yml) · [sql](dbt/analyses/metrics/finance/sg_and_a.sql)
- **Numerator:** SUM(opex_amount WHERE gl_category = 'SG&A')
- **Dimensions:** company_id, department, fiscal_period
- **Data sources:** ERP
- **Parents:** [`opex`](#opex), [`gna_pct_revenue`](#gna_pct_revenue)
- **Children:** [`sales_spend`](#sales_spend)
- **Correlated:** [`ebitda_margin`](#ebitda_margin)

<a id="subscription_revenue"></a>
#### Subscription Revenue — `subscription_revenue`

Revenue from recurring subscription contracts

- **Domain:** Finance · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/finance/subscription_revenue.yml) · [sql](dbt/analyses/metrics/finance/subscription_revenue.sql)
- **Numerator:** Revenue from subscription contracts
- **Dimensions:** date, plan
- **Data sources:** subscriptions, orders
- **Parents:** [`revenue`](#revenue)
- **Children:** [`arr`](#arr), [`mrr`](#mrr)
- **Correlated:** [`arr`](#arr), [`nrr`](#nrr)

<a id="workforce_productivity"></a>
#### Workforce Productivity — `workforce_productivity`

Output or revenue generated per labor hour worked

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/workforce_productivity.yml) · [sql](dbt/analyses/metrics/finance/workforce_productivity.sql)
- **Numerator:** Revenue
- **Denominator:** Labor hours worked
- **Dimensions:** date, department
- **Data sources:** hris, orders
- **Parents:** [`employee_lifetime_value`](#employee_lifetime_value)
- **Children:** [`absenteeism_rate`](#absenteeism_rate), [`overtime_hours`](#overtime_hours), [`safety_incident_rate`](#safety_incident_rate)
- **Formula inputs:** [`headcount`](#headcount), [`revenue`](#revenue)
- **Correlated:** [`revenue_per_employee`](#revenue_per_employee), [`gross_profit_per_employee`](#gross_profit_per_employee), [`overtime_hours`](#overtime_hours)

<a id="working_capital"></a>
#### Working Capital — `working_capital`

Current assets minus current liabilities — short-term liquidity indicator.

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/working_capital.yml) · [sql](dbt/analyses/metrics/finance/working_capital.sql)
- **Numerator:** Current Assets - Current Liabilities
- **Dimensions:** company_id, quarter
- **Data sources:** Balance sheet
- **Parents:** [`free_cash_flow`](#free_cash_flow)
- **Children:** [`current_ratio`](#current_ratio), [`accounts_payable`](#accounts_payable), [`accounts_receivable`](#accounts_receivable), [`cash_and_equivalents`](#cash_and_equivalents), [`dpo`](#dpo), [`dso`](#dso), [`inventory_turnover`](#inventory_turnover), [`quick_ratio`](#quick_ratio)
- **Correlated:** [`free_cash_flow`](#free_cash_flow), [`accounts_payable`](#accounts_payable), [`ar_aging_90d`](#ar_aging_90d), [`current_ratio`](#current_ratio), [`dpo`](#dpo), [`quick_ratio`](#quick_ratio)

### KPI · People & HR (21)

<a id="absenteeism_rate"></a>
#### Absenteeism Rate — `absenteeism_rate`

Percentage of scheduled workdays lost to unplanned absences

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/absenteeism_rate.yml) · [sql](dbt/analyses/metrics/hr/absenteeism_rate.sql)
- **Numerator:** Unplanned absence days
- **Denominator:** Available working days
- **Dimensions:** date, department
- **Data sources:** hris, time_records
- **Parents:** [`workforce_productivity`](#workforce_productivity)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`employee_engagement_score`](#employee_engagement_score), [`turnover_rate`](#turnover_rate), [`overtime_hours`](#overtime_hours), [`remote_work_rate`](#remote_work_rate)

<a id="avg_tenure"></a>
#### Avg Tenure (yrs) — `avg_tenure`

Average years of service among current employees

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/avg_tenure.yml) · [sql](dbt/analyses/metrics/hr/avg_tenure.sql)
- **Numerator:** Average years of service
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`employee_lifetime_value`](#employee_lifetime_value)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`employee_engagement_score`](#employee_engagement_score)

<a id="compensation_ratio"></a>
#### Compensation Ratio — `compensation_ratio`

Employee pay relative to market midpoint for their role — pay equity signal.

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/compensation_ratio.yml) · [sql](dbt/analyses/metrics/hr/compensation_ratio.sql)
- **Numerator:** Employee Salary
- **Denominator:** Market Midpoint for Role
- **Dimensions:** job_level, department, location, period
- **Data sources:** HRIS, Market compensation data
- **Parents:** [`voluntary_turnover`](#voluntary_turnover)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`headcount_cost`](#headcount_cost)

<a id="cost_per_hire"></a>
#### Cost Per Hire — `cost_per_hire`

Total recruiting costs divided by hires made

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/cost_per_hire.yml) · [sql](dbt/analyses/metrics/hr/cost_per_hire.sql)
- **Numerator:** Total recruiting costs
- **Denominator:** Hires made
- **Dimensions:** date, department
- **Data sources:** ats, hris, finance
- **Parents:** [`hr_cost_pct_revenue`](#hr_cost_pct_revenue)
- **Children:** [`total_comp_expense`](#total_comp_expense), [`new_hires`](#new_hires)
- **Correlated:** [`time_to_fill`](#time_to_fill), [`hr_cost_pct_revenue`](#hr_cost_pct_revenue), [`new_hires`](#new_hires), [`total_comp_expense`](#total_comp_expense)

<a id="diversity_hire_rate"></a>
#### Diversity Hire % — `diversity_hire_rate`

Percentage of hires from underrepresented groups

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/diversity_hire_rate.yml) · [sql](dbt/analyses/metrics/hr/diversity_hire_rate.sql)
- **Numerator:** Hires from underrepresented groups
- **Denominator:** Total hires
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`headcount`](#headcount)
- **Correlated:** [`gender_pay_gap`](#gender_pay_gap), [`employee_engagement_score`](#employee_engagement_score)

<a id="employee_engagement_score"></a>
#### Employee Engagement Score — `employee_engagement_score`

Composite score from engagement surveys (eNPS, pulse).

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/employee_engagement_score.yml) · [sql](dbt/analyses/metrics/hr/employee_engagement_score.sql)
- **Numerator:** Weighted average of survey responses
- **Dimensions:** department, job_level, location, survey_cycle, date
- **Data sources:** Survey platform (Lattice / Culture Amp)
- **Parents:** [`voluntary_turnover`](#voluntary_turnover)
- **Children:** [`manager_effectiveness_score`](#manager_effectiveness_score), [`training_hours_per_employee`](#training_hours_per_employee), [`benefits_utilization`](#benefits_utilization), [`enps`](#enps), [`remote_work_rate`](#remote_work_rate)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`headcount_cost`](#headcount_cost), [`employee_lifetime_value`](#employee_lifetime_value), [`manager_effectiveness_score`](#manager_effectiveness_score), [`school_climate_score`](#school_climate_score), [`training_hours_per_employee`](#training_hours_per_employee), [`enps`](#enps), [`turnover_rate`](#turnover_rate), [`absenteeism_rate`](#absenteeism_rate), [`avg_tenure`](#avg_tenure), [`benefits_utilization`](#benefits_utilization), [`diversity_hire_rate`](#diversity_hire_rate), [`gender_pay_gap`](#gender_pay_gap), [`regrettable_attrition`](#regrettable_attrition), [`remote_work_rate`](#remote_work_rate), [`survey_response_rate`](#survey_response_rate)

<a id="enps"></a>
#### eNPS — `enps`

Employee net promoter score — likelihood to recommend the company as a workplace

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/enps.yml) · [sql](dbt/analyses/metrics/hr/enps.sql)
- **Numerator:** % Promoters − % Detractors
- **Dimensions:** date, department
- **Data sources:** surveys
- **Parents:** [`employee_engagement_score`](#employee_engagement_score)
- **Correlated:** [`employee_engagement_score`](#employee_engagement_score), [`nps`](#nps)

<a id="gender_pay_gap"></a>
#### Gender Pay Gap — `gender_pay_gap`

Median pay of female employees as a percentage of male employee median

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/gender_pay_gap.yml) · [sql](dbt/analyses/metrics/hr/gender_pay_gap.sql)
- **Numerator:** Median male pay − Median female pay
- **Denominator:** Median male pay
- **Dimensions:** date, department, level
- **Data sources:** hris, payroll
- **Parents:** [`voluntary_turnover`](#voluntary_turnover)
- **Children:** [`total_comp_expense`](#total_comp_expense)
- **Correlated:** [`diversity_hire_rate`](#diversity_hire_rate), [`employee_engagement_score`](#employee_engagement_score)

<a id="headcount_cost"></a>
#### Headcount Cost — `headcount_cost`

Total fully-loaded compensation cost including salary, benefits, and employer taxes.

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/headcount_cost.yml) · [sql](dbt/analyses/metrics/hr/headcount_cost.sql)
- **Numerator:** SUM(total_comp + benefits + employer_taxes)
- **Dimensions:** department, location, job_level, period
- **Data sources:** HRIS, Payroll system
- **Parents:** [`opex`](#opex), [`employee_lifetime_value`](#employee_lifetime_value), [`staff_student_cost_ratio`](#staff_student_cost_ratio)
- **Correlated:** [`headcount_fte`](#headcount_fte), [`revenue_per_employee`](#revenue_per_employee), [`compensation_ratio`](#compensation_ratio), [`employee_engagement_score`](#employee_engagement_score), [`safety_incident_rate`](#safety_incident_rate)

<a id="headcount_vs_budget"></a>
#### HC vs Budget — `headcount_vs_budget`

Actual headcount relative to approved headcount budget

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/headcount_vs_budget.yml) · [sql](dbt/analyses/metrics/hr/headcount_vs_budget.sql)
- **Numerator:** Actual headcount − Budget headcount
- **Dimensions:** date, department
- **Data sources:** hris, finance
- **Parents:** [`headcount`](#headcount)
- **Children:** [`annual_budget`](#annual_budget), [`time_to_fill`](#time_to_fill)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`budget_variance`](#budget_variance), [`opex`](#opex), [`headcount`](#headcount), [`open_requisitions`](#open_requisitions), [`span_of_control`](#span_of_control)

<a id="internal_promotion_rate"></a>
#### Internal Promotion Rate — `internal_promotion_rate`

% of open roles filled by internal candidates — talent pipeline health.

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/internal_promotion_rate.yml) · [sql](dbt/analyses/metrics/hr/internal_promotion_rate.sql)
- **Numerator:** Internal Hires
- **Denominator:** Total Hires
- **Dimensions:** department, job_level, period
- **Data sources:** HRIS, ATS
- **Parents:** [`voluntary_turnover`](#voluntary_turnover)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`time_to_fill`](#time_to_fill), [`span_of_control`](#span_of_control), [`training_hours_per_employee`](#training_hours_per_employee)

<a id="interview_to_offer_rate"></a>
#### Interview-to-Offer % — `interview_to_offer_rate`

Percentage of final-round interviews that resulted in an offer

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/interview_to_offer_rate.yml) · [sql](dbt/analyses/metrics/hr/interview_to_offer_rate.sql)
- **Numerator:** Offers extended
- **Denominator:** Final round interviews
- **Dimensions:** date, department
- **Data sources:** ats
- **Parents:** [`time_to_hire`](#time_to_hire)
- **Correlated:** [`offer_acceptance_rate`](#offer_acceptance_rate), [`time_to_hire`](#time_to_hire)

<a id="manager_effectiveness_score"></a>
#### Manager Effectiveness — `manager_effectiveness_score`

Upward feedback score measuring managerial quality from direct reports.

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/manager_effectiveness_score.yml) · [sql](dbt/analyses/metrics/hr/manager_effectiveness_score.sql)
- **Numerator:** AVG(upward feedback scores)
- **Dimensions:** manager_id, department, survey_cycle
- **Data sources:** Performance management system
- **Parents:** [`employee_engagement_score`](#employee_engagement_score)
- **Children:** [`span_of_control`](#span_of_control)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`employee_engagement_score`](#employee_engagement_score)

<a id="offer_acceptance_rate"></a>
#### Offer Acceptance Rate — `offer_acceptance_rate`

% of job offers accepted by candidates.

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/offer_acceptance_rate.yml) · [sql](dbt/analyses/metrics/hr/offer_acceptance_rate.sql)
- **Numerator:** Accepted offers
- **Denominator:** Offers extended
- **Dimensions:** date, department
- **Data sources:** ats
- **Parents:** [`time_to_fill`](#time_to_fill)
- **Children:** [`recruiting_pipeline`](#recruiting_pipeline), [`new_hires`](#new_hires)
- **Correlated:** [`time_to_hire`](#time_to_hire), [`interview_to_offer_rate`](#interview_to_offer_rate), [`recruiting_pipeline`](#recruiting_pipeline)

<a id="rd_headcount_pct"></a>
#### R&D % of Headcount — `rd_headcount_pct`

Engineering and product staff as a share of total headcount

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/rd_headcount_pct.yml) · [sql](dbt/analyses/metrics/hr/rd_headcount_pct.sql)
- **Numerator:** R&D headcount
- **Denominator:** Total headcount
- **Dimensions:** date
- **Data sources:** hris
- **Parents:** [`rd_as_pct_revenue`](#rd_as_pct_revenue)
- **Children:** [`rd_headcount`](#rd_headcount)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`rd_as_pct_revenue`](#rd_as_pct_revenue), [`deployment_frequency`](#deployment_frequency), [`headcount`](#headcount), [`rd_headcount`](#rd_headcount)

<a id="regrettable_attrition"></a>
#### Regrettable Attrition % — `regrettable_attrition`

Percentage of turnover classified as regrettable by management

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/regrettable_attrition.yml) · [sql](dbt/analyses/metrics/hr/regrettable_attrition.sql)
- **Numerator:** Regrettable departures
- **Denominator:** Total separations
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`turnover_rate`](#turnover_rate)
- **Children:** [`separations`](#separations)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`employee_engagement_score`](#employee_engagement_score), [`separations`](#separations), [`turnover_rate`](#turnover_rate)

<a id="span_of_control"></a>
#### Span of Control — `span_of_control`

Average number of direct reports per manager

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/span_of_control.yml) · [sql](dbt/analyses/metrics/hr/span_of_control.sql)
- **Numerator:** Direct reports
- **Denominator:** Manager count
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`manager_effectiveness_score`](#manager_effectiveness_score)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`headcount_vs_budget`](#headcount_vs_budget), [`internal_promotion_rate`](#internal_promotion_rate)

<a id="time_to_fill"></a>
#### Time to Fill — `time_to_fill`

Average days from job posting to offer accepted.

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/time_to_fill.yml) · [sql](dbt/analyses/metrics/hr/time_to_fill.sql)
- **Numerator:** SUM(days from open to offer accepted)
- **Denominator:** COUNT(filled roles)
- **Dimensions:** department, job_level, location, period
- **Data sources:** ATS (Greenhouse / Lever)
- **Parents:** [`headcount_vs_budget`](#headcount_vs_budget)
- **Children:** [`offer_acceptance_rate`](#offer_acceptance_rate), [`time_to_hire`](#time_to_hire)
- **Correlated:** [`headcount_fte`](#headcount_fte), [`cac`](#cac), [`cost_per_hire`](#cost_per_hire), [`internal_promotion_rate`](#internal_promotion_rate), [`new_hires`](#new_hires), [`open_requisitions`](#open_requisitions), [`time_to_hire`](#time_to_hire)

<a id="time_to_hire"></a>
#### Time to Hire — `time_to_hire`

Average days from application to accepted offer

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/time_to_hire.yml) · [sql](dbt/analyses/metrics/hr/time_to_hire.sql)
- **Numerator:** Days from application to offer acceptance
- **Dimensions:** date, department
- **Data sources:** ats
- **Parents:** [`time_to_fill`](#time_to_fill)
- **Children:** [`open_requisitions`](#open_requisitions), [`recruiting_pipeline`](#recruiting_pipeline), [`interview_to_offer_rate`](#interview_to_offer_rate)
- **Correlated:** [`time_to_fill`](#time_to_fill), [`offer_acceptance_rate`](#offer_acceptance_rate), [`interview_to_offer_rate`](#interview_to_offer_rate), [`recruiting_pipeline`](#recruiting_pipeline)

<a id="training_hours_per_employee"></a>
#### Training Hours / Employee — `training_hours_per_employee`

Average learning and development hours per employee per period.

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/training_hours_per_employee.yml) · [sql](dbt/analyses/metrics/hr/training_hours_per_employee.sql)
- **Numerator:** Total Training Hours
- **Denominator:** Average FTE Headcount
- **Dimensions:** department, training_type, period
- **Data sources:** LMS (Learning Management System)
- **Parents:** [`employee_engagement_score`](#employee_engagement_score)
- **Correlated:** [`employee_engagement_score`](#employee_engagement_score), [`internal_promotion_rate`](#internal_promotion_rate)

<a id="voluntary_turnover"></a>
#### Voluntary Turnover — `voluntary_turnover`

Turnover from employee-initiated separations only

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/voluntary_turnover.yml) · [sql](dbt/analyses/metrics/hr/voluntary_turnover.sql)
- **Numerator:** Voluntary departures
- **Denominator:** Average headcount
- **Dimensions:** date, department, job_level, location, period
- **Data sources:** hris
- **Parents:** [`turnover_rate`](#turnover_rate)
- **Children:** [`separations`](#separations), [`employee_engagement_score`](#employee_engagement_score), [`compensation_ratio`](#compensation_ratio), [`gender_pay_gap`](#gender_pay_gap), [`internal_promotion_rate`](#internal_promotion_rate)
- **Correlated:** [`regrettable_attrition`](#regrettable_attrition), [`employee_engagement_score`](#employee_engagement_score), [`avg_tenure`](#avg_tenure), [`separations`](#separations), [`turnover_rate`](#turnover_rate), [`headcount_fte`](#headcount_fte), [`compensation_ratio`](#compensation_ratio), [`employee_lifetime_value`](#employee_lifetime_value), [`internal_promotion_rate`](#internal_promotion_rate), [`manager_effectiveness_score`](#manager_effectiveness_score), [`safety_incident_rate`](#safety_incident_rate), [`teacher_retention_rate`](#teacher_retention_rate)

### KPI · Marketing (32)

<a id="app_store_rating"></a>
#### App Store Rating — `app_store_rating`

Average rating on iOS App Store and Google Play

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/app_store_rating.yml) · [sql](dbt/analyses/metrics/marketing/app_store_rating.sql)
- **Numerator:** Average app store rating
- **Dimensions:** date, platform
- **Data sources:** app_stores
- **Parents:** [`nps`](#nps)
- **Correlated:** [`nps`](#nps), [`csat`](#csat), [`review_rating`](#review_rating)

<a id="avg_session_duration"></a>
#### Avg Session Duration — `avg_session_duration`

Average time users spend per session in the product.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/avg_session_duration.yml) · [sql](dbt/analyses/metrics/marketing/avg_session_duration.sql)
- **Numerator:** SUM(session_duration_seconds)
- **Denominator:** COUNT(sessions)
- **Dimensions:** platform, product_area, user_segment, period, date
- **Data sources:** Product analytics
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Correlated:** [`feature_adoption_rate`](#feature_adoption_rate), [`dau`](#dau), [`bounce_rate`](#bounce_rate), [`dau_mau_ratio`](#dau_mau_ratio), [`sessions_per_user`](#sessions_per_user), [`website_sessions`](#website_sessions)

<a id="bounce_rate"></a>
#### Bounce Rate — `bounce_rate`

% of sessions where users leave after viewing only one page.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/bounce_rate.yml) · [sql](dbt/analyses/metrics/marketing/bounce_rate.sql)
- **Numerator:** Single-Page Sessions
- **Denominator:** Total Sessions
- **Dimensions:** landing_page, channel, device, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`web_conversion_rate`](#web_conversion_rate)
- **Children:** [`website_sessions`](#website_sessions)
- **Correlated:** [`web_conversion_rate`](#web_conversion_rate), [`avg_session_duration`](#avg_session_duration), [`session_to_lead_rate`](#session_to_lead_rate), [`website_sessions`](#website_sessions)

<a id="cost_per_event_attendee"></a>
#### Cost / Attendee — `cost_per_event_attendee`

Total event spend divided by number of attendees

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/cost_per_event_attendee.yml) · [sql](dbt/analyses/metrics/marketing/cost_per_event_attendee.sql)
- **Numerator:** Event cost
- **Denominator:** Attendees
- **Dimensions:** date, event
- **Data sources:** events_platform, finance
- **Parents:** [`cpl`](#cpl)
- **Correlated:** [`event_attendees`](#event_attendees), [`cpl`](#cpl)

<a id="cost_per_mql"></a>
#### Cost per MQL — `cost_per_mql`

Total marketing spend divided by MQLs generated.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/cost_per_mql.yml) · [sql](dbt/analyses/metrics/marketing/cost_per_mql.sql)
- **Numerator:** Marketing spend
- **Denominator:** MQLs
- **Dimensions:** date, channel
- **Data sources:** ad_platforms, crm
- **Parents:** [`cac`](#cac)
- **Children:** [`cpl`](#cpl), [`marketing_spend`](#marketing_spend)
- **Formula inputs:** [`mql`](#mql)
- **Correlated:** [`cpl`](#cpl), [`marketing_cac`](#marketing_cac), [`cost_per_sql`](#cost_per_sql), [`mql`](#mql), [`web_conversion_rate`](#web_conversion_rate)

<a id="cost_per_sql"></a>
#### Cost per SQL — `cost_per_sql`

Total marketing spend per sales-qualified lead generated.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/cost_per_sql.yml) · [sql](dbt/analyses/metrics/marketing/cost_per_sql.sql)
- **Numerator:** Marketing Spend
- **Denominator:** SQL Count
- **Dimensions:** channel, campaign, period
- **Data sources:** Marketing automation, CRM
- **Parents:** [`cac`](#cac)
- **Children:** [`marketing_spend`](#marketing_spend), [`sql`](#sql)
- **Correlated:** [`cost_per_mql`](#cost_per_mql), [`cac`](#cac)

<a id="cpc"></a>
#### CPC — `cpc`

Average cost paid per ad click.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/cpc.yml) · [sql](dbt/analyses/metrics/marketing/cpc.sql)
- **Numerator:** Ad spend
- **Denominator:** Clicks
- **Dimensions:** date, channel
- **Data sources:** ad_platforms
- **Parents:** [`cpl`](#cpl)
- **Children:** [`impressions`](#impressions), [`ad_clicks`](#ad_clicks), [`ctr`](#ctr), [`cpm`](#cpm), [`marketing_spend`](#marketing_spend)
- **Correlated:** [`ctr`](#ctr), [`roas`](#roas), [`impressions`](#impressions), [`cpl`](#cpl), [`cpm`](#cpm), [`marketing_spend`](#marketing_spend)

<a id="cpl"></a>
#### Cost Per Lead — `cpl`

Total marketing spend divided by leads generated

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/cpl.yml) · [sql](dbt/analyses/metrics/marketing/cpl.sql)
- **Numerator:** Marketing spend
- **Denominator:** Leads generated
- **Dimensions:** date, channel, campaign
- **Data sources:** ad_platforms, crm
- **Parents:** [`cost_per_mql`](#cost_per_mql)
- **Children:** [`leads`](#leads), [`cost_per_event_attendee`](#cost_per_event_attendee), [`cpc`](#cpc), [`marketing_spend`](#marketing_spend)
- **Correlated:** [`cost_per_mql`](#cost_per_mql), [`cpc`](#cpc), [`cost_per_event_attendee`](#cost_per_event_attendee), [`leads`](#leads)

<a id="cpm"></a>
#### CPM — `cpm`

Cost per thousand impressions — media efficiency benchmark.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/cpm.yml) · [sql](dbt/analyses/metrics/marketing/cpm.sql)
- **Numerator:** Spend × 1000
- **Denominator:** Impressions
- **Dimensions:** channel, campaign, period
- **Data sources:** Ad platforms
- **Parents:** [`cpc`](#cpc)
- **Children:** [`marketing_spend`](#marketing_spend), [`impressions`](#impressions)
- **Correlated:** [`ctr`](#ctr), [`cpc`](#cpc)

<a id="ctr"></a>
#### CTR — `ctr`

Clicks divided by impressions — ad relevance and creative effectiveness.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/ctr.yml) · [sql](dbt/analyses/metrics/marketing/ctr.sql)
- **Numerator:** Clicks
- **Denominator:** Impressions
- **Dimensions:** channel, campaign, ad_set, period, date, ad
- **Data sources:** Google Ads, Meta Ads
- **Parents:** [`cpc`](#cpc)
- **Children:** [`ad_clicks`](#ad_clicks), [`impressions`](#impressions)
- **Correlated:** [`cpc`](#cpc), [`web_conversion_rate`](#web_conversion_rate), [`cpm`](#cpm), [`roas`](#roas), [`impressions`](#impressions)

<a id="domain_authority"></a>
#### Domain Authority — `domain_authority`

Third-party domain authority score (Moz, Ahrefs) from 0 to 100

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/domain_authority.yml) · [sql](dbt/analyses/metrics/marketing/domain_authority.sql)
- **Numerator:** SEO authority score (0–100)
- **Dimensions:** date
- **Data sources:** seo_tools
- **Parents:** [`top10_keyword_count`](#top10_keyword_count)
- **Children:** [`backlink_count`](#backlink_count), [`backlinks_count`](#backlinks_count)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`top10_keyword_count`](#top10_keyword_count), [`backlinks_count`](#backlinks_count), [`backlink_count`](#backlink_count), [`content_published_count`](#content_published_count), [`oss_stars`](#oss_stars), [`pr_mentions`](#pr_mentions), [`social_engagement_rate`](#social_engagement_rate)

<a id="earned_media_value"></a>
#### Earned Media Value — `earned_media_value`

Estimated equivalent value of organic press coverage

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/earned_media_value.yml) · [sql](dbt/analyses/metrics/marketing/earned_media_value.sql)
- **Numerator:** Estimated value of earned media coverage
- **Dimensions:** date
- **Data sources:** media_monitoring
- **Parents:** [`share_of_voice`](#share_of_voice)
- **Children:** [`pr_mentions`](#pr_mentions)
- **Correlated:** [`pr_mentions`](#pr_mentions), [`social_engagement_rate`](#social_engagement_rate)

<a id="email_click_rate"></a>
#### Email Click Rate — `email_click_rate`

% of delivered emails that received at least one click.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/email_click_rate.yml) · [sql](dbt/analyses/metrics/marketing/email_click_rate.sql)
- **Numerator:** Emails Clicked
- **Denominator:** Emails Delivered
- **Dimensions:** campaign_id, segment, period, date, campaign
- **Data sources:** Email platform
- **Parents:** [`mql`](#mql)
- **Children:** [`email_open_rate`](#email_open_rate)
- **Correlated:** [`email_open_rate`](#email_open_rate), [`web_conversion_rate`](#web_conversion_rate), [`form_conversion_rate`](#form_conversion_rate), [`unsubscribe_rate`](#unsubscribe_rate)

<a id="email_open_rate"></a>
#### Email Open Rate — `email_open_rate`

% of delivered emails that were opened.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/email_open_rate.yml) · [sql](dbt/analyses/metrics/marketing/email_open_rate.sql)
- **Numerator:** Emails Opened
- **Denominator:** Emails Delivered
- **Dimensions:** campaign_id, segment, period
- **Data sources:** Email platform (HubSpot / Klaviyo / Mailchimp)
- **Parents:** [`email_click_rate`](#email_click_rate)
- **Correlated:** [`email_click_rate`](#email_click_rate), [`unsubscribe_rate`](#unsubscribe_rate), [`push_open_rate`](#push_open_rate), [`webinar_attendance_rate`](#webinar_attendance_rate)

<a id="form_conversion_rate"></a>
#### Form CVR % — `form_conversion_rate`

Percentage of form page visitors who submitted a form

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/form_conversion_rate.yml) · [sql](dbt/analyses/metrics/marketing/form_conversion_rate.sql)
- **Numerator:** Form submissions
- **Denominator:** Form views
- **Dimensions:** date, form, page
- **Data sources:** analytics, crm
- **Parents:** [`mql`](#mql)
- **Children:** [`website_sessions`](#website_sessions), [`leads`](#leads)
- **Correlated:** [`session_to_lead_rate`](#session_to_lead_rate), [`lead_to_mql_rate`](#lead_to_mql_rate), [`demo_requests`](#demo_requests), [`email_click_rate`](#email_click_rate), [`webinar_attendance_rate`](#webinar_attendance_rate)

<a id="marketing_cac"></a>
#### Marketing CAC — `marketing_cac`

Total marketing spend divided by new customers acquired

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/marketing_cac.yml) · [sql](dbt/analyses/metrics/marketing/marketing_cac.sql)
- **Numerator:** Total marketing spend
- **Denominator:** New customers acquired
- **Dimensions:** date, channel
- **Data sources:** ad_platforms, crm
- **Parents:** [`cac`](#cac)
- **Children:** [`net_new_customers`](#net_new_customers), [`marketing_spend`](#marketing_spend)
- **Correlated:** [`cac`](#cac), [`cost_per_mql`](#cost_per_mql), [`marketing_roi`](#marketing_roi), [`sm_spend`](#sm_spend), [`marketing_spend`](#marketing_spend)

<a id="marketing_spend"></a>
#### Marketing Spend — `marketing_spend`

Total paid and owned marketing spend in the period.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/marketing_spend.yml) · [sql](dbt/analyses/metrics/marketing/marketing_spend.sql)
- **Numerator:** SUM(spend)
- **Dimensions:** channel, campaign, period
- **Data sources:** Ad platforms, Finance
- **Parents:** [`cac`](#cac), [`cost_per_mql`](#cost_per_mql), [`cost_per_sql`](#cost_per_sql), [`cpm`](#cpm), [`roas`](#roas), [`cpc`](#cpc), [`cpl`](#cpl), [`marketing_cac`](#marketing_cac), [`marketing_roi`](#marketing_roi)
- **Correlated:** [`revenue`](#revenue), [`mrr`](#mrr), [`sales_spend`](#sales_spend), [`roas`](#roas), [`cpc`](#cpc), [`marketing_cac`](#marketing_cac)

<a id="organic_sessions"></a>
#### Organic Sessions — `organic_sessions`

Web sessions from unpaid search (SEO) traffic.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/organic_sessions.yml) · [sql](dbt/analyses/metrics/marketing/organic_sessions.sql)
- **Numerator:** COUNT(sessions WHERE medium = 'organic')
- **Dimensions:** landing_page, keyword, device, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`website_sessions`](#website_sessions), [`organic_attribution_pct`](#organic_attribution_pct)
- **Children:** [`content_published_count`](#content_published_count), [`top10_keyword_count`](#top10_keyword_count)
- **Correlated:** [`paid_sessions`](#paid_sessions), [`web_conversion_rate`](#web_conversion_rate), [`backlink_count`](#backlink_count), [`content_published_count`](#content_published_count), [`referral_sessions`](#referral_sessions), [`share_of_voice`](#share_of_voice), [`social_followers`](#social_followers), [`top10_keyword_count`](#top10_keyword_count), [`backlinks_count`](#backlinks_count), [`domain_authority`](#domain_authority)

<a id="paid_sessions"></a>
#### Paid Sessions — `paid_sessions`

Web sessions from paid advertising channels (CPC, CPM).

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/paid_sessions.yml) · [sql](dbt/analyses/metrics/marketing/paid_sessions.sql)
- **Numerator:** COUNT(sessions WHERE medium = 'cpc' or 'paid')
- **Dimensions:** channel, campaign, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`website_sessions`](#website_sessions)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`roas`](#roas)

<a id="push_open_rate"></a>
#### Push Open Rate — `push_open_rate`

Percentage of push notifications that were opened

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/push_open_rate.yml) · [sql](dbt/analyses/metrics/marketing/push_open_rate.sql)
- **Numerator:** Push notification opens
- **Denominator:** Delivered notifications
- **Dimensions:** date, campaign
- **Data sources:** push_platform
- **Parents:** [`dau`](#dau)
- **Correlated:** [`email_open_rate`](#email_open_rate), [`dau_mau_ratio`](#dau_mau_ratio)

<a id="review_rating"></a>
#### Review Rating — `review_rating`

Average rating on third-party review platforms (out of 5)

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/review_rating.yml) · [sql](dbt/analyses/metrics/marketing/review_rating.sql)
- **Numerator:** Average review score
- **Dimensions:** date, platform
- **Data sources:** review_platforms
- **Parents:** [`nps`](#nps)
- **Correlated:** [`nps`](#nps), [`csat`](#csat), [`app_store_rating`](#app_store_rating), [`testimonials_count`](#testimonials_count)

<a id="roas"></a>
#### ROAS — `roas`

Revenue attributed to ads divided by ad spend — direct campaign ROI.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/roas.yml) · [sql](dbt/analyses/metrics/marketing/roas.sql)
- **Numerator:** Revenue Attributed to Ads
- **Denominator:** Ad Spend
- **Dimensions:** channel, campaign, period
- **Data sources:** Ad platforms, Revenue attribution model
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Children:** [`marketing_spend`](#marketing_spend)
- **Correlated:** [`cac`](#cac), [`ltv_cac`](#ltv_cac), [`ctr`](#ctr), [`cpc`](#cpc), [`marketing_influenced_pipeline`](#marketing_influenced_pipeline), [`marketing_roi`](#marketing_roi), [`paid_attribution_pct`](#paid_attribution_pct), [`paid_sessions`](#paid_sessions), [`marketing_spend`](#marketing_spend)

<a id="session_to_lead_rate"></a>
#### Session → Lead % — `session_to_lead_rate`

Percentage of web sessions that convert to a lead

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/session_to_lead_rate.yml) · [sql](dbt/analyses/metrics/marketing/session_to_lead_rate.sql)
- **Numerator:** Leads created
- **Denominator:** Sessions
- **Dimensions:** date, channel
- **Data sources:** analytics, crm
- **Parents:** [`mql`](#mql)
- **Children:** [`website_sessions`](#website_sessions), [`leads`](#leads)
- **Correlated:** [`form_conversion_rate`](#form_conversion_rate), [`bounce_rate`](#bounce_rate), [`funnel_dropoff`](#funnel_dropoff)

<a id="sessions_per_user"></a>
#### Sessions / User — `sessions_per_user`

Average number of sessions per active user in the period

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/sessions_per_user.yml) · [sql](dbt/analyses/metrics/marketing/sessions_per_user.sql)
- **Numerator:** Sessions
- **Denominator:** Active users
- **Dimensions:** date, platform
- **Data sources:** sessions
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`website_sessions`](#website_sessions)
- **Correlated:** [`dau_mau_ratio`](#dau_mau_ratio), [`avg_session_duration`](#avg_session_duration)

<a id="share_of_voice"></a>
#### Share of Voice — `share_of_voice`

Brand mentions as a % of total category mentions — competitive visibility.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/share_of_voice.yml) · [sql](dbt/analyses/metrics/marketing/share_of_voice.sql)
- **Numerator:** Brand Mentions
- **Denominator:** Total Category Mentions
- **Dimensions:** platform, keyword_group, period
- **Data sources:** Social listening tools (Brandwatch / Mention)
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Children:** [`social_followers`](#social_followers), [`earned_media_value`](#earned_media_value), [`social_engagement_rate`](#social_engagement_rate)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`impressions`](#impressions)

<a id="social_engagement_rate"></a>
#### Social Engagement % — `social_engagement_rate`

Average engagements (likes, comments, shares) per post divided by reach

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/social_engagement_rate.yml) · [sql](dbt/analyses/metrics/marketing/social_engagement_rate.sql)
- **Numerator:** Engagements (likes + comments + shares)
- **Denominator:** Followers
- **Dimensions:** date, platform
- **Data sources:** social_analytics
- **Parents:** [`share_of_voice`](#share_of_voice)
- **Children:** [`social_followers`](#social_followers)
- **Correlated:** [`domain_authority`](#domain_authority), [`earned_media_value`](#earned_media_value), [`pr_mentions`](#pr_mentions)

<a id="top10_keyword_count"></a>
#### Top 10 Keywords — `top10_keyword_count`

Number of target keywords ranking in Google's top 10 results.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/top10_keyword_count.yml) · [sql](dbt/analyses/metrics/marketing/top10_keyword_count.sql)
- **Numerator:** COUNT(keywords WHERE rank <= 10)
- **Dimensions:** keyword_group, page, period, date
- **Data sources:** SEO tools (SEMrush / Ahrefs)
- **Parents:** [`organic_sessions`](#organic_sessions)
- **Children:** [`domain_authority`](#domain_authority)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`content_published_count`](#content_published_count), [`domain_authority`](#domain_authority), [`backlinks_count`](#backlinks_count)

<a id="unsubscribe_rate"></a>
#### Unsubscribe Rate — `unsubscribe_rate`

% of email recipients who unsubscribed — list health signal.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/unsubscribe_rate.yml) · [sql](dbt/analyses/metrics/marketing/unsubscribe_rate.sql)
- **Numerator:** Unsubscribes
- **Denominator:** Emails Delivered
- **Dimensions:** campaign_id, segment, period, date, campaign
- **Data sources:** Email platform
- **Parents:** [`mql`](#mql)
- **Correlated:** [`email_open_rate`](#email_open_rate), [`email_click_rate`](#email_click_rate)

<a id="viral_coefficient"></a>
#### Viral Coefficient (K) — `viral_coefficient`

Average number of new customers each existing customer generates

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/viral_coefficient.yml) · [sql](dbt/analyses/metrics/marketing/viral_coefficient.sql)
- **Numerator:** Invites sent × conversion rate
- **Dimensions:** date
- **Data sources:** referrals, users
- **Parents:** [`new_user_signups`](#new_user_signups)
- **Children:** [`oss_stars`](#oss_stars)
- **Correlated:** [`plg_rate`](#plg_rate), [`trial_to_paid_rate`](#trial_to_paid_rate), [`oss_stars`](#oss_stars), [`referral_attribution_pct`](#referral_attribution_pct)

<a id="web_conversion_rate"></a>
#### Web Conversion Rate — `web_conversion_rate`

% of sessions that result in a conversion event (form fill, signup, etc.).

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/web_conversion_rate.yml) · [sql](dbt/analyses/metrics/marketing/web_conversion_rate.sql)
- **Numerator:** Conversions
- **Denominator:** Sessions
- **Dimensions:** landing_page, channel, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`mql`](#mql)
- **Children:** [`website_sessions`](#website_sessions), [`bounce_rate`](#bounce_rate)
- **Correlated:** [`ctr`](#ctr), [`cost_per_mql`](#cost_per_mql), [`ad_clicks`](#ad_clicks), [`bounce_rate`](#bounce_rate), [`email_click_rate`](#email_click_rate), [`organic_sessions`](#organic_sessions), [`website_sessions`](#website_sessions)

<a id="webinar_attendance_rate"></a>
#### Webinar Attendance % — `webinar_attendance_rate`

Percentage of webinar registrants who attended live

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/webinar_attendance_rate.yml) · [sql](dbt/analyses/metrics/marketing/webinar_attendance_rate.sql)
- **Numerator:** Attendees
- **Denominator:** Registrants
- **Dimensions:** date, webinar
- **Data sources:** webinar_platform, marketing_automation
- **Parents:** [`mql`](#mql)
- **Children:** [`webinar_registrants`](#webinar_registrants)
- **Correlated:** [`email_open_rate`](#email_open_rate), [`form_conversion_rate`](#form_conversion_rate), [`webinar_registrants`](#webinar_registrants)

<a id="website_sessions"></a>
#### Website Sessions — `website_sessions`

Total web sessions across all channels.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/website_sessions.yml) · [sql](dbt/analyses/metrics/marketing/website_sessions.sql)
- **Numerator:** COUNT(sessions)
- **Dimensions:** channel, source, medium, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`form_conversion_rate`](#form_conversion_rate), [`session_to_lead_rate`](#session_to_lead_rate), [`web_conversion_rate`](#web_conversion_rate), [`bounce_rate`](#bounce_rate), [`sessions_per_user`](#sessions_per_user)
- **Children:** [`organic_sessions`](#organic_sessions), [`paid_sessions`](#paid_sessions), [`referral_sessions`](#referral_sessions)
- **Correlated:** [`mql`](#mql), [`web_conversion_rate`](#web_conversion_rate), [`bounce_rate`](#bounce_rate), [`dau`](#dau), [`avg_session_duration`](#avg_session_duration)

### KPI · Operations (17)

<a id="capacity_utilization"></a>
#### Capacity Utilization % — `capacity_utilization`

Actual output as a percentage of total available capacity

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/capacity_utilization.yml) · [sql](dbt/analyses/metrics/operations/capacity_utilization.sql)
- **Numerator:** Actual output
- **Denominator:** Maximum capacity
- **Dimensions:** date, facility, production_line, plant_id, period
- **Data sources:** capacity_planning
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Children:** [`throughput`](#throughput)
- **Correlated:** [`warehouse_utilization`](#warehouse_utilization), [`cycle_time`](#cycle_time), [`throughput`](#throughput), [`defect_rate`](#defect_rate), [`cost_per_unit`](#cost_per_unit), [`energy_cost_per_unit`](#energy_cost_per_unit)

<a id="carbon_emissions_per_unit"></a>
#### Carbon per Unit — `carbon_emissions_per_unit`

kg CO2 equivalent emitted per unit of output — ESG and sustainability metric.

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/carbon_emissions_per_unit.yml) · [sql](dbt/analyses/metrics/operations/carbon_emissions_per_unit.sql)
- **Numerator:** Total CO2e Emissions (kg)
- **Denominator:** Units Produced
- **Dimensions:** facility_id, process_type, period
- **Data sources:** Environmental monitoring, ERP
- **Parents:** [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Correlated:** [`energy_cost_per_unit`](#energy_cost_per_unit), [`cost_per_unit`](#cost_per_unit)

<a id="cost_per_mile"></a>
#### Cost per Mile — `cost_per_mile`

Total fleet operating cost divided by total miles driven.

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/cost_per_mile.yml) · [sql](dbt/analyses/metrics/operations/cost_per_mile.sql)
- **Numerator:** Total Fleet Operating Cost
- **Denominator:** Total Miles Driven
- **Dimensions:** fleet_type, vehicle_id, period
- **Data sources:** Fleet management, Finance
- **Parents:** [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Children:** [`fleet_utilization_rate`](#fleet_utilization_rate)
- **Correlated:** [`fleet_utilization_rate`](#fleet_utilization_rate)

<a id="cost_per_unit"></a>
#### Cost per Unit — `cost_per_unit`

Total production cost divided by units produced in the period.

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/cost_per_unit.yml) · [sql](dbt/analyses/metrics/operations/cost_per_unit.sql)
- **Numerator:** Total Production Cost
- **Denominator:** Units Produced
- **Dimensions:** product_id, production_line, period
- **Data sources:** ERP, MES
- **Parents:** [`gross_margin_pct`](#gross_margin_pct)
- **Children:** [`energy_cost_per_unit`](#energy_cost_per_unit)
- **Correlated:** [`defect_rate`](#defect_rate), [`capacity_utilization`](#capacity_utilization), [`carbon_emissions_per_unit`](#carbon_emissions_per_unit), [`procurement_savings_rate`](#procurement_savings_rate)

<a id="cycle_time"></a>
#### Cycle Time — `cycle_time`

Average time from work start to delivery

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/cycle_time.yml) · [sql](dbt/analyses/metrics/operations/cycle_time.sql)
- **Numerator:** Order complete − Order start
- **Dimensions:** date, product
- **Data sources:** production, orders
- **Parents:** [`on_time_delivery_rate`](#on_time_delivery_rate)
- **Children:** [`process_automation_rate`](#process_automation_rate)
- **Correlated:** [`lead_time`](#lead_time), [`throughput`](#throughput), [`on_time_delivery_rate`](#on_time_delivery_rate), [`capacity_utilization`](#capacity_utilization), [`process_automation_rate`](#process_automation_rate)

<a id="defect_rate"></a>
#### Defect Rate — `defect_rate`

% of units produced or received that fail quality inspection.

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/defect_rate.yml) · [sql](dbt/analyses/metrics/operations/defect_rate.sql)
- **Numerator:** Defective Units
- **Denominator:** Total Units Inspected
- **Dimensions:** production_line, supplier_id, product_id, period
- **Data sources:** Quality management system, ERP
- **Parents:** [`ops_north_star`](#ops_north_star), [`vendor_scorecard_rating`](#vendor_scorecard_rating)
- **Correlated:** [`order_accuracy_rate`](#order_accuracy_rate), [`fill_rate`](#fill_rate), [`capacity_utilization`](#capacity_utilization), [`cost_per_unit`](#cost_per_unit), [`return_rate`](#return_rate), [`vendor_compliance_rate`](#vendor_compliance_rate), [`vendor_scorecard_rating`](#vendor_scorecard_rating)

<a id="fleet_utilization_rate"></a>
#### Fleet Utilization Rate — `fleet_utilization_rate`

% of available vehicle hours actually used in operations.

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/fleet_utilization_rate.yml) · [sql](dbt/analyses/metrics/operations/fleet_utilization_rate.sql)
- **Numerator:** Hours in Service
- **Denominator:** Available Hours
- **Dimensions:** vehicle_id, fleet_type, region, period
- **Data sources:** Fleet management system (GPS, telematics)
- **Parents:** [`cost_per_mile`](#cost_per_mile)
- **Correlated:** [`cost_per_mile`](#cost_per_mile)

<a id="preventive_maintenance_rate"></a>
#### Preventive Maintenance Rate — `preventive_maintenance_rate`

% of maintenance activity that is planned preventive vs reactive.

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/preventive_maintenance_rate.yml) · [sql](dbt/analyses/metrics/operations/preventive_maintenance_rate.sql)
- **Numerator:** Preventive Work Orders
- **Denominator:** Total Work Orders
- **Dimensions:** facility_id, asset_type, period
- **Data sources:** CMMS
- **Parents:** [`mtbf`](#mtbf)
- **Children:** [`work_orders`](#work_orders)
- **Correlated:** [`work_order_resolution_time`](#work_order_resolution_time), [`mtbf`](#mtbf), [`uptime`](#uptime)

<a id="process_automation_rate"></a>
#### Automation Rate — `process_automation_rate`

Percentage of defined processes that run without manual intervention

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/process_automation_rate.yml) · [sql](dbt/analyses/metrics/operations/process_automation_rate.sql)
- **Numerator:** Automated processes
- **Denominator:** Total defined processes
- **Dimensions:** date
- **Data sources:** process_catalog
- **Parents:** [`cycle_time`](#cycle_time)
- **Correlated:** [`cycle_time`](#cycle_time), [`throughput`](#throughput)

<a id="procurement_savings_rate"></a>
#### Procurement Savings Rate — `procurement_savings_rate`

Actual spend vs budgeted or baseline spend — cost reduction from procurement initiatives.

- **Domain:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/operations/procurement_savings_rate.yml) · [sql](dbt/analyses/metrics/operations/procurement_savings_rate.sql)
- **Numerator:** Baseline Spend - Actual Spend
- **Denominator:** Baseline Spend
- **Dimensions:** category_manager, spend_category, period
- **Data sources:** ERP, Purchasing system
- **Parents:** [`cogs`](#cogs)
- **Correlated:** [`cost_per_unit`](#cost_per_unit), [`gross_margin_pct`](#gross_margin_pct)

<a id="safety_incident_rate"></a>
#### Safety Incident Rate — `safety_incident_rate`

OSHA recordable incident rate per 100 full-time employees.

- **Domain:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/operations/safety_incident_rate.yml) · [sql](dbt/analyses/metrics/operations/safety_incident_rate.sql)
- **Numerator:** Recordable Incidents × 200,000
- **Denominator:** Total Employee-Hours Worked
- **Dimensions:** facility_id, department, incident_type, period
- **Data sources:** Safety management system, HRIS
- **Parents:** [`workforce_productivity`](#workforce_productivity)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`headcount_cost`](#headcount_cost)

<a id="supplier_lead_time"></a>
#### Supplier Lead Time — `supplier_lead_time`

Average days from purchase order creation to goods receipt.

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/supplier_lead_time.yml) · [sql](dbt/analyses/metrics/operations/supplier_lead_time.sql)
- **Numerator:** SUM(receipt_date - po_date)
- **Denominator:** COUNT(purchase orders)
- **Dimensions:** supplier_id, product_category, period
- **Data sources:** ERP, Purchasing system
- **Parents:** [`vendor_scorecard_rating`](#vendor_scorecard_rating)
- **Correlated:** [`fill_rate`](#fill_rate), [`inventory_turnover`](#inventory_turnover), [`vendor_compliance_rate`](#vendor_compliance_rate)

<a id="throughput"></a>
#### Throughput — `throughput`

Number of units completed per period

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/throughput.yml) · [sql](dbt/analyses/metrics/operations/throughput.sql)
- **Numerator:** Units produced or delivered in period
- **Dimensions:** date, line
- **Data sources:** production
- **Parents:** [`capacity_utilization`](#capacity_utilization)
- **Correlated:** [`cycle_time`](#cycle_time), [`capacity_utilization`](#capacity_utilization), [`ops_efficiency_ratio`](#ops_efficiency_ratio), [`process_automation_rate`](#process_automation_rate)

<a id="vendor_compliance_rate"></a>
#### Vendor Compliance % — `vendor_compliance_rate`

Percentage of purchase orders fulfilled by vendors per specifications

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/vendor_compliance_rate.yml) · [sql](dbt/analyses/metrics/operations/vendor_compliance_rate.sql)
- **Numerator:** Compliant POs
- **Denominator:** Total POs
- **Dimensions:** date, vendor
- **Data sources:** procurement, quality
- **Parents:** [`vendor_scorecard_rating`](#vendor_scorecard_rating)
- **Correlated:** [`supplier_lead_time`](#supplier_lead_time), [`defect_rate`](#defect_rate), [`shrinkage_rate`](#shrinkage_rate)

<a id="vendor_scorecard_rating"></a>
#### Vendor Scorecard Rating — `vendor_scorecard_rating`

Composite supplier performance score across quality, delivery, and cost dimensions.

- **Domain:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/operations/vendor_scorecard_rating.yml) · [sql](dbt/analyses/metrics/operations/vendor_scorecard_rating.sql)
- **Numerator:** Weighted average of quality, delivery, and cost scores
- **Dimensions:** supplier_id, category, period
- **Data sources:** Procurement system, WMS, QMS
- **Parents:** [`ops_north_star`](#ops_north_star)
- **Children:** [`supplier_lead_time`](#supplier_lead_time), [`defect_rate`](#defect_rate), [`vendor_compliance_rate`](#vendor_compliance_rate)
- **Correlated:** [`fill_rate`](#fill_rate), [`defect_rate`](#defect_rate)

<a id="warehouse_utilization"></a>
#### Warehouse Utilization % — `warehouse_utilization`

Percentage of warehouse storage capacity currently in use

- **Domain:** Operations · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/operations/warehouse_utilization.yml) · [sql](dbt/analyses/metrics/operations/warehouse_utilization.sql)
- **Numerator:** Occupied square footage
- **Denominator:** Total square footage
- **Dimensions:** date, facility, warehouse_id, product_zone, period
- **Data sources:** warehouse_system
- **Parents:** [`ops_efficiency_ratio`](#ops_efficiency_ratio)
- **Correlated:** [`capacity_utilization`](#capacity_utilization), [`inventory_value`](#inventory_value), [`fill_rate`](#fill_rate), [`inventory_turnover`](#inventory_turnover)

<a id="work_order_resolution_time"></a>
#### Work Order Resolution Time — `work_order_resolution_time`

Average days to close a maintenance work order from creation.

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/work_order_resolution_time.yml) · [sql](dbt/analyses/metrics/operations/work_order_resolution_time.sql)
- **Numerator:** SUM(completed_date - created_date)
- **Denominator:** COUNT(completed work orders)
- **Dimensions:** facility_id, category, priority, period
- **Data sources:** CMMS
- **Parents:** [`uptime`](#uptime)
- **Children:** [`work_orders`](#work_orders)
- **Correlated:** [`preventive_maintenance_rate`](#preventive_maintenance_rate)

### KPI · Product (21)

<a id="activation_rate"></a>
#### Activation Rate — `activation_rate`

% of signups that reach the activation milestone within the first session or week.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/activation_rate.yml) · [sql](dbt/analyses/metrics/product/activation_rate.sql)
- **Numerator:** Users who hit activation event
- **Denominator:** Total Signups
- **Dimensions:** cohort, acquisition_channel, plan_tier
- **Data sources:** Product analytics
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`funnel_dropoff`](#funnel_dropoff), [`time_to_activate`](#time_to_activate)
- **Correlated:** [`onboarding_completion_rate`](#onboarding_completion_rate), [`time_to_value`](#time_to_value), [`app_downloads`](#app_downloads), [`d7_retention`](#d7_retention), [`feature_adoption_rate`](#feature_adoption_rate), [`free_to_paid_rate`](#free_to_paid_rate), [`funnel_dropoff`](#funnel_dropoff), [`new_user_signups`](#new_user_signups), [`customer_onboarding_time`](#customer_onboarding_time), [`time_to_activate`](#time_to_activate), [`trial_signups`](#trial_signups), [`trial_to_paid_rate`](#trial_to_paid_rate)

<a id="api_latency_p95"></a>
#### API Latency p95 — `api_latency_p95`

95th percentile API response time in milliseconds.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/api_latency_p95.yml) · [sql](dbt/analyses/metrics/product/api_latency_p95.sql)
- **Numerator:** PERCENTILE_CONT(0.95) of response_time_ms
- **Dimensions:** endpoint, environment, period
- **Data sources:** APM (Datadog / New Relic)
- **Parents:** [`error_rate`](#error_rate)
- **Children:** [`api_calls_total`](#api_calls_total)
- **Correlated:** [`error_rate`](#error_rate), [`csat`](#csat), [`api_calls_total`](#api_calls_total), [`uptime`](#uptime)

<a id="ces"></a>
#### CES — `ces`

How easy it was for customers to resolve an issue — lower effort = better.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/ces.yml) · [sql](dbt/analyses/metrics/product/ces.sql)
- **Numerator:** AVG(effort_score)
- **Dimensions:** channel, interaction_type, period
- **Data sources:** Survey platform, Support ticket system
- **Parents:** [`account_health_score`](#account_health_score)
- **Correlated:** [`csat`](#csat), [`nps`](#nps), [`cx_csat`](#cx_csat), [`first_response_time`](#first_response_time), [`ticket_resolution_rate`](#ticket_resolution_rate)

<a id="csat"></a>
#### CSAT — `csat`

Average satisfaction rating from post-interaction surveys (1–5 or 1–10).

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/csat.yml) · [sql](dbt/analyses/metrics/product/csat.sql)
- **Numerator:** SUM(satisfaction_score)
- **Denominator:** COUNT(responses)
- **Dimensions:** product, channel, support_team, period
- **Data sources:** Survey platform, CRM
- **Parents:** [`account_health_score`](#account_health_score), [`cx_csat`](#cx_csat)
- **Children:** [`fcr_rate`](#fcr_rate), [`first_response_time`](#first_response_time), [`sla_breach_rate`](#sla_breach_rate), [`ticket_resolution_rate`](#ticket_resolution_rate), [`tickets_per_customer`](#tickets_per_customer), [`time_to_resolution`](#time_to_resolution)
- **Correlated:** [`nps`](#nps), [`churn_rate`](#churn_rate), [`api_latency_p95`](#api_latency_p95), [`app_store_rating`](#app_store_rating), [`ces`](#ces), [`complaint_resolution_rate`](#complaint_resolution_rate), [`complaints_count`](#complaints_count), [`cx_csat`](#cx_csat), [`error_rate`](#error_rate), [`fcr_rate`](#fcr_rate), [`first_response_time`](#first_response_time), [`ops_north_star`](#ops_north_star), [`return_rate`](#return_rate), [`refund_rate`](#refund_rate), [`review_rating`](#review_rating), [`sla_breach_rate`](#sla_breach_rate), [`sla_compliance_rate`](#sla_compliance_rate), [`tickets_created`](#tickets_created), [`survey_response_rate`](#survey_response_rate), [`tickets_per_customer`](#tickets_per_customer), [`time_to_resolution`](#time_to_resolution)

<a id="d30_retention"></a>
#### D30 Retention — `d30_retention`

Percentage of new users still active 30 days after signup

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/d30_retention.yml) · [sql](dbt/analyses/metrics/product/d30_retention.sql)
- **Numerator:** Day-30 retained users
- **Denominator:** New users in cohort
- **Dimensions:** date, cohort, acquisition_channel, plan_tier
- **Data sources:** events, users
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`mau`](#mau), [`new_user_signups`](#new_user_signups), [`d7_retention`](#d7_retention)
- **Correlated:** [`d7_retention`](#d7_retention), [`churn_rate`](#churn_rate), [`cohort_churn`](#cohort_churn), [`cohort_ltv_12m`](#cohort_ltv_12m), [`product_churn_rate`](#product_churn_rate), [`dau_mau_ratio`](#dau_mau_ratio), [`churn_prediction_score`](#churn_prediction_score)

<a id="d7_retention"></a>
#### D7 Retention — `d7_retention`

Percentage of new users still active 7 days after signup

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/d7_retention.yml) · [sql](dbt/analyses/metrics/product/d7_retention.sql)
- **Numerator:** Day-7 retained users
- **Denominator:** New users in cohort
- **Dimensions:** date, cohort
- **Data sources:** events, users
- **Parents:** [`d30_retention`](#d30_retention)
- **Children:** [`dau`](#dau), [`new_user_signups`](#new_user_signups)
- **Correlated:** [`d30_retention`](#d30_retention), [`activation_rate`](#activation_rate), [`dau_mau_ratio`](#dau_mau_ratio)

<a id="dau"></a>
#### DAU — `dau`

Daily Active Users — unique users who performed a qualifying action in a day.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/dau.yml) · [sql](dbt/analyses/metrics/product/dau.sql)
- **Numerator:** COUNT(DISTINCT user_id WHERE active_event = true)
- **Dimensions:** platform, product_area, user_segment, date
- **Data sources:** Product analytics (Mixpanel / Amplitude / Segment)
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio), [`account_health_score`](#account_health_score), [`churn_prediction_score`](#churn_prediction_score), [`d7_retention`](#d7_retention), [`feature_adoption_rate`](#feature_adoption_rate), [`wau`](#wau)
- **Children:** [`push_open_rate`](#push_open_rate)
- **Correlated:** [`mau`](#mau), [`wau`](#wau), [`api_consumers`](#api_consumers), [`app_downloads`](#app_downloads), [`avg_session_duration`](#avg_session_duration), [`website_sessions`](#website_sessions)

<a id="dau_mau_ratio"></a>
#### DAU/MAU — `dau_mau_ratio`

Stickiness ratio — daily to monthly active user proportion

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/dau_mau_ratio.yml) · [sql](dbt/analyses/metrics/product/dau_mau_ratio.sql)
- **Numerator:** DAU
- **Denominator:** MAU
- **Dimensions:** date
- **Data sources:** events
- **Parents:** [`account_health_score`](#account_health_score)
- **Children:** [`dau`](#dau), [`mau`](#mau), [`activation_rate`](#activation_rate), [`avg_session_duration`](#avg_session_duration), [`d30_retention`](#d30_retention), [`error_rate`](#error_rate), [`feature_adoption_rate`](#feature_adoption_rate), [`sessions_per_user`](#sessions_per_user), [`time_to_value`](#time_to_value), [`wau`](#wau)
- **Correlated:** [`avg_session_duration`](#avg_session_duration), [`d7_retention`](#d7_retention), [`feature_adoption_rate`](#feature_adoption_rate), [`push_open_rate`](#push_open_rate), [`d30_retention`](#d30_retention), [`sessions_per_user`](#sessions_per_user)

<a id="error_rate"></a>
#### Error Rate — `error_rate`

% of user sessions or API calls that result in an error.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/error_rate.yml) · [sql](dbt/analyses/metrics/product/error_rate.sql)
- **Numerator:** Error Events
- **Denominator:** Total Events
- **Dimensions:** endpoint, error_type, platform, period
- **Data sources:** Error tracking (Sentry / Datadog)
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`api_latency_p95`](#api_latency_p95), [`bug_escape_rate`](#bug_escape_rate), [`uptime`](#uptime)
- **Correlated:** [`csat`](#csat), [`churn_rate`](#churn_rate), [`api_latency_p95`](#api_latency_p95), [`lead_time_for_changes`](#lead_time_for_changes), [`mttd`](#mttd), [`uptime`](#uptime)

<a id="feature_adoption_rate"></a>
#### Feature Adoption Rate — `feature_adoption_rate`

% of active users who used a specific feature at least once in the period.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/feature_adoption_rate.yml) · [sql](dbt/analyses/metrics/product/feature_adoption_rate.sql)
- **Numerator:** Users who used feature
- **Denominator:** Total Active Users
- **Dimensions:** feature_name, user_segment, plan_tier, period, date, feature
- **Data sources:** Product analytics
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio), [`account_health_score`](#account_health_score), [`churn_prediction_score`](#churn_prediction_score)
- **Children:** [`dau`](#dau)
- **Correlated:** [`expansion_arr`](#expansion_arr), [`nps`](#nps), [`avg_session_duration`](#avg_session_duration), [`feature_request_volume`](#feature_request_volume), [`onboarding_completion_rate`](#onboarding_completion_rate), [`time_to_value`](#time_to_value), [`dau_mau_ratio`](#dau_mau_ratio), [`activation_rate`](#activation_rate)

<a id="free_to_paid_rate"></a>
#### Free-to-Paid % — `free_to_paid_rate`

Percentage of free-tier users who convert to a paid plan

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/free_to_paid_rate.yml) · [sql](dbt/analyses/metrics/product/free_to_paid_rate.sql)
- **Numerator:** Free-to-paid conversions
- **Denominator:** Free users
- **Dimensions:** date, cohort
- **Data sources:** users, subscriptions
- **Parents:** [`plg_rate`](#plg_rate), [`trial_to_paid_rate`](#trial_to_paid_rate)
- **Children:** [`trial_signups`](#trial_signups), [`active_paying_users`](#active_paying_users)
- **Correlated:** [`trial_to_paid_rate`](#trial_to_paid_rate), [`activation_rate`](#activation_rate), [`active_paying_users`](#active_paying_users), [`trial_signups`](#trial_signups)

<a id="iap_revenue"></a>
#### IAP Revenue — `iap_revenue`

Revenue from in-app purchases made by users

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/iap_revenue.yml) · [sql](dbt/analyses/metrics/product/iap_revenue.sql)
- **Numerator:** In-app purchase revenue
- **Dimensions:** date, product
- **Data sources:** app_stores
- **Parents:** [`revenue`](#revenue)
- **Correlated:** [`arpu`](#arpu), [`aov`](#aov)

<a id="mau"></a>
#### MAU — `mau`

Monthly Active Users — unique users active in the last 30 days.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/mau.yml) · [sql](dbt/analyses/metrics/product/mau.sql)
- **Numerator:** COUNT(DISTINCT user_id WHERE active in last 30 days)
- **Dimensions:** platform, product_area, user_segment
- **Data sources:** Product analytics
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio), [`active_paying_users`](#active_paying_users), [`d30_retention`](#d30_retention)
- **Children:** [`api_consumers`](#api_consumers), [`new_user_signups`](#new_user_signups), [`product_churn_rate`](#product_churn_rate)
- **Correlated:** [`dau`](#dau), [`wau`](#wau)

<a id="new_user_signups"></a>
#### New Signups — `new_user_signups`

Count of new user account registrations in the period.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/new_user_signups.yml) · [sql](dbt/analyses/metrics/product/new_user_signups.sql)
- **Numerator:** COUNT(new user registrations)
- **Dimensions:** acquisition_channel, plan_tier, geography, period, date, channel
- **Data sources:** Product database, CRM
- **Parents:** [`mau`](#mau), [`d30_retention`](#d30_retention), [`d7_retention`](#d7_retention)
- **Children:** [`app_downloads`](#app_downloads), [`viral_coefficient`](#viral_coefficient)
- **Correlated:** [`activation_rate`](#activation_rate), [`mql`](#mql), [`trial_signups`](#trial_signups)

<a id="onboarding_completion_rate"></a>
#### Onboarding Completion — `onboarding_completion_rate`

% of new users who complete all onboarding steps.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/onboarding_completion_rate.yml) · [sql](dbt/analyses/metrics/product/onboarding_completion_rate.sql)
- **Numerator:** Users who completed onboarding
- **Denominator:** Users who started onboarding
- **Dimensions:** cohort, plan_tier, acquisition_channel
- **Data sources:** Product analytics
- **Parents:** [`time_to_value`](#time_to_value)
- **Correlated:** [`feature_adoption_rate`](#feature_adoption_rate), [`churn_rate`](#churn_rate), [`activation_rate`](#activation_rate)

<a id="plg_rate"></a>
#### PLG Rate — `plg_rate`

Percentage of new signups coming from product-driven virality (invites, sharing)

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/plg_rate.yml) · [sql](dbt/analyses/metrics/product/plg_rate.sql)
- **Numerator:** Self-serve signups
- **Denominator:** Total new signups
- **Dimensions:** date
- **Data sources:** users, subscriptions
- **Parents:** [`new_arr`](#new_arr)
- **Children:** [`trial_signups`](#trial_signups), [`free_to_paid_rate`](#free_to_paid_rate), [`trial_to_paid_rate`](#trial_to_paid_rate)
- **Correlated:** [`viral_coefficient`](#viral_coefficient), [`trial_to_paid_rate`](#trial_to_paid_rate)

<a id="product_churn_rate"></a>
#### Product Churn — `product_churn_rate`

Percentage of active users who became inactive this period

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/product_churn_rate.yml) · [sql](dbt/analyses/metrics/product/product_churn_rate.sql)
- **Numerator:** Users who stopped using product
- **Denominator:** Active users
- **Dimensions:** date
- **Data sources:** users
- **Parents:** [`mau`](#mau)
- **Correlated:** [`customer_churn_rate`](#customer_churn_rate), [`d30_retention`](#d30_retention)

<a id="time_to_activate"></a>
#### Time to Activate — `time_to_activate`

Median hours from signup to activation event

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/time_to_activate.yml) · [sql](dbt/analyses/metrics/product/time_to_activate.sql)
- **Numerator:** Days from signup to activation event
- **Dimensions:** date, cohort
- **Data sources:** events, users
- **Parents:** [`activation_rate`](#activation_rate)
- **Correlated:** [`activation_rate`](#activation_rate), [`time_to_value`](#time_to_value)

<a id="time_to_value"></a>
#### Time to Value — `time_to_value`

Days from signup to first meaningful value event (aha moment).

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/time_to_value.yml) · [sql](dbt/analyses/metrics/product/time_to_value.sql)
- **Numerator:** SUM(days from signup to value event)
- **Denominator:** COUNT(users who reached value event)
- **Dimensions:** cohort, plan_tier, acquisition_channel
- **Data sources:** Product analytics
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`onboarding_completion_rate`](#onboarding_completion_rate), [`customer_onboarding_time`](#customer_onboarding_time)
- **Correlated:** [`churn_rate`](#churn_rate), [`feature_adoption_rate`](#feature_adoption_rate), [`activation_rate`](#activation_rate), [`customer_onboarding_time`](#customer_onboarding_time), [`time_to_activate`](#time_to_activate)

<a id="trial_to_paid_rate"></a>
#### Trial → Paid % — `trial_to_paid_rate`

Percentage of trial users who converted to a paid plan

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/trial_to_paid_rate.yml) · [sql](dbt/analyses/metrics/product/trial_to_paid_rate.sql)
- **Numerator:** Paid conversions
- **Denominator:** Trial starts
- **Dimensions:** date, cohort
- **Data sources:** users, subscriptions
- **Parents:** [`plg_rate`](#plg_rate)
- **Children:** [`trial_signups`](#trial_signups), [`free_to_paid_rate`](#free_to_paid_rate)
- **Correlated:** [`free_to_paid_rate`](#free_to_paid_rate), [`activation_rate`](#activation_rate), [`plg_rate`](#plg_rate), [`viral_coefficient`](#viral_coefficient)

<a id="wau"></a>
#### WAU — `wau`

Weekly Active Users — unique users who performed a qualifying action in a 7-day window.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/wau.yml) · [sql](dbt/analyses/metrics/product/wau.sql)
- **Numerator:** Distinct active users in 7 days
- **Dimensions:** date, platform
- **Data sources:** events
- **Parents:** [`dau_mau_ratio`](#dau_mau_ratio)
- **Children:** [`dau`](#dau)
- **Correlated:** [`dau`](#dau), [`mau`](#mau)

### KPI · SaaS (27)

<a id="active_paying_users"></a>
#### Active Paying Users — `active_paying_users`

Users on a paid plan who have been active in the past 30 days

- **Domain:** SaaS · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/saas/active_paying_users.yml) · [sql](dbt/analyses/metrics/saas/active_paying_users.sql)
- **Numerator:** Paid users active in last 30 days
- **Dimensions:** date
- **Data sources:** users, subscriptions
- **Parents:** [`free_to_paid_rate`](#free_to_paid_rate)
- **Children:** [`mau`](#mau)
- **Correlated:** [`arr`](#arr), [`free_to_paid_rate`](#free_to_paid_rate)

<a id="acv"></a>
#### ACV — `acv`

Average annual contract value of new or existing customer agreements.

- **Domain:** SaaS · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/saas/acv.yml) · [sql](dbt/analyses/metrics/saas/acv.sql)
- **Numerator:** Total Contract ARR Value
- **Denominator:** Number of Contracts
- **Dimensions:** segment, product_tier, channel, period
- **Data sources:** CRM, Billing system
- **Parents:** [`arr`](#arr)
- **Correlated:** [`arr`](#arr), [`new_arr`](#new_arr), [`avg_deal_size`](#avg_deal_size), [`revenue_per_account`](#revenue_per_account)

<a id="arr"></a>
#### ARR — `arr`

Annual Recurring Revenue — annualized value of active subscriptions.

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/arr.yml) · [sql](dbt/analyses/metrics/saas/arr.sql)
- **Numerator:** Sum of active annual contract values
- **Dimensions:** date, customer_segment, product
- **Data sources:** subscriptions
- **Parents:** [`arr_growth_rate`](#arr_growth_rate), [`arr_per_rep`](#arr_per_rep), [`employees_per_1m_arr`](#employees_per_1m_arr), [`market_penetration_rate`](#market_penetration_rate), [`revenue`](#revenue), [`subscription_revenue`](#subscription_revenue)
- **Children:** [`new_arr`](#new_arr), [`expansion_arr`](#expansion_arr), [`contraction_arr`](#contraction_arr), [`churned_arr`](#churned_arr), [`acv`](#acv), [`bookings`](#bookings), [`churn_rate`](#churn_rate), [`committed_arr`](#committed_arr), [`mrr`](#mrr), [`nrr`](#nrr)
- **Correlated:** [`mrr`](#mrr), [`nrr`](#nrr), [`grr`](#grr), [`revenue_growth_rate`](#revenue_growth_rate), [`active_paying_users`](#active_paying_users), [`acv`](#acv), [`billings`](#billings), [`bookings`](#bookings), [`committed_arr`](#committed_arr), [`contracted_unbilled`](#contracted_unbilled), [`customer_concentration_risk`](#customer_concentration_risk), [`deferred_revenue`](#deferred_revenue), [`license_revenue`](#license_revenue), [`market_penetration_rate`](#market_penetration_rate), [`cac_payback`](#cac_payback), [`revenue`](#revenue), [`rule_of_40`](#rule_of_40), [`saas_quick_ratio`](#saas_quick_ratio), [`subscription_revenue`](#subscription_revenue)

<a id="arr_growth_rate"></a>
#### ARR Growth % — `arr_growth_rate`

Year-over-year growth in annual recurring revenue

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/arr_growth_rate.yml) · [sql](dbt/analyses/metrics/saas/arr_growth_rate.sql)
- **Numerator:** ARR(end) − ARR(start)
- **Denominator:** ARR(start)
- **Dimensions:** date
- **Data sources:** subscriptions
- **Parents:** [`rule_of_40`](#rule_of_40)
- **Children:** [`arr`](#arr), [`new_arr`](#new_arr), [`net_mrr_growth`](#net_mrr_growth), [`saas_quick_ratio`](#saas_quick_ratio)
- **Correlated:** [`revenue_growth_rate`](#revenue_growth_rate), [`nrr`](#nrr), [`net_new_customers`](#net_new_customers)

<a id="arr_per_rep"></a>
#### ARR / Sales Rep — `arr_per_rep`

Total ARR divided by number of quota-carrying reps

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/arr_per_rep.yml) · [sql](dbt/analyses/metrics/saas/arr_per_rep.sql)
- **Numerator:** Total ARR
- **Denominator:** Quota-carrying reps
- **Dimensions:** date
- **Data sources:** subscriptions, employees
- **Parents:** [`revenue_per_employee`](#revenue_per_employee)
- **Children:** [`arr`](#arr), [`sales_headcount`](#sales_headcount)
- **Correlated:** [`quota_attainment`](#quota_attainment), [`cac`](#cac), [`employees_per_1m_arr`](#employees_per_1m_arr), [`sales_headcount`](#sales_headcount)

<a id="bookings"></a>
#### Bookings — `bookings`

Total ARR value of contracts signed in the period, regardless of revenue recognition timing.

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/bookings.yml) · [sql](dbt/analyses/metrics/saas/bookings.sql)
- **Numerator:** SUM(contract ARR signed in period)
- **Dimensions:** segment, product_tier, channel, period
- **Data sources:** CRM, Finance
- **Parents:** [`arr`](#arr), [`avg_deal_size`](#avg_deal_size), [`avg_sales_cycle`](#avg_sales_cycle), [`new_arr`](#new_arr)
- **Children:** [`sql`](#sql)
- **Correlated:** [`arr`](#arr), [`new_arr`](#new_arr), [`revenue`](#revenue), [`committed_arr`](#committed_arr), [`pipeline_generated`](#pipeline_generated)

<a id="churn_prediction_score"></a>
#### Churn Prediction Score — `churn_prediction_score`

ML model score (0–1) indicating probability of a user churning in the next 30 days.

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/churn_prediction_score.yml) · [sql](dbt/analyses/metrics/saas/churn_prediction_score.sql)
- **Numerator:** Model output probability
- **Dimensions:** user_id, plan_tier, cohort, score_date
- **Data sources:** Product analytics, ML model output
- **Parents:** [`account_health_score`](#account_health_score)
- **Children:** [`dau`](#dau), [`feature_adoption_rate`](#feature_adoption_rate)
- **Correlated:** [`d30_retention`](#d30_retention), [`account_health_score`](#account_health_score)

<a id="churn_rate"></a>
#### Churn Rate — `churn_rate`

% of revenue or customers lost in a period.

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/churn_rate.yml) · [sql](dbt/analyses/metrics/saas/churn_rate.sql)
- **Numerator:** Lost ARR
- **Denominator:** Starting ARR
- **Dimensions:** cohort_month, plan_tier, geography, segment
- **Data sources:** Billing system, CRM
- **Parents:** [`arr`](#arr), [`nrr`](#nrr), [`customer_ltv`](#customer_ltv)
- **Children:** [`at_risk_accounts`](#at_risk_accounts), [`cohort_churn`](#cohort_churn), [`account_health_score`](#account_health_score), [`customer_churn_rate`](#customer_churn_rate), [`mrr_churn_rate`](#mrr_churn_rate)
- **Correlated:** [`ltv_cac`](#ltv_cac), [`account_health_score`](#account_health_score), [`arpu`](#arpu), [`at_risk_accounts`](#at_risk_accounts), [`cohort_revenue_retention`](#cohort_revenue_retention), [`csat`](#csat), [`customer_concentration_risk`](#customer_concentration_risk), [`customer_onboarding_time`](#customer_onboarding_time), [`d30_retention`](#d30_retention), [`error_rate`](#error_rate), [`customer_churn_rate`](#customer_churn_rate), [`mrr`](#mrr), [`new_arr`](#new_arr), [`nps`](#nps), [`nrr`](#nrr), [`onboarding_completion_rate`](#onboarding_completion_rate), [`cac_payback`](#cac_payback), [`renewal_rate`](#renewal_rate), [`tickets_created`](#tickets_created), [`time_to_value`](#time_to_value)

<a id="cohort_ltv_12m"></a>
#### 12-Month Cohort LTV — `cohort_ltv_12m`

Average cumulative revenue per customer 12 months after acquisition

- **Domain:** SaaS · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/saas/cohort_ltv_12m.yml) · [sql](dbt/analyses/metrics/saas/cohort_ltv_12m.sql)
- **Numerator:** Revenue per cohort member over 12 months
- **Dimensions:** date, cohort, channel
- **Data sources:** orders, customers
- **Parents:** [`clv`](#clv), [`cohort_ltv_24m`](#cohort_ltv_24m)
- **Children:** [`aov`](#aov), [`purchase_frequency`](#purchase_frequency)
- **Correlated:** [`cohort_ltv_24m`](#cohort_ltv_24m), [`d30_retention`](#d30_retention), [`clv`](#clv)

<a id="cohort_ltv_24m"></a>
#### 24-Month Cohort LTV — `cohort_ltv_24m`

Average cumulative revenue per customer 24 months after acquisition

- **Domain:** SaaS · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/saas/cohort_ltv_24m.yml) · [sql](dbt/analyses/metrics/saas/cohort_ltv_24m.sql)
- **Numerator:** Revenue per cohort member over 24 months
- **Dimensions:** date, cohort
- **Data sources:** orders, customers
- **Parents:** [`clv`](#clv)
- **Children:** [`cohort_ltv_12m`](#cohort_ltv_12m)
- **Correlated:** [`cohort_ltv_12m`](#cohort_ltv_12m), [`nrr`](#nrr)

<a id="cohort_revenue_retention"></a>
#### Cohort Revenue Retention — `cohort_revenue_retention`

Revenue retained from a signup cohort after N months relative to their initial value.

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/cohort_revenue_retention.yml) · [sql](dbt/analyses/metrics/saas/cohort_revenue_retention.sql)
- **Numerator:** Revenue from Cohort in Month N
- **Denominator:** Revenue from Cohort in Month 0
- **Dimensions:** cohort_month, month_number, segment
- **Data sources:** Billing system
- **Parents:** [`nrr`](#nrr)
- **Children:** [`mrr`](#mrr)
- **Correlated:** [`churn_rate`](#churn_rate), [`expansion_arr`](#expansion_arr)

<a id="customer_churn_rate"></a>
#### Customer Churn % — `customer_churn_rate`

Percentage of customers who stopped purchasing in the period

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/customer_churn_rate.yml) · [sql](dbt/analyses/metrics/saas/customer_churn_rate.sql)
- **Numerator:** Churned customers
- **Denominator:** Beginning customers
- **Dimensions:** date, customer_segment, segment, product_tier, period
- **Data sources:** crm, subscriptions
- **Parents:** [`clv`](#clv), [`customer_retention_rate`](#customer_retention_rate), [`net_new_customers`](#net_new_customers), [`churn_rate`](#churn_rate)
- **Correlated:** [`nrr`](#nrr), [`renewal_rate`](#renewal_rate), [`churned_arr`](#churned_arr), [`customer_count`](#customer_count), [`churn_rate`](#churn_rate), [`account_health_score`](#account_health_score), [`cohort_churn`](#cohort_churn), [`contraction_arr`](#contraction_arr), [`grr`](#grr), [`mrr_churn_rate`](#mrr_churn_rate), [`product_churn_rate`](#product_churn_rate)

<a id="customer_retention_rate"></a>
#### Customer Retention % — `customer_retention_rate`

Percentage of customers retained from one period to the next

- **Domain:** SaaS · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/saas/customer_retention_rate.yml) · [sql](dbt/analyses/metrics/saas/customer_retention_rate.sql)
- **Numerator:** 1 − churn rate
- **Dimensions:** date, customer_segment
- **Data sources:** crm
- **Parents:** [`clv`](#clv)
- **Children:** [`customer_churn_rate`](#customer_churn_rate)
- **Correlated:** [`nrr`](#nrr), [`renewal_rate`](#renewal_rate), [`repeat_purchase_rate`](#repeat_purchase_rate)

<a id="employees_per_1m_arr"></a>
#### Employees / $1M ARR — `employees_per_1m_arr`

Operational efficiency — fewer employees per $1M ARR indicates more scalable business

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/employees_per_1m_arr.yml) · [sql](dbt/analyses/metrics/saas/employees_per_1m_arr.sql)
- **Numerator:** Headcount
- **Denominator:** ARR ($M)
- **Dimensions:** date
- **Data sources:** subscriptions, employees
- **Parents:** [`revenue_per_employee`](#revenue_per_employee)
- **Children:** [`arr`](#arr)
- **Formula inputs:** [`headcount`](#headcount)
- **Correlated:** [`arr_per_rep`](#arr_per_rep), [`revenue_per_employee`](#revenue_per_employee)

<a id="expansion_arr"></a>
#### Expansion ARR — `expansion_arr`

ARR added from upsells and cross-sells to existing customers

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/expansion_arr.yml) · [sql](dbt/analyses/metrics/saas/expansion_arr.sql)
- **Parents:** [`arr`](#arr), [`nrr`](#nrr), [`saas_quick_ratio`](#saas_quick_ratio)
- **Children:** [`expansion_pipeline`](#expansion_pipeline), [`upsell_rate`](#upsell_rate)
- **Correlated:** [`cohort_revenue_retention`](#cohort_revenue_retention), [`feature_adoption_rate`](#feature_adoption_rate), [`new_arr`](#new_arr), [`rev_from_existing`](#rev_from_existing), [`upsell_rate`](#upsell_rate)

<a id="grr"></a>
#### GRR — `grr`

Retained ARR from existing customers excluding expansions

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/grr.yml) · [sql](dbt/analyses/metrics/saas/grr.sql)
- **Numerator:** Beginning ARR − churn − contraction
- **Denominator:** Beginning ARR
- **Dimensions:** date, customer_segment, segment
- **Data sources:** subscriptions
- **Parents:** [`nrr`](#nrr)
- **Children:** [`churned_arr`](#churned_arr), [`contraction_arr`](#contraction_arr)
- **Correlated:** [`nrr`](#nrr), [`customer_churn_rate`](#customer_churn_rate), [`arr`](#arr)

<a id="magic_number"></a>
#### Magic Number — `magic_number`

Net new ARR divided by prior quarter S&M spend — go-to-market efficiency

- **Domain:** SaaS · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/saas/magic_number.yml) · [sql](dbt/analyses/metrics/saas/magic_number.sql)
- **Numerator:** Net new ARR × 4
- **Denominator:** S&M spend (prior quarter)
- **Dimensions:** date
- **Data sources:** subscriptions, general_ledger
- **Parents:** [`rule_of_40`](#rule_of_40)
- **Children:** [`new_arr`](#new_arr), [`sm_spend`](#sm_spend)
- **Correlated:** [`cac_payback`](#cac_payback), [`cac`](#cac), [`ltv_cac`](#ltv_cac)

<a id="market_penetration_rate"></a>
#### Market Penetration Rate — `market_penetration_rate`

ARR as a % of Total Addressable Market — how much of the opportunity is captured.

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/market_penetration_rate.yml) · [sql](dbt/analyses/metrics/saas/market_penetration_rate.sql)
- **Numerator:** ARR
- **Denominator:** TAM
- **Dimensions:** segment, geography, period
- **Data sources:** Internal finance, Market research
- **Parents:** [`market_share`](#market_share)
- **Children:** [`arr`](#arr), [`tam`](#tam), [`sam`](#sam)
- **Correlated:** [`arr`](#arr), [`revenue_growth_rate`](#revenue_growth_rate)

<a id="mrr"></a>
#### MRR — `mrr`

Monthly Recurring Revenue — annualized base ÷ 12.

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/mrr.yml) · [sql](dbt/analyses/metrics/saas/mrr.sql)
- **Numerator:** SUM(monthly_amount) WHERE status = 'active'
- **Dimensions:** company_id, plan_tier, customer_id
- **Data sources:** Billing system
- **Parents:** [`arr`](#arr), [`revenue`](#revenue), [`mrr_churn_rate`](#mrr_churn_rate), [`cac_payback`](#cac_payback), [`subscription_revenue`](#subscription_revenue), [`cohort_revenue_retention`](#cohort_revenue_retention), [`customer_concentration_risk`](#customer_concentration_risk)
- **Correlated:** [`churn_rate`](#churn_rate), [`nrr`](#nrr), [`arr`](#arr), [`marketing_spend`](#marketing_spend), [`net_mrr_growth`](#net_mrr_growth)

<a id="mrr_churn_rate"></a>
#### MRR Churn % — `mrr_churn_rate`

Percentage of MRR lost in the period from cancellations

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/mrr_churn_rate.yml) · [sql](dbt/analyses/metrics/saas/mrr_churn_rate.sql)
- **Numerator:** Churned MRR
- **Denominator:** Beginning MRR
- **Dimensions:** date, customer_segment
- **Data sources:** subscriptions
- **Parents:** [`churn_rate`](#churn_rate)
- **Children:** [`mrr`](#mrr), [`churned_arr`](#churned_arr)
- **Correlated:** [`customer_churn_rate`](#customer_churn_rate), [`nrr`](#nrr)

<a id="net_mrr_growth"></a>
#### Net MRR Growth — `net_mrr_growth`

New + expansion MRR minus churned + contraction MRR

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/net_mrr_growth.yml) · [sql](dbt/analyses/metrics/saas/net_mrr_growth.sql)
- **Numerator:** MRR(end) − MRR(start)
- **Dimensions:** date
- **Data sources:** subscriptions
- **Parents:** [`arr_growth_rate`](#arr_growth_rate)
- **Correlated:** [`mrr`](#mrr), [`nrr`](#nrr), [`saas_quick_ratio`](#saas_quick_ratio)

<a id="net_new_customers"></a>
#### Net New Customers — `net_new_customers`

New customers acquired minus churned customers

- **Domain:** SaaS · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/saas/net_new_customers.yml) · [sql](dbt/analyses/metrics/saas/net_new_customers.sql)
- **Numerator:** New customers − Churned customers
- **Dimensions:** date, channel
- **Data sources:** crm, orders
- **Parents:** [`marketing_cac`](#marketing_cac)
- **Children:** [`monthly_new_customers`](#monthly_new_customers), [`customer_churn_rate`](#customer_churn_rate)
- **Correlated:** [`arr_growth_rate`](#arr_growth_rate), [`cac`](#cac), [`customer_count`](#customer_count)

<a id="new_arr"></a>
#### New ARR — `new_arr`

ARR added from new customer logos in the period

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/new_arr.yml) · [sql](dbt/analyses/metrics/saas/new_arr.sql)
- **Numerator:** ARR from new logos in period
- **Dimensions:** date, sales_rep, channel
- **Data sources:** subscriptions, opportunities
- **Parents:** [`arr`](#arr), [`arr_growth_rate`](#arr_growth_rate), [`magic_number`](#magic_number), [`saas_quick_ratio`](#saas_quick_ratio)
- **Children:** [`bookings`](#bookings), [`avg_deal_size`](#avg_deal_size), [`avg_sales_cycle`](#avg_sales_cycle), [`pct_reps_at_quota`](#pct_reps_at_quota), [`pipeline_coverage`](#pipeline_coverage), [`plg_rate`](#plg_rate), [`quota_attainment`](#quota_attainment), [`sales_cycle_length`](#sales_cycle_length), [`win_rate`](#win_rate)
- **Correlated:** [`expansion_arr`](#expansion_arr), [`churn_rate`](#churn_rate), [`acv`](#acv), [`bookings`](#bookings), [`monthly_new_customers`](#monthly_new_customers), [`partner_revenue`](#partner_revenue), [`pipeline_coverage`](#pipeline_coverage), [`pipeline_value`](#pipeline_value), [`quota_attainment`](#quota_attainment), [`rev_from_new_customers`](#rev_from_new_customers)

<a id="nrr"></a>
#### NRR — `nrr`

Beginning ARR plus expansion minus churn and contraction over beginning ARR

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/nrr.yml) · [sql](dbt/analyses/metrics/saas/nrr.sql)
- **Numerator:** Beginning ARR + expansion − contraction − churn
- **Denominator:** Beginning ARR
- **Dimensions:** date, customer_segment, company_id, period, plan_tier, segment
- **Data sources:** subscriptions
- **Parents:** [`rule_of_40`](#rule_of_40), [`arr`](#arr)
- **Children:** [`expansion_arr`](#expansion_arr), [`contraction_arr`](#contraction_arr), [`churned_arr`](#churned_arr), [`grr`](#grr), [`churn_rate`](#churn_rate), [`cohort_revenue_retention`](#cohort_revenue_retention), [`renewal_rate`](#renewal_rate)
- **Correlated:** [`grr`](#grr), [`customer_churn_rate`](#customer_churn_rate), [`account_health_score`](#account_health_score), [`arr`](#arr), [`arr_growth_rate`](#arr_growth_rate), [`clv`](#clv), [`cohort_ltv_24m`](#cohort_ltv_24m), [`customer_retention_rate`](#customer_retention_rate), [`expansion_pipeline`](#expansion_pipeline), [`mrr_churn_rate`](#mrr_churn_rate), [`net_mrr_growth`](#net_mrr_growth), [`rev_concentration_top10`](#rev_concentration_top10), [`rev_from_existing`](#rev_from_existing), [`saas_quick_ratio`](#saas_quick_ratio), [`subscription_revenue`](#subscription_revenue), [`upsell_rate`](#upsell_rate), [`ebitda`](#ebitda), [`ltv_cac`](#ltv_cac), [`customer_ltv`](#customer_ltv), [`mrr`](#mrr), [`rule_of_40`](#rule_of_40), [`churn_rate`](#churn_rate), [`renewal_rate`](#renewal_rate)

<a id="renewal_rate"></a>
#### Renewal Rate — `renewal_rate`

% of up-for-renewal contracts that successfully renew.

- **Domain:** SaaS · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/saas/renewal_rate.yml) · [sql](dbt/analyses/metrics/saas/renewal_rate.sql)
- **Numerator:** Contracts Renewed
- **Denominator:** Contracts Up for Renewal
- **Dimensions:** segment, plan_tier, cs_rep_id, period
- **Data sources:** CRM, Billing system
- **Parents:** [`nrr`](#nrr), [`account_health_score`](#account_health_score)
- **Children:** [`qbr_completion_rate`](#qbr_completion_rate)
- **Correlated:** [`nrr`](#nrr), [`churn_rate`](#churn_rate), [`at_risk_accounts`](#at_risk_accounts), [`customer_churn_rate`](#customer_churn_rate), [`customer_retention_rate`](#customer_retention_rate), [`qbr_completion_rate`](#qbr_completion_rate)

<a id="saas_quick_ratio"></a>
#### SaaS Quick Ratio — `saas_quick_ratio`

New + expansion ARR divided by churned + contraction ARR — growth efficiency

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/saas_quick_ratio.yml) · [sql](dbt/analyses/metrics/saas/saas_quick_ratio.sql)
- **Numerator:** New ARR + Expansion ARR
- **Denominator:** Contraction ARR + Churned ARR
- **Dimensions:** date
- **Data sources:** subscriptions
- **Parents:** [`arr_growth_rate`](#arr_growth_rate)
- **Children:** [`new_arr`](#new_arr), [`expansion_arr`](#expansion_arr), [`contraction_arr`](#contraction_arr), [`churned_arr`](#churned_arr)
- **Correlated:** [`nrr`](#nrr), [`rule_of_40`](#rule_of_40), [`arr`](#arr), [`net_mrr_growth`](#net_mrr_growth)

<a id="upsell_rate"></a>
#### Upsell Rate — `upsell_rate`

% of existing customers who expanded to a higher tier or added seats.

- **Domain:** SaaS · **Industry:** education
- **Files:** [yml](dbt/models/metrics/saas/upsell_rate.yml) · [sql](dbt/analyses/metrics/saas/upsell_rate.sql)
- **Numerator:** Upsell events
- **Denominator:** Total customers
- **Dimensions:** date, product
- **Data sources:** crm, orders
- **Parents:** [`expansion_arr`](#expansion_arr)
- **Correlated:** [`cross_sell_rate`](#cross_sell_rate), [`expansion_arr`](#expansion_arr), [`nrr`](#nrr), [`expansion_pipeline`](#expansion_pipeline)

### KPI · Sales (18)

<a id="avg_deal_size"></a>
#### Avg Deal Size — `avg_deal_size`

Average ARR value of closed-won opportunities in the period.

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/avg_deal_size.yml) · [sql](dbt/analyses/metrics/sales/avg_deal_size.sql)
- **Numerator:** Total bookings value
- **Denominator:** Number of deals closed
- **Dimensions:** date, sales_rep, segment
- **Data sources:** opportunities
- **Parents:** [`new_arr`](#new_arr), [`pipeline_generated`](#pipeline_generated)
- **Children:** [`bookings`](#bookings)
- **Correlated:** [`acv`](#acv), [`pipeline_coverage`](#pipeline_coverage), [`competitive_win_rate`](#competitive_win_rate)

<a id="avg_sales_cycle"></a>
#### Sales Cycle (days) — `avg_sales_cycle`

Average days from opportunity creation to close

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/avg_sales_cycle.yml) · [sql](dbt/analyses/metrics/sales/avg_sales_cycle.sql)
- **Numerator:** Sum of sales cycle days
- **Denominator:** Closed opportunities
- **Dimensions:** date, segment, product
- **Data sources:** crm
- **Parents:** [`new_arr`](#new_arr)
- **Children:** [`sql`](#sql), [`bookings`](#bookings)
- **Correlated:** [`win_rate`](#win_rate), [`cac_payback`](#cac_payback)

<a id="expansion_pipeline"></a>
#### Expansion Pipeline — `expansion_pipeline`

Total potential expansion ARR in open upsell opportunities

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/expansion_pipeline.yml) · [sql](dbt/analyses/metrics/sales/expansion_pipeline.sql)
- **Numerator:** Pipeline value from expansion opportunities
- **Dimensions:** date, csm
- **Data sources:** crm
- **Parents:** [`expansion_arr`](#expansion_arr)
- **Correlated:** [`upsell_rate`](#upsell_rate), [`nrr`](#nrr), [`at_risk_accounts`](#at_risk_accounts)

<a id="lead_to_mql_rate"></a>
#### Lead → MQL % — `lead_to_mql_rate`

Percentage of leads that reach MQL threshold

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/lead_to_mql_rate.yml) · [sql](dbt/analyses/metrics/sales/lead_to_mql_rate.sql)
- **Numerator:** MQLs
- **Denominator:** All leads
- **Dimensions:** date, channel
- **Data sources:** marketing_automation, crm
- **Parents:** [`mql`](#mql)
- **Children:** [`leads`](#leads)
- **Correlated:** [`mql_to_sql_rate`](#mql_to_sql_rate), [`form_conversion_rate`](#form_conversion_rate), [`mql`](#mql)

<a id="marketing_influenced_pipeline"></a>
#### Mktg Influenced Pipeline — `marketing_influenced_pipeline`

Total pipeline ARR where marketing had at least one touchpoint before opportunity creation.

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/marketing_influenced_pipeline.yml) · [sql](dbt/analyses/metrics/sales/marketing_influenced_pipeline.sql)
- **Numerator:** SUM(arr_value of influenced opportunities)
- **Dimensions:** channel, campaign, segment, period
- **Data sources:** CRM, Attribution model
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Correlated:** [`pipeline_value`](#pipeline_value), [`roas`](#roas)

<a id="mql"></a>
#### MQLs — `mql`

Leads meeting scoring threshold passed to sales

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/mql.yml) · [sql](dbt/analyses/metrics/sales/mql.sql)
- **Numerator:** Leads meeting MQL criteria in period
- **Dimensions:** date, channel, campaign, source, period
- **Data sources:** crm, marketing_automation
- **Parents:** [`pipeline_generated`](#pipeline_generated), [`sql`](#sql), [`cac`](#cac), [`mql_to_sql_rate`](#mql_to_sql_rate)
- **Children:** [`leads`](#leads), [`form_conversion_rate`](#form_conversion_rate), [`demo_requests`](#demo_requests), [`event_attendees`](#event_attendees), [`lead_to_mql_rate`](#lead_to_mql_rate), [`session_to_lead_rate`](#session_to_lead_rate), [`webinar_attendance_rate`](#webinar_attendance_rate), [`email_click_rate`](#email_click_rate), [`unsubscribe_rate`](#unsubscribe_rate), [`web_conversion_rate`](#web_conversion_rate)
- **Correlated:** [`sql`](#sql), [`lead_to_mql_rate`](#lead_to_mql_rate), [`demo_requests`](#demo_requests), [`event_attendees`](#event_attendees), [`pipeline_generated`](#pipeline_generated), [`leads`](#leads), [`webinar_registrants`](#webinar_registrants), [`cost_per_mql`](#cost_per_mql), [`content_published_count`](#content_published_count), [`new_user_signups`](#new_user_signups), [`website_sessions`](#website_sessions)

<a id="mql_to_sql_rate"></a>
#### MQL→SQL Rate — `mql_to_sql_rate`

% of MQLs that convert to SQLs — marketing-to-sales handoff quality.

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/mql_to_sql_rate.yml) · [sql](dbt/analyses/metrics/sales/mql_to_sql_rate.sql)
- **Numerator:** SQLs
- **Denominator:** MQLs
- **Dimensions:** channel, campaign, period
- **Data sources:** CRM, Marketing automation
- **Parents:** [`sql`](#sql)
- **Children:** [`mql`](#mql)
- **Correlated:** [`win_rate`](#win_rate), [`cac`](#cac), [`lead_to_mql_rate`](#lead_to_mql_rate), [`sql`](#sql)

<a id="organic_attribution_pct"></a>
#### Organic Attribution % — `organic_attribution_pct`

Percentage of closed revenue attributed to organic channels

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/organic_attribution_pct.yml) · [sql](dbt/analyses/metrics/sales/organic_attribution_pct.sql)
- **Numerator:** Organic-attributed pipeline
- **Denominator:** Total pipeline
- **Dimensions:** date
- **Data sources:** analytics, crm
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Children:** [`organic_sessions`](#organic_sessions)
- **Formula inputs:** [`mql`](#mql)
- **Correlated:** [`paid_attribution_pct`](#paid_attribution_pct), [`referral_attribution_pct`](#referral_attribution_pct)

<a id="paid_attribution_pct"></a>
#### Paid Attribution % — `paid_attribution_pct`

Percentage of closed revenue attributed to paid channels

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/paid_attribution_pct.yml) · [sql](dbt/analyses/metrics/sales/paid_attribution_pct.sql)
- **Numerator:** Paid-attributed pipeline
- **Denominator:** Total pipeline
- **Dimensions:** date, channel
- **Data sources:** ad_platforms, crm
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Formula inputs:** [`mql`](#mql)
- **Correlated:** [`organic_attribution_pct`](#organic_attribution_pct), [`roas`](#roas)

<a id="pct_reps_at_quota"></a>
#### % Reps at Quota — `pct_reps_at_quota`

% of sales reps who hit or exceeded their quota — team productivity signal.

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/pct_reps_at_quota.yml) · [sql](dbt/analyses/metrics/sales/pct_reps_at_quota.sql)
- **Numerator:** Reps at or above quota
- **Denominator:** Total Active Reps
- **Dimensions:** segment, team, period
- **Data sources:** CRM, Finance
- **Parents:** [`new_arr`](#new_arr)
- **Children:** [`quota_attainment`](#quota_attainment)
- **Correlated:** [`quota_attainment`](#quota_attainment), [`win_rate`](#win_rate)

<a id="pipeline_coverage"></a>
#### Pipeline Coverage — `pipeline_coverage`

Total qualified pipeline divided by quota — leading indicator of quota achievement.

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/pipeline_coverage.yml) · [sql](dbt/analyses/metrics/sales/pipeline_coverage.sql)
- **Numerator:** Qualified Pipeline Value
- **Denominator:** Remaining Quota for Period
- **Dimensions:** team, segment, period
- **Data sources:** CRM
- **Parents:** [`new_arr`](#new_arr)
- **Children:** [`pipeline_value`](#pipeline_value), [`quota_attainment`](#quota_attainment)
- **Correlated:** [`win_rate`](#win_rate), [`new_arr`](#new_arr), [`avg_deal_size`](#avg_deal_size), [`pipeline_generated`](#pipeline_generated)

<a id="pipeline_value"></a>
#### Pipeline Value — `pipeline_value`

Total ARR value of open opportunities in the pipeline.

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/pipeline_value.yml) · [sql](dbt/analyses/metrics/sales/pipeline_value.sql)
- **Numerator:** SUM(arr_value) WHERE stage NOT IN ('Closed Won','Closed Lost')
- **Dimensions:** segment, stage, rep_id, period
- **Data sources:** CRM
- **Parents:** [`pipeline_coverage`](#pipeline_coverage)
- **Children:** [`sql`](#sql)
- **Correlated:** [`new_arr`](#new_arr), [`win_rate`](#win_rate), [`marketing_influenced_pipeline`](#marketing_influenced_pipeline)

<a id="quota_attainment"></a>
#### Quota Attainment — `quota_attainment`

Sales rep ARR closed as a % of their assigned quota.

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/quota_attainment.yml) · [sql](dbt/analyses/metrics/sales/quota_attainment.sql)
- **Numerator:** ARR Closed
- **Denominator:** Quota
- **Dimensions:** rep_id, segment, period
- **Data sources:** CRM, Finance
- **Parents:** [`new_arr`](#new_arr), [`pct_reps_at_quota`](#pct_reps_at_quota), [`pipeline_coverage`](#pipeline_coverage)
- **Correlated:** [`win_rate`](#win_rate), [`new_arr`](#new_arr), [`arr_per_rep`](#arr_per_rep), [`pct_reps_at_quota`](#pct_reps_at_quota), [`sales_headcount`](#sales_headcount)

<a id="referral_attribution_pct"></a>
#### Referral Attribution % — `referral_attribution_pct`

Percentage of closed revenue attributed to referral channels

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/referral_attribution_pct.yml) · [sql](dbt/analyses/metrics/sales/referral_attribution_pct.sql)
- **Numerator:** Referral-attributed pipeline
- **Denominator:** Total pipeline
- **Dimensions:** date
- **Data sources:** crm, referrals
- **Parents:** [`marketing_roi`](#marketing_roi)
- **Formula inputs:** [`mql`](#mql)
- **Correlated:** [`organic_attribution_pct`](#organic_attribution_pct), [`viral_coefficient`](#viral_coefficient)

<a id="sales_cycle_length"></a>
#### Sales Cycle Length — `sales_cycle_length`

Average days from first touch to closed-won opportunity.

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/sales_cycle_length.yml) · [sql](dbt/analyses/metrics/sales/sales_cycle_length.sql)
- **Numerator:** SUM(days_to_close)
- **Denominator:** COUNT(closed_won_opportunities)
- **Dimensions:** segment, rep_id, deal_size_tier, period
- **Data sources:** CRM (Salesforce / HubSpot)
- **Parents:** [`new_arr`](#new_arr)
- **Correlated:** [`cac`](#cac), [`win_rate`](#win_rate)

<a id="sales_spend"></a>
#### Sales Spend — `sales_spend`

Total sales team costs including salaries, commissions, and tools.

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/sales_spend.yml) · [sql](dbt/analyses/metrics/sales/sales_spend.sql)
- **Numerator:** SUM(sales team headcount cost + tools)
- **Dimensions:** company_id, team, fiscal_period
- **Data sources:** HRIS, ERP
- **Parents:** [`cac`](#cac), [`sg_and_a`](#sg_and_a)
- **Correlated:** [`marketing_spend`](#marketing_spend), [`cac`](#cac)

<a id="sql"></a>
#### SQLs — `sql`

Leads accepted by sales as qualified opportunities

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/sql.yml) · [sql](dbt/analyses/metrics/sales/sql.sql)
- **Numerator:** Opportunities accepted by sales
- **Dimensions:** date, sales_rep, channel, campaign, segment, period
- **Data sources:** crm
- **Parents:** [`pipeline_generated`](#pipeline_generated), [`bookings`](#bookings), [`avg_sales_cycle`](#avg_sales_cycle), [`pipeline_value`](#pipeline_value), [`cost_per_sql`](#cost_per_sql)
- **Children:** [`mql`](#mql), [`mql_to_sql_rate`](#mql_to_sql_rate)
- **Correlated:** [`mql`](#mql), [`win_rate`](#win_rate), [`demo_requests`](#demo_requests), [`mql_to_sql_rate`](#mql_to_sql_rate)

<a id="win_rate"></a>
#### Win Rate — `win_rate`

% of qualified opportunities that close as won.

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/win_rate.yml) · [sql](dbt/analyses/metrics/sales/win_rate.sql)
- **Numerator:** Closed Won Opportunities
- **Denominator:** Total Qualified Opportunities
- **Dimensions:** segment, rep_id, source, period
- **Data sources:** CRM
- **Parents:** [`new_arr`](#new_arr)
- **Children:** [`competitive_win_rate`](#competitive_win_rate)
- **Correlated:** [`sales_cycle_length`](#sales_cycle_length), [`cac`](#cac), [`avg_sales_cycle`](#avg_sales_cycle), [`competitive_win_rate`](#competitive_win_rate), [`mql_to_sql_rate`](#mql_to_sql_rate), [`pct_reps_at_quota`](#pct_reps_at_quota), [`pipeline_coverage`](#pipeline_coverage), [`pipeline_value`](#pipeline_value), [`quota_attainment`](#quota_attainment), [`sql`](#sql)

## Input (87)

### Input · Commerce (8)

<a id="discount_rate"></a>
#### Discount Rate — `discount_rate`

Percentage of gross revenue given away as discounts

- **Domain:** Commerce · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/commerce/discount_rate.yml) · [sql](dbt/analyses/metrics/commerce/discount_rate.sql)
- **Numerator:** Total discounts given
- **Denominator:** Gross revenue
- **Dimensions:** date, product
- **Data sources:** orders
- **Parents:** [`net_revenue`](#net_revenue)
- **Correlated:** [`gross_revenue`](#gross_revenue), [`aov`](#aov)

<a id="gross_revenue"></a>
#### Gross Revenue — `gross_revenue`

Total revenue before any discounts or returns

- **Domain:** Commerce · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/commerce/gross_revenue.yml) · [sql](dbt/analyses/metrics/commerce/gross_revenue.sql)
- **Numerator:** Sum of gross order amounts
- **Dimensions:** date, channel
- **Data sources:** orders
- **Parents:** [`revenue`](#revenue), [`net_revenue`](#net_revenue), [`aov`](#aov)
- **Correlated:** [`net_revenue`](#net_revenue), [`discount_rate`](#discount_rate), [`aov`](#aov)

<a id="inventory_items"></a>
#### Inventory Items — `inventory_items`

Distinct SKUs with an inventory snapshot in the period

- **Domain:** Commerce · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/commerce/inventory_items.yml) · [sql](dbt/analyses/metrics/commerce/inventory_items.sql)
- **Numerator:** Distinct SKUs in inventory
- **Dimensions:** date, product, location
- **Data sources:** inventory
- **Parents:** [`inventory_turnover`](#inventory_turnover), [`stockout_rate`](#stockout_rate)
- **Correlated:** [`inventory_turnover`](#inventory_turnover), [`stockout_rate`](#stockout_rate)

<a id="inventory_value"></a>
#### Inventory Value — `inventory_value`

Total cost basis of inventory on hand

- **Domain:** Commerce · **Industry:** manufacturing
- **Files:** [yml](dbt/models/metrics/commerce/inventory_value.yml) · [sql](dbt/analyses/metrics/commerce/inventory_value.sql)
- **Numerator:** Units on hand × unit cost
- **Dimensions:** date, product
- **Data sources:** inventory
- **Parents:** [`inventory_turnover`](#inventory_turnover)
- **Correlated:** [`inventory_turnover`](#inventory_turnover), [`shrinkage_rate`](#shrinkage_rate), [`warehouse_utilization`](#warehouse_utilization), [`cogs`](#cogs)

<a id="marketplace_buyers"></a>
#### Active Buyers — `marketplace_buyers`

Number of unique buyers transacting in the period

- **Domain:** Commerce · **Industry:** marketplace
- **Files:** [yml](dbt/models/metrics/commerce/marketplace_buyers.yml) · [sql](dbt/analyses/metrics/commerce/marketplace_buyers.sql)
- **Numerator:** Active buyers in period
- **Dimensions:** date
- **Data sources:** marketplace
- **Parents:** [`gmv`](#gmv)
- **Correlated:** [`marketplace_sellers`](#marketplace_sellers), [`aov`](#aov)

<a id="marketplace_sellers"></a>
#### Active Sellers — `marketplace_sellers`

Number of active sellers transacting on the platform in the period

- **Domain:** Commerce · **Industry:** marketplace
- **Files:** [yml](dbt/models/metrics/commerce/marketplace_sellers.yml) · [sql](dbt/analyses/metrics/commerce/marketplace_sellers.sql)
- **Numerator:** Active sellers in period
- **Dimensions:** date
- **Data sources:** marketplace
- **Parents:** [`gmv`](#gmv)
- **Correlated:** [`marketplace_buyers`](#marketplace_buyers), [`take_rate`](#take_rate), [`liquidity_rate`](#liquidity_rate)

<a id="order_lines"></a>
#### Order Lines — `order_lines`

Order lines placed in the period

- **Domain:** Commerce · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/commerce/order_lines.yml) · [sql](dbt/analyses/metrics/commerce/order_lines.sql)
- **Numerator:** Order lines
- **Dimensions:** order_id, line_id, product_id, qty_ordered, qty_shipped, warehouse_id
- **Data sources:** ERP, WMS
- **Parents:** [`fill_rate`](#fill_rate)

<a id="shrinkage_rate"></a>
#### Shrinkage Rate — `shrinkage_rate`

Inventory lost to theft, damage, or administrative error as a percentage of stock

- **Domain:** Commerce · **Industry:** retail
- **Files:** [yml](dbt/models/metrics/commerce/shrinkage_rate.yml) · [sql](dbt/analyses/metrics/commerce/shrinkage_rate.sql)
- **Numerator:** Inventory shrinkage
- **Denominator:** Beginning inventory value
- **Dimensions:** date, location
- **Data sources:** inventory
- **Parents:** [`cogs`](#cogs)
- **Correlated:** [`inventory_value`](#inventory_value), [`vendor_compliance_rate`](#vendor_compliance_rate)

### Input · Customer (4)

<a id="complaints_count"></a>
#### Complaints — `complaints_count`

Total formal complaints received in the period

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/complaints_count.yml) · [sql](dbt/analyses/metrics/customer/complaints_count.sql)
- **Numerator:** Formal complaints received
- **Dimensions:** date
- **Data sources:** crm
- **Parents:** [`cx_csat`](#cx_csat)
- **Correlated:** [`complaint_resolution_rate`](#complaint_resolution_rate), [`csat`](#csat)

<a id="monthly_new_customers"></a>
#### Monthly New Customers — `monthly_new_customers`

Number of new unique paying customers acquired in the month

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/monthly_new_customers.yml) · [sql](dbt/analyses/metrics/customer/monthly_new_customers.sql)
- **Numerator:** New customers acquired in month
- **Dimensions:** date, channel, acquisition_channel, segment, period
- **Data sources:** crm, orders
- **Parents:** [`net_new_customers`](#net_new_customers), [`cac`](#cac), [`customer_count`](#customer_count)
- **Children:** [`leads`](#leads)
- **Correlated:** [`cac`](#cac), [`revenue_growth_rate`](#revenue_growth_rate), [`new_arr`](#new_arr)

<a id="tickets_created"></a>
#### Tickets Created — `tickets_created`

Total new support tickets opened in the period

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/tickets_created.yml) · [sql](dbt/analyses/metrics/customer/tickets_created.sql)
- **Numerator:** Support tickets opened
- **Dimensions:** date, priority, category, channel, product, period
- **Data sources:** helpdesk
- **Parents:** [`tickets_per_customer`](#tickets_per_customer), [`escalation_rate`](#escalation_rate), [`fcr_rate`](#fcr_rate), [`time_to_resolution`](#time_to_resolution), [`tickets_per_agent`](#tickets_per_agent), [`first_response_time`](#first_response_time), [`ticket_resolution_rate`](#ticket_resolution_rate)
- **Correlated:** [`time_to_resolution`](#time_to_resolution), [`sla_breach_rate`](#sla_breach_rate), [`first_response_time`](#first_response_time), [`fcr_rate`](#fcr_rate), [`csat`](#csat), [`churn_rate`](#churn_rate)

<a id="tickets_resolved"></a>
#### Tickets Resolved — `tickets_resolved`

Total support tickets closed in the period

- **Domain:** Customer · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/customer/tickets_resolved.yml) · [sql](dbt/analyses/metrics/customer/tickets_resolved.sql)
- **Numerator:** Support tickets closed
- **Dimensions:** date
- **Data sources:** helpdesk
- **Parents:** [`support_cost_per_ticket`](#support_cost_per_ticket)
- **Correlated:** [`fcr_rate`](#fcr_rate), [`support_cost_per_ticket`](#support_cost_per_ticket)

### Input · Education (10)

<a id="adm"></a>
#### ADM — `adm`

Average number of students enrolled per day (used for funding calculations)

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/adm.yml) · [sql](dbt/analyses/metrics/education/adm.sql)
- **Numerator:** Average daily membership
- **Dimensions:** school_year
- **Data sources:** attendance
- **Parents:** [`student_attendance_rate`](#student_attendance_rate)
- **Correlated:** [`enrollment_count`](#enrollment_count), [`per_pupil_expenditure`](#per_pupil_expenditure)

<a id="avg_teacher_experience"></a>
#### Avg Teacher Exp (yrs) — `avg_teacher_experience`

Average years of teaching experience across the teaching staff

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/avg_teacher_experience.yml) · [sql](dbt/analyses/metrics/education/avg_teacher_experience.sql)
- **Numerator:** Average years of teaching experience
- **Dimensions:** school_year, school
- **Data sources:** hris
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`teacher_retention_rate`](#teacher_retention_rate), [`ela_proficiency_rate`](#ela_proficiency_rate)

<a id="ell_pct"></a>
#### ELL Students % — `ell_pct`

Percentage of enrolled students classified as English Language Learners

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/ell_pct.yml) · [sql](dbt/analyses/metrics/education/ell_pct.sql)
- **Numerator:** English Language Learner students
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school
- **Data sources:** enrollment
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`ela_proficiency_rate`](#ela_proficiency_rate), [`chronic_absenteeism_rate`](#chronic_absenteeism_rate)

<a id="expulsion_rate"></a>
#### Expulsion Rate — `expulsion_rate`

Percentage of students expelled during the school year

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/expulsion_rate.yml) · [sql](dbt/analyses/metrics/education/expulsion_rate.sql)
- **Numerator:** Students expelled
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school
- **Data sources:** discipline
- **Parents:** [`suspension_rate`](#suspension_rate)
- **Correlated:** [`suspension_rate`](#suspension_rate), [`dropout_rate`](#dropout_rate)

<a id="extracurricular_rate"></a>
#### Extracurricular % — `extracurricular_rate`

Percentage of students participating in at least one extracurricular activity

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/extracurricular_rate.yml) · [sql](dbt/analyses/metrics/education/extracurricular_rate.sql)
- **Numerator:** Students in extracurriculars
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school
- **Data sources:** extracurricular
- **Parents:** [`school_climate_score`](#school_climate_score)
- **Correlated:** [`school_climate_score`](#school_climate_score), [`student_attendance_rate`](#student_attendance_rate)

<a id="family_engagement_rate"></a>
#### Family Engagement % — `family_engagement_rate`

Percentage of families attending at least one school event or conference

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/family_engagement_rate.yml) · [sql](dbt/analyses/metrics/education/family_engagement_rate.sql)
- **Numerator:** Families attending events or conferences
- **Denominator:** Total families
- **Dimensions:** school_year, school
- **Data sources:** family_engagement_log
- **Parents:** [`school_climate_score`](#school_climate_score)
- **Correlated:** [`school_climate_score`](#school_climate_score), [`student_attendance_rate`](#student_attendance_rate)

<a id="frl_pct"></a>
#### FRL % — `frl_pct`

Percentage of students eligible for free or reduced-price lunch (socioeconomic indicator)

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/frl_pct.yml) · [sql](dbt/analyses/metrics/education/frl_pct.sql)
- **Numerator:** Free/reduced-price lunch eligible students
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school
- **Data sources:** enrollment
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`iep_pct`](#iep_pct), [`chronic_absenteeism_rate`](#chronic_absenteeism_rate), [`per_pupil_expenditure`](#per_pupil_expenditure)

<a id="iep_pct"></a>
#### IEP Students % — `iep_pct`

Percentage of enrolled students with an Individualized Education Program

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/iep_pct.yml) · [sql](dbt/analyses/metrics/education/iep_pct.sql)
- **Numerator:** Students with IEPs
- **Denominator:** Enrolled students
- **Dimensions:** school_year, school
- **Data sources:** special_education
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`per_pupil_expenditure`](#per_pupil_expenditure), [`ela_proficiency_rate`](#ela_proficiency_rate), [`frl_pct`](#frl_pct)

<a id="instructional_minutes"></a>
#### Instructional Minutes — `instructional_minutes`

Average minutes of scheduled instruction delivered per student per school day.

- **Domain:** Education · **Industry:** education
- **Files:** [yml](dbt/models/metrics/education/instructional_minutes.yml) · [sql](dbt/analyses/metrics/education/instructional_minutes.sql)
- **Numerator:** Scheduled instructional minutes delivered
- **Denominator:** Student school days
- **Dimensions:** school_year, school, grade_level
- **Data sources:** SIS, class_schedules
- **Parents:** [`student_proficiency`](#student_proficiency)

<a id="on_time_lesson_delivery"></a>
#### On-Time Lesson Delivery — `on_time_lesson_delivery`

% of planned lessons delivered on schedule per teacher or classroom.

- **Domain:** Education · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/education/on_time_lesson_delivery.yml) · [sql](dbt/analyses/metrics/education/on_time_lesson_delivery.sql)
- **Numerator:** Lessons Delivered on Time
- **Denominator:** Total Lessons Planned
- **Dimensions:** teacher_id, school_id, subject, period
- **Data sources:** Curriculum management system
- **Parents:** [`student_proficiency`](#student_proficiency)
- **Correlated:** [`teacher_retention_rate`](#teacher_retention_rate), [`student_attendance_rate`](#student_attendance_rate)

### Input · Engineering (5)

<a id="code_coverage"></a>
#### Code Coverage % — `code_coverage`

Percentage of codebase covered by automated tests

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/code_coverage.yml) · [sql](dbt/analyses/metrics/engineering/code_coverage.sql)
- **Numerator:** Lines covered by tests
- **Denominator:** Total lines
- **Dimensions:** date, service
- **Data sources:** ci_cd
- **Parents:** [`bug_escape_rate`](#bug_escape_rate)
- **Correlated:** [`bug_escape_rate`](#bug_escape_rate), [`change_failure_rate`](#change_failure_rate), [`tech_debt_ratio`](#tech_debt_ratio)

<a id="incident_count"></a>
#### Incident Count — `incident_count`

Total production or safety incidents in the period

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/incident_count.yml) · [sql](dbt/analyses/metrics/engineering/incident_count.sql)
- **Numerator:** Production/safety incidents in period
- **Dimensions:** date
- **Data sources:** incident_management
- **Parents:** [`mttd`](#mttd), [`mttr`](#mttr), [`uptime`](#uptime)
- **Correlated:** [`mttr`](#mttr), [`mttd`](#mttd), [`rcr_rate`](#rcr_rate)

<a id="oss_stars"></a>
#### OSS Stars — `oss_stars`

GitHub stars on the company's primary open source repositories

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/oss_stars.yml) · [sql](dbt/analyses/metrics/engineering/oss_stars.sql)
- **Numerator:** GitHub stars on public repositories
- **Dimensions:** date, repo
- **Data sources:** github
- **Parents:** [`viral_coefficient`](#viral_coefficient)
- **Correlated:** [`domain_authority`](#domain_authority), [`viral_coefficient`](#viral_coefficient)

<a id="pr_merge_time"></a>
#### PR Merge Time — `pr_merge_time`

Average hours from PR opening to merge

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/pr_merge_time.yml) · [sql](dbt/analyses/metrics/engineering/pr_merge_time.sql)
- **Numerator:** Time from PR open to merge (hours)
- **Dimensions:** date, team
- **Data sources:** git
- **Parents:** [`lead_time_for_changes`](#lead_time_for_changes)
- **Correlated:** [`deployment_frequency`](#deployment_frequency), [`sprint_velocity`](#sprint_velocity)

<a id="sprint_velocity"></a>
#### Sprint Velocity — `sprint_velocity`

Average story points completed per two-week sprint

- **Domain:** Engineering · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/engineering/sprint_velocity.yml) · [sql](dbt/analyses/metrics/engineering/sprint_velocity.sql)
- **Numerator:** Story points completed per sprint
- **Dimensions:** date, team
- **Data sources:** project_management
- **Parents:** [`deployment_frequency`](#deployment_frequency)
- **Correlated:** [`deployment_frequency`](#deployment_frequency), [`tech_debt_ratio`](#tech_debt_ratio), [`pr_merge_time`](#pr_merge_time)

### Input · Finance (20)

<a id="accounts_payable"></a>
#### Accounts Payable — `accounts_payable`

Outstanding amounts owed to vendors

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/accounts_payable.yml) · [sql](dbt/analyses/metrics/finance/accounts_payable.sql)
- **Numerator:** Outstanding vendor invoices
- **Dimensions:** date
- **Data sources:** purchase_orders
- **Parents:** [`current_ratio`](#current_ratio), [`dpo`](#dpo), [`working_capital`](#working_capital)
- **Correlated:** [`dpo`](#dpo), [`working_capital`](#working_capital)

<a id="accounts_receivable"></a>
#### Accounts Receivable — `accounts_receivable`

Outstanding invoices owed to the company

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/accounts_receivable.yml) · [sql](dbt/analyses/metrics/finance/accounts_receivable.sql)
- **Numerator:** Outstanding customer invoices
- **Dimensions:** date
- **Data sources:** invoices
- **Parents:** [`current_ratio`](#current_ratio), [`dso`](#dso), [`working_capital`](#working_capital)
- **Correlated:** [`dso`](#dso), [`billings`](#billings)

<a id="annual_budget"></a>
#### Annual Budget — `annual_budget`

Total approved budget for the fiscal year

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/annual_budget.yml) · [sql](dbt/analyses/metrics/finance/annual_budget.sql)
- **Numerator:** Approved annual budget
- **Dimensions:** date
- **Data sources:** budgets
- **Parents:** [`budget_variance`](#budget_variance), [`forecast_accuracy`](#forecast_accuracy), [`headcount_vs_budget`](#headcount_vs_budget)
- **Correlated:** [`budget_variance`](#budget_variance), [`opex`](#opex)

<a id="cash_and_equivalents"></a>
#### Cash & Equivalents — `cash_and_equivalents`

Cash on hand and liquid short-term instruments

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/cash_and_equivalents.yml) · [sql](dbt/analyses/metrics/finance/cash_and_equivalents.sql)
- **Numerator:** Cash on balance sheet
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`current_ratio`](#current_ratio), [`net_debt`](#net_debt), [`working_capital`](#working_capital)
- **Correlated:** [`burn_rate`](#burn_rate), [`runway_months`](#runway_months), [`dso`](#dso)

<a id="da"></a>
#### D&A — `da`

Non-cash charges for the period

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/da.yml) · [sql](dbt/analyses/metrics/finance/da.sql)
- **Numerator:** Depreciation + amortization
- **Dimensions:** date
- **Data sources:** fixed_assets
- **Parents:** [`ebitda`](#ebitda), [`operating_cash_flow`](#operating_cash_flow)
- **Correlated:** [`capex`](#capex), [`free_cash_flow`](#free_cash_flow)

<a id="ebitda_bridge_price"></a>
#### EBITDA Bridge: Price — `ebitda_bridge_price`

Price/mix contribution to EBITDA variance vs prior period.

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/ebitda_bridge_price.yml) · [sql](dbt/analyses/metrics/finance/ebitda_bridge_price.sql)
- **Numerator:** (Current Price - Prior Price) × Prior Volume
- **Dimensions:** company_id, product_line, fiscal_period
- **Data sources:** ERP, Pricing system
- **Parents:** [`ebitda`](#ebitda)
- **Correlated:** [`ebitda_bridge_volume`](#ebitda_bridge_volume)

<a id="ebitda_bridge_volume"></a>
#### EBITDA Bridge: Volume — `ebitda_bridge_volume`

Volume contribution to EBITDA variance vs prior period.

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/ebitda_bridge_volume.yml) · [sql](dbt/analyses/metrics/finance/ebitda_bridge_volume.sql)
- **Numerator:** (Current Volume - Prior Volume) × Prior Price
- **Dimensions:** company_id, product_line, fiscal_period
- **Data sources:** ERP
- **Parents:** [`ebitda`](#ebitda)
- **Correlated:** [`ebitda_bridge_price`](#ebitda_bridge_price)

<a id="implementation_revenue"></a>
#### Implementation Revenue — `implementation_revenue`

One-time revenue from customer onboarding and implementation

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/implementation_revenue.yml) · [sql](dbt/analyses/metrics/finance/implementation_revenue.sql)
- **Numerator:** Onboarding/implementation fees
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue`](#revenue)
- **Correlated:** [`services_revenue`](#services_revenue)

<a id="prior_year_revenue"></a>
#### PY Revenue — `prior_year_revenue`

Full-year revenue from the prior fiscal year

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/prior_year_revenue.yml) · [sql](dbt/analyses/metrics/finance/prior_year_revenue.sql)
- **Numerator:** Full prior year revenue
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_vs_py`](#revenue_vs_py)
- **Correlated:** [`revenue_vs_py`](#revenue_vs_py), [`revenue`](#revenue)

<a id="q1_revenue"></a>
#### Q1 Revenue — `q1_revenue`

Revenue recognized in Q1

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/q1_revenue.yml) · [sql](dbt/analyses/metrics/finance/q1_revenue.sql)
- **Numerator:** Revenue recognized in Q1
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_ytd`](#revenue_ytd)
- **Correlated:** [`q2_revenue`](#q2_revenue), [`revenue`](#revenue)

<a id="q2_revenue"></a>
#### Q2 Revenue — `q2_revenue`

Revenue recognized in Q2

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/q2_revenue.yml) · [sql](dbt/analyses/metrics/finance/q2_revenue.sql)
- **Numerator:** Revenue recognized in Q2
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_ytd`](#revenue_ytd)
- **Correlated:** [`q1_revenue`](#q1_revenue), [`q3_revenue`](#q3_revenue)

<a id="q3_revenue"></a>
#### Q3 Revenue — `q3_revenue`

Revenue recognized in Q3

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/q3_revenue.yml) · [sql](dbt/analyses/metrics/finance/q3_revenue.sql)
- **Numerator:** Revenue recognized in Q3
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_ytd`](#revenue_ytd)
- **Correlated:** [`q2_revenue`](#q2_revenue), [`q4_revenue`](#q4_revenue)

<a id="q4_revenue"></a>
#### Q4 Revenue — `q4_revenue`

Revenue recognized in Q4

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/q4_revenue.yml) · [sql](dbt/analyses/metrics/finance/q4_revenue.sql)
- **Numerator:** Revenue recognized in Q4
- **Dimensions:** date
- **Data sources:** orders
- **Parents:** [`revenue_ytd`](#revenue_ytd)
- **Correlated:** [`q3_revenue`](#q3_revenue), [`revenue`](#revenue)

<a id="sam"></a>
#### SAM — `sam`

The portion of TAM that the company can realistically serve

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/sam.yml) · [sql](dbt/analyses/metrics/finance/sam.sql)
- **Numerator:** Serviceable addressable market estimate
- **Dimensions:** date
- **Data sources:** market_sizing
- **Parents:** [`market_penetration_rate`](#market_penetration_rate)
- **Correlated:** [`tam`](#tam), [`market_share`](#market_share)

<a id="shareholder_equity"></a>
#### Shareholder Equity — `shareholder_equity`

Total assets minus total liabilities

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/shareholder_equity.yml) · [sql](dbt/analyses/metrics/finance/shareholder_equity.sql)
- **Numerator:** Total assets − total liabilities
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`roe`](#roe), [`debt_to_equity`](#debt_to_equity)
- **Children:** [`total_assets`](#total_assets), [`total_liabilities`](#total_liabilities)
- **Correlated:** [`roe`](#roe), [`net_debt`](#net_debt), [`total_assets`](#total_assets)

<a id="sm_spend"></a>
#### S&M Spend — `sm_spend`

Total sales and marketing expenditure in the period

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/sm_spend.yml) · [sql](dbt/analyses/metrics/finance/sm_spend.sql)
- **Numerator:** Sales & marketing total spend
- **Dimensions:** date
- **Data sources:** general_ledger
- **Parents:** [`magic_number`](#magic_number), [`cac_payback`](#cac_payback)
- **Correlated:** [`cac`](#cac), [`marketing_cac`](#marketing_cac)

<a id="tam"></a>
#### TAM — `tam`

Estimated total market opportunity for the product or service

- **Domain:** Finance · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/finance/tam.yml) · [sql](dbt/analyses/metrics/finance/tam.sql)
- **Numerator:** Total addressable market estimate
- **Dimensions:** date
- **Data sources:** market_sizing
- **Parents:** [`market_penetration_rate`](#market_penetration_rate)
- **Correlated:** [`sam`](#sam), [`market_share`](#market_share)

<a id="total_assets"></a>
#### Total Assets — `total_assets`

Total value of assets on the balance sheet

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/total_assets.yml) · [sql](dbt/analyses/metrics/finance/total_assets.sql)
- **Numerator:** Sum of all asset values
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`roa`](#roa), [`current_ratio`](#current_ratio), [`roic`](#roic), [`shareholder_equity`](#shareholder_equity)
- **Correlated:** [`total_liabilities`](#total_liabilities), [`shareholder_equity`](#shareholder_equity)

<a id="total_debt"></a>
#### Total Debt — `total_debt`

Sum of short-term and long-term debt obligations

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/total_debt.yml) · [sql](dbt/analyses/metrics/finance/total_debt.sql)
- **Numerator:** Short-term + long-term debt
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`debt_to_equity`](#debt_to_equity), [`net_debt`](#net_debt), [`interest_coverage_ratio`](#interest_coverage_ratio), [`roic`](#roic)
- **Correlated:** [`leverage_ratio`](#leverage_ratio), [`interest_coverage_ratio`](#interest_coverage_ratio)

<a id="total_liabilities"></a>
#### Total Liabilities — `total_liabilities`

Total value of liabilities on the balance sheet

- **Domain:** Finance · **Industry:** financial_services
- **Files:** [yml](dbt/models/metrics/finance/total_liabilities.yml) · [sql](dbt/analyses/metrics/finance/total_liabilities.sql)
- **Numerator:** Sum of all liability values
- **Dimensions:** date
- **Data sources:** balance_sheet
- **Parents:** [`shareholder_equity`](#shareholder_equity)
- **Correlated:** [`total_assets`](#total_assets), [`debt_to_equity`](#debt_to_equity)

### Input · People & HR (11)

<a id="benefits_utilization"></a>
#### Benefits Utilization % — `benefits_utilization`

Percentage of eligible employees actively using offered benefits

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/benefits_utilization.yml) · [sql](dbt/analyses/metrics/hr/benefits_utilization.sql)
- **Numerator:** Employees using benefits
- **Denominator:** Eligible employees
- **Dimensions:** date
- **Data sources:** benefits_admin
- **Parents:** [`employee_engagement_score`](#employee_engagement_score)
- **Correlated:** [`employee_engagement_score`](#employee_engagement_score), [`total_comp_expense`](#total_comp_expense)

<a id="headcount_fte"></a>
#### Headcount FTE — `headcount_fte`

Full-time equivalent employee count at end of period.

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/headcount_fte.yml) · [sql](dbt/analyses/metrics/hr/headcount_fte.sql)
- **Numerator:** COUNT(active_employees) weighted by employment fraction
- **Dimensions:** company_id, department, location, period
- **Data sources:** HRIS
- **Parents:** [`revenue_per_employee`](#revenue_per_employee), [`student_teacher_ratio`](#student_teacher_ratio)
- **Correlated:** [`headcount_cost`](#headcount_cost), [`opex`](#opex), [`voluntary_turnover`](#voluntary_turnover), [`time_to_fill`](#time_to_fill)

<a id="new_hires"></a>
#### New Hires — `new_hires`

Number of employees who started in the period

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/new_hires.yml) · [sql](dbt/analyses/metrics/hr/new_hires.sql)
- **Numerator:** Employees started in period
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`headcount`](#headcount), [`cost_per_hire`](#cost_per_hire), [`offer_acceptance_rate`](#offer_acceptance_rate)
- **Correlated:** [`cost_per_hire`](#cost_per_hire), [`time_to_fill`](#time_to_fill)

<a id="open_requisitions"></a>
#### Open Requisitions — `open_requisitions`

Number of currently unfilled job postings

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/open_requisitions.yml) · [sql](dbt/analyses/metrics/hr/open_requisitions.sql)
- **Numerator:** Open job requisitions
- **Dimensions:** date, department
- **Data sources:** ats
- **Parents:** [`time_to_hire`](#time_to_hire)
- **Correlated:** [`time_to_fill`](#time_to_fill), [`headcount_vs_budget`](#headcount_vs_budget)

<a id="overtime_hours"></a>
#### Overtime Hours — `overtime_hours`

Total overtime hours logged by employees in the period

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/overtime_hours.yml) · [sql](dbt/analyses/metrics/hr/overtime_hours.sql)
- **Numerator:** Overtime hours logged
- **Dimensions:** date, department
- **Data sources:** time_records
- **Parents:** [`workforce_productivity`](#workforce_productivity)
- **Correlated:** [`workforce_productivity`](#workforce_productivity), [`absenteeism_rate`](#absenteeism_rate)

<a id="rd_headcount"></a>
#### R&D Headcount — `rd_headcount`

Number of employees in engineering, product, and research roles

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/rd_headcount.yml) · [sql](dbt/analyses/metrics/hr/rd_headcount.sql)
- **Numerator:** R&D/engineering/product employees
- **Dimensions:** date
- **Data sources:** hris
- **Parents:** [`rd_headcount_pct`](#rd_headcount_pct)
- **Correlated:** [`rd_headcount_pct`](#rd_headcount_pct), [`deployment_frequency`](#deployment_frequency)

<a id="recruiting_pipeline"></a>
#### Recruiting Pipeline — `recruiting_pipeline`

Number of active candidates across all open requisitions

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/recruiting_pipeline.yml) · [sql](dbt/analyses/metrics/hr/recruiting_pipeline.sql)
- **Numerator:** Active candidates in pipeline
- **Dimensions:** date, department
- **Data sources:** ats
- **Parents:** [`offer_acceptance_rate`](#offer_acceptance_rate), [`time_to_hire`](#time_to_hire)
- **Correlated:** [`time_to_hire`](#time_to_hire), [`offer_acceptance_rate`](#offer_acceptance_rate)

<a id="remote_work_rate"></a>
#### Remote Work % — `remote_work_rate`

Percentage of employees on fully remote or hybrid schedules

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/remote_work_rate.yml) · [sql](dbt/analyses/metrics/hr/remote_work_rate.sql)
- **Numerator:** Remote and hybrid employees
- **Denominator:** Total headcount
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`employee_engagement_score`](#employee_engagement_score)
- **Correlated:** [`absenteeism_rate`](#absenteeism_rate), [`employee_engagement_score`](#employee_engagement_score)

<a id="sales_headcount"></a>
#### Sales Headcount — `sales_headcount`

Number of quota-carrying sales representatives

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/sales_headcount.yml) · [sql](dbt/analyses/metrics/hr/sales_headcount.sql)
- **Numerator:** Quota-carrying sales reps
- **Dimensions:** date
- **Data sources:** hris
- **Parents:** [`arr_per_rep`](#arr_per_rep)
- **Correlated:** [`arr_per_rep`](#arr_per_rep), [`quota_attainment`](#quota_attainment)

<a id="separations"></a>
#### Separations — `separations`

Number of employees who left (voluntarily or involuntarily) in the period

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/separations.yml) · [sql](dbt/analyses/metrics/hr/separations.sql)
- **Numerator:** Employees who left in period
- **Dimensions:** date, department
- **Data sources:** hris
- **Parents:** [`turnover_rate`](#turnover_rate), [`regrettable_attrition`](#regrettable_attrition), [`voluntary_turnover`](#voluntary_turnover)
- **Correlated:** [`voluntary_turnover`](#voluntary_turnover), [`regrettable_attrition`](#regrettable_attrition)

<a id="total_comp_expense"></a>
#### Total Comp Expense — `total_comp_expense`

Total salaries, benefits, and equity costs for the period

- **Domain:** People & HR · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/hr/total_comp_expense.yml) · [sql](dbt/analyses/metrics/hr/total_comp_expense.sql)
- **Numerator:** Total compensation and benefits cost
- **Dimensions:** date, department
- **Data sources:** payroll
- **Parents:** [`opex`](#opex), [`hr_cost_pct_revenue`](#hr_cost_pct_revenue), [`cost_per_hire`](#cost_per_hire), [`gender_pay_gap`](#gender_pay_gap), [`support_cost_per_ticket`](#support_cost_per_ticket)
- **Correlated:** [`headcount`](#headcount), [`cost_per_hire`](#cost_per_hire), [`benefits_utilization`](#benefits_utilization)

### Input · Marketing (11)

<a id="ad_clicks"></a>
#### Ad Clicks — `ad_clicks`

Total clicks on paid ads in the period.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/ad_clicks.yml) · [sql](dbt/analyses/metrics/marketing/ad_clicks.sql)
- **Numerator:** SUM(clicks)
- **Dimensions:** channel, campaign, ad_set, date
- **Data sources:** Google Ads, Meta Ads
- **Parents:** [`ctr`](#ctr), [`cpc`](#cpc)
- **Correlated:** [`impressions`](#impressions), [`web_conversion_rate`](#web_conversion_rate)

<a id="backlink_count"></a>
#### Referring Domains — `backlink_count`

Total referring domain backlinks to the site — SEO authority signal.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/backlink_count.yml) · [sql](dbt/analyses/metrics/marketing/backlink_count.sql)
- **Numerator:** COUNT(referring domains)
- **Dimensions:** domain, link_type, period
- **Data sources:** Ahrefs, SEMrush
- **Parents:** [`domain_authority`](#domain_authority)
- **Correlated:** [`domain_authority`](#domain_authority), [`organic_sessions`](#organic_sessions), [`referral_sessions`](#referral_sessions)

<a id="backlinks_count"></a>
#### Backlinks — `backlinks_count`

Total referring backlinks to the domain

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/backlinks_count.yml) · [sql](dbt/analyses/metrics/marketing/backlinks_count.sql)
- **Numerator:** External links pointing to site
- **Dimensions:** date
- **Data sources:** seo_tools
- **Parents:** [`domain_authority`](#domain_authority)
- **Correlated:** [`domain_authority`](#domain_authority), [`organic_sessions`](#organic_sessions), [`top10_keyword_count`](#top10_keyword_count)

<a id="content_published_count"></a>
#### Content Published — `content_published_count`

Count of content assets published in the period (blogs, whitepapers, videos).

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/content_published_count.yml) · [sql](dbt/analyses/metrics/marketing/content_published_count.sql)
- **Numerator:** COUNT(published content assets)
- **Dimensions:** content_type, topic, channel, period, date, type
- **Data sources:** CMS (Contentful / WordPress)
- **Parents:** [`organic_sessions`](#organic_sessions)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`mql`](#mql), [`top10_keyword_count`](#top10_keyword_count), [`domain_authority`](#domain_authority)

<a id="event_attendees"></a>
#### Event Attendees — `event_attendees`

Total attendees at company-sponsored events in the period

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/event_attendees.yml) · [sql](dbt/analyses/metrics/marketing/event_attendees.sql)
- **Numerator:** Event attendees
- **Dimensions:** date, event
- **Data sources:** events_platform
- **Parents:** [`mql`](#mql)
- **Correlated:** [`mql`](#mql), [`cost_per_event_attendee`](#cost_per_event_attendee)

<a id="impressions"></a>
#### Impressions — `impressions`

Total ad impressions served in the period.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/impressions.yml) · [sql](dbt/analyses/metrics/marketing/impressions.sql)
- **Numerator:** SUM(impressions)
- **Dimensions:** channel, campaign, ad_set, date, ad
- **Data sources:** Google Ads, Meta Ads, LinkedIn Ads
- **Parents:** [`ctr`](#ctr), [`cpm`](#cpm), [`cpc`](#cpc)
- **Correlated:** [`ad_clicks`](#ad_clicks), [`share_of_voice`](#share_of_voice), [`social_followers`](#social_followers), [`ctr`](#ctr), [`cpc`](#cpc)

<a id="pr_mentions"></a>
#### PR Mentions — `pr_mentions`

Total brand mentions in press or media in the period

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/pr_mentions.yml) · [sql](dbt/analyses/metrics/marketing/pr_mentions.sql)
- **Numerator:** PR mentions in period
- **Dimensions:** date, outlet
- **Data sources:** media_monitoring
- **Parents:** [`earned_media_value`](#earned_media_value)
- **Correlated:** [`earned_media_value`](#earned_media_value), [`domain_authority`](#domain_authority), [`social_engagement_rate`](#social_engagement_rate)

<a id="referral_sessions"></a>
#### Referral Sessions — `referral_sessions`

Web sessions originating from referring websites (non-paid, non-organic).

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/referral_sessions.yml) · [sql](dbt/analyses/metrics/marketing/referral_sessions.sql)
- **Numerator:** COUNT(sessions WHERE medium = 'referral')
- **Dimensions:** referrer_domain, landing_page, period
- **Data sources:** Google Analytics / GA4
- **Parents:** [`website_sessions`](#website_sessions)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`backlink_count`](#backlink_count)

<a id="social_followers"></a>
#### Social Followers — `social_followers`

Total followers across social platforms at end of period.

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/social_followers.yml) · [sql](dbt/analyses/metrics/marketing/social_followers.sql)
- **Numerator:** SUM(followers)
- **Dimensions:** platform, account, period
- **Data sources:** Social media APIs (LinkedIn, X, Instagram)
- **Parents:** [`share_of_voice`](#share_of_voice), [`social_engagement_rate`](#social_engagement_rate)
- **Correlated:** [`organic_sessions`](#organic_sessions), [`impressions`](#impressions)

<a id="testimonials_count"></a>
#### Testimonials — `testimonials_count`

Number of customer testimonials or case studies collected YTD

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/testimonials_count.yml) · [sql](dbt/analyses/metrics/marketing/testimonials_count.sql)
- **Numerator:** Testimonials published
- **Dimensions:** date
- **Data sources:** crm, review_platforms
- **Parents:** [`nps`](#nps)
- **Correlated:** [`review_rating`](#review_rating), [`nps`](#nps)

<a id="webinar_registrants"></a>
#### Webinar Registrants — `webinar_registrants`

Total registrations across all webinars in the period

- **Domain:** Marketing · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/marketing/webinar_registrants.yml) · [sql](dbt/analyses/metrics/marketing/webinar_registrants.sql)
- **Numerator:** Webinar registrations
- **Dimensions:** date, webinar
- **Data sources:** webinar_platform
- **Parents:** [`webinar_attendance_rate`](#webinar_attendance_rate)
- **Correlated:** [`webinar_attendance_rate`](#webinar_attendance_rate), [`mql`](#mql)

### Input · Operations (2)

<a id="energy_cost_per_unit"></a>
#### Energy Cost per Unit — `energy_cost_per_unit`

Energy expense allocated per unit of output — sustainability and efficiency signal.

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/energy_cost_per_unit.yml) · [sql](dbt/analyses/metrics/operations/energy_cost_per_unit.sql)
- **Numerator:** Energy Cost
- **Denominator:** Units Produced
- **Dimensions:** facility_id, production_line, period
- **Data sources:** Energy monitoring, ERP
- **Parents:** [`cost_per_unit`](#cost_per_unit)
- **Correlated:** [`capacity_utilization`](#capacity_utilization), [`carbon_emissions_per_unit`](#carbon_emissions_per_unit)

<a id="work_orders"></a>
#### Work Orders — `work_orders`

Maintenance and facilities work orders created in the period

- **Domain:** Operations · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/operations/work_orders.yml) · [sql](dbt/analyses/metrics/operations/work_orders.sql)
- **Numerator:** Work orders created
- **Dimensions:** work_order_id, facility_id, category, priority, created_date
- **Data sources:** CMMS (Computerized Maintenance Management System)
- **Parents:** [`work_order_resolution_time`](#work_order_resolution_time), [`preventive_maintenance_rate`](#preventive_maintenance_rate)

### Input · Product (7)

<a id="api_calls_total"></a>
#### API Calls (Total) — `api_calls_total`

Total API calls made by all integrations and users in the period

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/api_calls_total.yml) · [sql](dbt/analyses/metrics/product/api_calls_total.sql)
- **Numerator:** Total API calls
- **Dimensions:** date, endpoint
- **Data sources:** api_gateway
- **Parents:** [`api_latency_p95`](#api_latency_p95)
- **Correlated:** [`api_consumers`](#api_consumers), [`api_latency_p95`](#api_latency_p95)

<a id="api_consumers"></a>
#### API Consumers — `api_consumers`

Distinct applications or users making API calls in the period

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/api_consumers.yml) · [sql](dbt/analyses/metrics/product/api_consumers.sql)
- **Numerator:** Unique API consumers
- **Dimensions:** date
- **Data sources:** api_gateway
- **Parents:** [`mau`](#mau)
- **Correlated:** [`api_calls_total`](#api_calls_total), [`dau`](#dau)

<a id="app_downloads"></a>
#### App Downloads — `app_downloads`

Total app installs from app stores in the period

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/app_downloads.yml) · [sql](dbt/analyses/metrics/product/app_downloads.sql)
- **Numerator:** App installs in period
- **Dimensions:** date, platform
- **Data sources:** app_stores
- **Parents:** [`new_user_signups`](#new_user_signups)
- **Correlated:** [`dau`](#dau), [`activation_rate`](#activation_rate)

<a id="feature_request_volume"></a>
#### Feature Request Volume — `feature_request_volume`

Count of feature requests submitted via support, NPS verbatims, or feedback tools.

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/feature_request_volume.yml) · [sql](dbt/analyses/metrics/product/feature_request_volume.sql)
- **Numerator:** COUNT(feature requests)
- **Dimensions:** feature_area, segment, channel, period
- **Data sources:** Product feedback tool (Productboard / Canny)
- **Parents:** [`nps`](#nps)
- **Correlated:** [`nps`](#nps), [`feature_adoption_rate`](#feature_adoption_rate)

<a id="funnel_dropoff"></a>
#### Funnel Drop-off — `funnel_dropoff`

Percentage of users who exit the conversion funnel at a given step

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/funnel_dropoff.yml) · [sql](dbt/analyses/metrics/product/funnel_dropoff.sql)
- **Numerator:** Users at step N
- **Denominator:** Users at step N−1
- **Dimensions:** date, funnel_step
- **Data sources:** analytics
- **Parents:** [`activation_rate`](#activation_rate)
- **Correlated:** [`activation_rate`](#activation_rate), [`session_to_lead_rate`](#session_to_lead_rate)

<a id="survey_response_rate"></a>
#### Survey Response % — `survey_response_rate`

Percentage of customers who responded to surveys sent

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/survey_response_rate.yml) · [sql](dbt/analyses/metrics/product/survey_response_rate.sql)
- **Numerator:** Responses received
- **Denominator:** Surveys sent
- **Dimensions:** date
- **Data sources:** surveys
- **Parents:** [`nps`](#nps)
- **Correlated:** [`nps`](#nps), [`csat`](#csat), [`employee_engagement_score`](#employee_engagement_score)

<a id="trial_signups"></a>
#### Trial Signups — `trial_signups`

New free trial registrations in the period

- **Domain:** Product · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/product/trial_signups.yml) · [sql](dbt/analyses/metrics/product/trial_signups.sql)
- **Numerator:** Trial account signups
- **Dimensions:** date, channel
- **Data sources:** users
- **Parents:** [`plg_rate`](#plg_rate), [`trial_to_paid_rate`](#trial_to_paid_rate), [`free_to_paid_rate`](#free_to_paid_rate)
- **Correlated:** [`activation_rate`](#activation_rate), [`free_to_paid_rate`](#free_to_paid_rate), [`new_user_signups`](#new_user_signups)

### Input · SaaS (6)

<a id="churned_arr"></a>
#### Churned ARR — `churned_arr`

ARR lost from customers who cancelled in the period

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/churned_arr.yml) · [sql](dbt/analyses/metrics/saas/churned_arr.sql)
- **Numerator:** ARR from cancelled contracts
- **Dimensions:** date, customer_segment
- **Data sources:** subscriptions
- **Parents:** [`arr`](#arr), [`grr`](#grr), [`mrr_churn_rate`](#mrr_churn_rate), [`nrr`](#nrr), [`saas_quick_ratio`](#saas_quick_ratio)
- **Correlated:** [`contraction_arr`](#contraction_arr), [`customer_churn_rate`](#customer_churn_rate)

<a id="cohort_churn"></a>
#### Cohort Churn — `cohort_churn`

Cumulative churn for a given acquisition cohort at N months

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/cohort_churn.yml) · [sql](dbt/analyses/metrics/saas/cohort_churn.sql)
- **Numerator:** Churned users in cohort
- **Denominator:** Cohort starting size
- **Dimensions:** date, cohort
- **Data sources:** subscriptions, users
- **Parents:** [`churn_rate`](#churn_rate)
- **Correlated:** [`customer_churn_rate`](#customer_churn_rate), [`d30_retention`](#d30_retention)

<a id="committed_arr"></a>
#### Committed ARR — `committed_arr`

ARR under signed contracts not yet recognized

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/committed_arr.yml) · [sql](dbt/analyses/metrics/saas/committed_arr.sql)
- **Numerator:** ARR under signed contracts not yet active
- **Dimensions:** date
- **Data sources:** contracts, subscriptions
- **Parents:** [`arr`](#arr)
- **Correlated:** [`arr`](#arr), [`bookings`](#bookings), [`contracted_unbilled`](#contracted_unbilled)

<a id="contracted_unbilled"></a>
#### Contracted Unbilled — `contracted_unbilled`

ARR under contract not yet invoiced

- **Domain:** SaaS · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/saas/contracted_unbilled.yml) · [sql](dbt/analyses/metrics/saas/contracted_unbilled.sql)
- **Numerator:** Contracted value not yet invoiced
- **Dimensions:** date
- **Data sources:** contracts
- **Parents:** [`billings`](#billings)
- **Correlated:** [`arr`](#arr), [`billings`](#billings), [`committed_arr`](#committed_arr)

<a id="contraction_arr"></a>
#### Contraction ARR — `contraction_arr`

ARR lost from downgrades by existing customers

- **Domain:** SaaS · **Industry:** saas
- **Files:** [yml](dbt/models/metrics/saas/contraction_arr.yml) · [sql](dbt/analyses/metrics/saas/contraction_arr.sql)
- **Numerator:** ARR lost to downgrades
- **Dimensions:** date, customer_segment
- **Data sources:** subscriptions
- **Parents:** [`arr`](#arr), [`nrr`](#nrr), [`grr`](#grr), [`saas_quick_ratio`](#saas_quick_ratio)
- **Correlated:** [`churned_arr`](#churned_arr), [`customer_churn_rate`](#customer_churn_rate)

<a id="customer_count"></a>
#### Customer Count — `customer_count`

Total number of active paying customers

- **Domain:** SaaS · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/saas/customer_count.yml) · [sql](dbt/analyses/metrics/saas/customer_count.sql)
- **Numerator:** Active customers at period end
- **Dimensions:** date, segment
- **Data sources:** crm
- **Parents:** [`revenue`](#revenue)
- **Children:** [`monthly_new_customers`](#monthly_new_customers)
- **Correlated:** [`net_new_customers`](#net_new_customers), [`customer_churn_rate`](#customer_churn_rate), [`revenue`](#revenue)

### Input · Sales (3)

<a id="competitive_win_rate"></a>
#### Competitive Win % — `competitive_win_rate`

Win rate in deals that involved a named competitor

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/competitive_win_rate.yml) · [sql](dbt/analyses/metrics/sales/competitive_win_rate.sql)
- **Numerator:** Wins in competitive deals
- **Denominator:** Total competitive opportunities
- **Dimensions:** date, competitor
- **Data sources:** crm
- **Parents:** [`win_rate`](#win_rate)
- **Correlated:** [`win_rate`](#win_rate), [`avg_deal_size`](#avg_deal_size)

<a id="demo_requests"></a>
#### Demo Requests — `demo_requests`

Product demo requests submitted in the period

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/demo_requests.yml) · [sql](dbt/analyses/metrics/sales/demo_requests.sql)
- **Numerator:** Demo requests submitted
- **Dimensions:** date, channel
- **Data sources:** crm, website
- **Parents:** [`mql`](#mql)
- **Correlated:** [`mql`](#mql), [`sql`](#sql), [`form_conversion_rate`](#form_conversion_rate)

<a id="leads"></a>
#### Leads — `leads`

Leads created in the period, from CRM and marketing automation

- **Domain:** Sales · **Industry:** cross_industry
- **Files:** [yml](dbt/models/metrics/sales/leads.yml) · [sql](dbt/analyses/metrics/sales/leads.sql)
- **Numerator:** Leads created
- **Dimensions:** date, channel
- **Data sources:** crm
- **Parents:** [`cpl`](#cpl), [`form_conversion_rate`](#form_conversion_rate), [`lead_to_mql_rate`](#lead_to_mql_rate), [`mql`](#mql), [`session_to_lead_rate`](#session_to_lead_rate), [`monthly_new_customers`](#monthly_new_customers)
- **Correlated:** [`mql`](#mql), [`cpl`](#cpl)
