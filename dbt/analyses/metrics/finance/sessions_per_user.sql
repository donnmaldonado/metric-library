select
    date_trunc('month', session_date) as period,
    platform,
    count(session_id) / nullif(count(distinct user_id), 0) as sessions_per_user
from {{ ref('fct_web_sessions') }}
group by 1, 2
