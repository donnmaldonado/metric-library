-- All employee records (any status) on the latest snapshot of each month.
select
    date_trunc('month', snapshot_date) as period,
    count(employee_id) as stg_employees_count
from {{ ref('fct_employee_snapshots') }}
where snapshot_date in (select max(snapshot_date) from {{ ref('fct_employee_snapshots') }} group by date_trunc('month', snapshot_date))
group by 1
order by 1
