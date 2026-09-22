-- Overtime hours logged per month.
select
    date_trunc('month', work_date) as period,
    department,
    sum(overtime_hours) as overtime_hours
from {{ ref('fct_time_records') }}
group by 1, 2
order by 1, 2
