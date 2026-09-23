-- Share of active employees on remote or hybrid schedules, latest snapshot of each month.
select
    date_trunc('month', snapshot_date) as period,
    department,
    count(employee_id) filter (where work_arrangement in ('remote', 'hybrid'))
        / nullif(count(employee_id), 0) as remote_work_rate
from {{ ref('fct_employee_snapshots') }}
where status = 'active'
    and snapshot_date in (select max(snapshot_date) from {{ ref('fct_employee_snapshots') }} group by date_trunc('month', snapshot_date))
group by 1, 2
order by 1, 2
