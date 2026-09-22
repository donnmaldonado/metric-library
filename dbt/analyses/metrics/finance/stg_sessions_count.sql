-- Alias of website_sessions.
select
    date_trunc('month', session_date) as period,
    platform,
    count(session_id) as stg_sessions_count
from {{ ref('fct_web_sessions') }}
group by 1, 2
