-- Snapshot: take the last metric_date in each month (semi-additive), then aggregate across rows.
with latest as (
    select
        *,
        max(metric_date) over (partition by date_trunc('month', metric_date), platform, account_name) as last_date
    from {{ ref('fct_social_metrics') }}
)
select
    date_trunc('month', metric_date) as period,
    platform,
    account_name,
    sum(followers) as social_followers
from latest
where metric_date = last_date
group by 1, 2, 3
