-- Seconds per session.
select
    date_trunc('month', session_date) as period,
    platform,
    product_area,
    user_segment,
    avg(duration_seconds) as avg_session_duration
from {{ ref('fct_web_sessions') }}
group by 1, 2, 3, 4
