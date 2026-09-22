-- Alias of organic_sessions.
select
    date_trunc('month', session_date) as period,
    count(session_id) as organic_traffic
from {{ ref('fct_web_sessions') }}
where medium = 'organic'
group by 1
