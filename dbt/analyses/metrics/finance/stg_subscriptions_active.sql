with snapshots as (
    select
        *,
        max(snapshot_date) over (partition by date_trunc('month', snapshot_date)) as last_snapshot_date
    from {{ ref('fct_subscriptions') }}
)

select
    date_trunc('month', snapshot_date) as period,
    plan_tier,
    count(subscription_id) as stg_subscriptions_active
from snapshots
where snapshot_date = last_snapshot_date
  and status = 'active'
group by 1, 2
