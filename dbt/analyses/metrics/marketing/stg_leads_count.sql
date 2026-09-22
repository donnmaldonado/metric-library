select
    date_trunc('month', created_date) as period,
    channel,
    count(lead_id) as stg_leads_count
from {{ ref('fct_leads') }}
group by 1, 2
