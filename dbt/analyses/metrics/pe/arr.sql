with snapshots as (
    select
        *,
        max(snapshot_date) over (partition by date_trunc('month', snapshot_date)) as last_snapshot_date
    from {{ ref('fct_subscriptions') }}
)

-- ARR on the last snapshot of each month
select
    date_trunc('month', snapshot_date) as period,
    segment,
    sum(monthly_amount * 12) as arr
from snapshots
where snapshot_date = last_snapshot_date
  and status = 'active'
group by 1, 2
