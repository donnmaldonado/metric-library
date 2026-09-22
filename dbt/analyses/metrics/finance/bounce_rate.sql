select
    date_trunc('month', session_date) as period,
    landing_page,
    channel,
    device,
    count(case when is_bounce then session_id end) / nullif(count(session_id), 0) as bounce_rate
from {{ ref('fct_web_sessions') }}
group by 1, 2, 3, 4
