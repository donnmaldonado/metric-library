-- Calendar-month active users (MetricFlow reports a trailing 30-day window per day).
select
    date_trunc('month', event_date) as period,
    platform,
    count(distinct user_id) as mau
from {{ ref('fct_user_events') }}
where is_active_event
group by 1, 2
