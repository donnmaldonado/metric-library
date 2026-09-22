-- Average years since hire among active employees on the latest snapshot of each month.
select
    date_trunc('month', snapshot_date) as period,
    department,
    avg(datediff('day', hire_date, snapshot_date) / 365.25) as avg_tenure
from {{ ref('fct_employee_snapshots') }}
where status = 'active'
    and snapshot_date in (select max(snapshot_date) from {{ ref('fct_employee_snapshots') }} group by date_trunc('month', snapshot_date))
group by 1, 2
order by 1, 2
