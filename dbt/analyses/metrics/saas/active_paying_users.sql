with snapshots as (
    select
        *,
        max(snapshot_date) over (partition by date_trunc('month', snapshot_date)) as last_snapshot_date
    from {{ ref('fct_subscriptions') }}
)

select
    date_trunc('month', snapshot_date) as period,
    plan_tier,
    count(distinct user_id) as active_paying_users
from snapshots
where snapshot_date = last_snapshot_date
  and status = 'active'
  and plan_tier != 'free'
  and is_active_30d
group by 1, 2
