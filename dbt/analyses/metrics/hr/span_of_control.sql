-- active employees with a manager / distinct managers,
-- on the latest snapshot of each month.
select
    date_trunc('month', snapshot_date) as period,
    department,
    count(manager_id) / nullif(count(distinct manager_id), 0) as span_of_control
from {{ ref('fct_employee_snapshots') }}
where status = 'active'
    and snapshot_date in (select max(snapshot_date) from {{ ref('fct_employee_snapshots') }} group by date_trunc('month', snapshot_date))
group by 1, 2
order by 1, 2
