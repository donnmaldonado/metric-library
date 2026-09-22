with snapshots as (
    select
        *,
        max(snapshot_date) over (partition by date_trunc('month', snapshot_date)) as last_snapshot_date
    from {{ ref('fct_subscriptions') }}
),

arr as (
    select
        date_trunc('month', snapshot_date) as period,
        sum(monthly_amount * 12) as arr
    from snapshots
    where snapshot_date = last_snapshot_date
      and status = 'active'
    group by 1
),

reps as (
    select
        date_trunc('month', period_start) as period,
        count(distinct rep_id) as quota_carrying_reps
    from {{ ref('fct_sales_rep_periods') }}
    where is_quota_carrying
    group by 1
)

select
    arr.period,
    arr.arr / nullif(reps.quota_carrying_reps, 0) as arr_per_rep
from arr
left join reps using (period)
