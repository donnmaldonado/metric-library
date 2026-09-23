select
    date_trunc('month', ad_date) as period,
    channel,
    campaign_name,
    sum(spend) / nullif(sum(leads_generated), 0) as cpl
from {{ ref('fct_ad_performance') }}
group by 1, 2, 3
