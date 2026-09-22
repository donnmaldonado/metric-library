select
    date_trunc('month', session_date) as period,
    channel,
    count(case when created_lead then session_id end) / nullif(count(session_id), 0) as session_to_lead_rate
from {{ ref('fct_web_sessions') }}
group by 1, 2
