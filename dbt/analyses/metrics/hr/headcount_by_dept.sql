-- Alias of headcount, broken down by department. Active full-time employees on the latest snapshot of each month.
select
    date_trunc('month', snapshot_date) as period,
    department,
    count(employee_id) as headcount_by_dept
from {{ ref('fct_employee_snapshots') }}
where status = 'active'
    and employment_type = 'full_time'
    and snapshot_date in (select max(snapshot_date) from {{ ref('fct_employee_snapshots') }} group by date_trunc('month', snapshot_date))
group by 1, 2
order by 1, 2
