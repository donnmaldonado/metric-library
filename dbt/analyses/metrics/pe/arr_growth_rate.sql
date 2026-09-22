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
)

select
    cur.period,
    (cur.arr - prior.arr) / nullif(prior.arr, 0) as arr_growth_rate
from arr as cur
left join arr as prior
    on prior.period = cur.period - interval 1 year
