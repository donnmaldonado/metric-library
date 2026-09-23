select
    date_trunc('month', created_date) as period,
    channel,
    count(lead_id) as leads
from {{ ref('fct_leads') }}
group by 1, 2
