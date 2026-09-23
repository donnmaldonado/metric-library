select
    date_trunc('month', session_date) as period,
    channel,
    campaign_name,
    count(session_id) as paid_sessions
from {{ ref('fct_web_sessions') }}
where medium in ('cpc', 'cpm', 'paid')
group by 1, 2, 3
