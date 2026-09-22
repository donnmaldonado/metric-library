select
    date_trunc('month', session_date) as period,
    channel,
    source,
    medium,
    count(session_id) as website_sessions
from {{ ref('fct_web_sessions') }}
group by 1, 2, 3, 4
