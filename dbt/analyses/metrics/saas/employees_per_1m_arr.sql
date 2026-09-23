with subscription_snapshots as (
    select
        *,
        max(snapshot_date) over (partition by date_trunc('month', snapshot_date)) as last_snapshot_date
    from {{ ref('fct_subscriptions') }}
),

arr as (
    select
        date_trunc('month', snapshot_date) as period,
        sum(monthly_amount * 12) as arr
    from subscription_snapshots
    where snapshot_date = last_snapshot_date
      and status = 'active'
    group by 1
),

employee_snapshots as (
    select
        *,
        max(snapshot_date) over (partition by date_trunc('month', snapshot_date)) as last_snapshot_date
    from {{ ref('fct_employee_snapshots') }}
),

headcount as (
    select
        date_trunc('month', snapshot_date) as period,
        count(employee_id) as headcount
    from employee_snapshots
    where snapshot_date = last_snapshot_date
      and status = 'active'
    group by 1
)

select
    arr.period,
    headcount.headcount / nullif(arr.arr / 1000000, 0) as employees_per_1m_arr
from arr
left join headcount using (period)
