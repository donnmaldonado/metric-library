-- Alias of paid_sessions.
select
    date_trunc('month', session_date) as period,
    count(session_id) as paid_traffic
from {{ ref('fct_web_sessions') }}
where medium in ('cpc', 'cpm', 'paid')
group by 1
