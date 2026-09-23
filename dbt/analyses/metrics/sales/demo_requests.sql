select
    date_trunc('month', created_date) as period,
    channel,
    count(lead_id) as demo_requests
from {{ ref('fct_leads') }}
where lead_source = 'demo_request'
group by 1, 2
