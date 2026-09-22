-- Alias of website_sessions.
select
    date_trunc('month', session_date) as period,
    source,
    medium,
    landing_page,
    count(session_id) as stg_session_row
from {{ ref('fct_web_sessions') }}
group by 1, 2, 3, 4
