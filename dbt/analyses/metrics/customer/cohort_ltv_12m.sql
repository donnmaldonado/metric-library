select
    date_trunc('month', cohort_start_date) as period,
    sum(cumulative_cohort_revenue)
        / nullif(sum(cohort_starting_size), 0) as cohort_ltv_12m
from {{ ref('fct_customer_cohorts') }}
where months_since_acquisition = 12
group by 1
