-- Eligible employees actively using benefits / eligible employees, latest snapshot of each month.
select
    date_trunc('month', as_of_date) as period,
    count(employee_id) filter (where is_eligible and is_active_user)
        / nullif(count(employee_id) filter (where is_eligible), 0) as benefits_utilization
from {{ ref('fct_benefits_enrollment') }}
where as_of_date in (select max(as_of_date) from {{ ref('fct_benefits_enrollment') }} group by date_trunc('month', as_of_date))
group by 1
order by 1
