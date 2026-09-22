-- Engagements in the month / followers on the last day of the month.
with monthly as (
    select
        date_trunc('month', metric_date) as period,
        platform,
        sum(total_engagements) as engagements,
        max(metric_date) as last_date
    from {{ ref('fct_social_metrics') }}
    group by 1, 2
),
followers as (
    select s.platform, s.metric_date, sum(s.followers) as followers
    from {{ ref('fct_social_metrics') }} as s
    group by 1, 2
)
select
    monthly.period,
    monthly.platform,
    monthly.engagements / nullif(followers.followers, 0) as social_engagement_rate
from monthly
left join followers
    on followers.platform = monthly.platform
    and followers.metric_date = monthly.last_date
