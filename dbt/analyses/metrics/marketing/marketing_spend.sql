select
    date_trunc('month', ad_date) as period,
    channel,
    campaign_name,
    sum(spend) as marketing_spend
from {{ ref('fct_ad_performance') }}
group by 1, 2, 3
