-- One row per cohort month and months-since-acquisition offset (churn is cumulative to that offset).
select
    date_trunc('month', cohort_start_date) as period,
    months_since_acquisition,
    sum(churned_users_in_cohort) / nullif(sum(cohort_starting_size), 0) as cohort_churn
from {{ ref('fct_customer_cohorts') }}
group by 1, 2
