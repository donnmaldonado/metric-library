-- One row per cohort month and months-since-acquisition offset.
select
    date_trunc('month', cohort_start_date) as period,
    months_since_acquisition,
    sum(cohort_revenue) / nullif(sum(initial_cohort_revenue), 0) as cohort_revenue_retention
from {{ ref('fct_customer_cohorts') }}
group by 1, 2
