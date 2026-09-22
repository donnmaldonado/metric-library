-- avg_session_duration expressed in minutes.
select
    date_trunc('month', session_date) as period,
    platform,
    avg(duration_seconds) / 60 as session_length
from {{ ref('fct_web_sessions') }}
group by 1, 2
