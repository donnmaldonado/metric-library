-- R&D share of all active employees on the latest snapshot of each month.
select
    date_trunc('month', snapshot_date) as period,
    count(employee_id) filter (where department in ('engineering', 'product', 'research'))
        / nullif(count(employee_id), 0) as rd_headcount_pct
from {{ ref('fct_employee_snapshots') }}
where status = 'active'
    and snapshot_date in (select max(snapshot_date) from {{ ref('fct_employee_snapshots') }} group by date_trunc('month', snapshot_date))
group by 1
order by 1
