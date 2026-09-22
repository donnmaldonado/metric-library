-- Distinct users of each feature in the month / all active users in the month.
with active as (
    select date_trunc('month', event_date) as period, count(distinct user_id) as active_users
    from {{ ref('fct_user_events') }}
    where is_active_event
    group by 1
),
feature as (
    select date_trunc('month', event_date) as period, feature_name, count(distinct user_id) as feature_users
    from {{ ref('fct_user_events') }}
    where is_active_event
        and feature_name is not null
    group by 1, 2
)
select
    feature.period,
    feature.feature_name,
    feature.feature_users / nullif(active.active_users, 0) as feature_adoption_rate
from feature
join active using (period)
