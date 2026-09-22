-- Lifetime revenue contribution / lifetime employment cost, latest estimate of each month.
select
    date_trunc('month', as_of_date) as period,
    job_level,
    hire_cohort,
    sum(lifetime_revenue_contribution) / nullif(sum(lifetime_employment_cost), 0) as employee_lifetime_value
from {{ ref('fct_employee_value') }}
where as_of_date in (select max(as_of_date) from {{ ref('fct_employee_value') }} group by date_trunc('month', as_of_date))
group by 1, 2, 3
order by 1, 2, 3
