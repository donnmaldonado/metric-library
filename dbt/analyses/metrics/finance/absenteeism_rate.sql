-- Unplanned absence days / scheduled working days, per month.
select
    date_trunc('month', work_date) as period,
    department,
    sum(unplanned_absence_days) / nullif(sum(available_working_days), 0) as absenteeism_rate
from {{ ref('fct_time_records') }}
group by 1, 2
order by 1, 2
