-- Average compa-ratio (annual salary / market midpoint for the role), per month.
select
    date_trunc('month', pay_date) as period,
    department,
    job_level,
    avg(annual_salary / nullif(market_midpoint, 0)) as compensation_ratio
from {{ ref('fct_payroll') }}
group by 1, 2, 3
order by 1, 2, 3
