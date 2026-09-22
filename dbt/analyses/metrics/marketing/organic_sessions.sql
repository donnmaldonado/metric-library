select
    date_trunc('month', session_date) as period,
    landing_page,
    device,
    count(session_id) as organic_sessions
from {{ ref('fct_web_sessions') }}
where medium = 'organic'
group by 1, 2, 3
