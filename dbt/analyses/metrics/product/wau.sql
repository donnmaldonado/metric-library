-- Calendar-week active users (MetricFlow reports a trailing 7-day window per day).
select
    date_trunc('week', event_date) as period,
    platform,
    count(distinct user_id) as wau
from {{ ref('fct_user_events') }}
where is_active_event
group by 1, 2
