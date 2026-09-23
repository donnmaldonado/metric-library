select
    date_trunc('month', ad_date) as period,
    channel,
    campaign_name,
    sum(spend) * 1000 / nullif(sum(impressions), 0) as cpm
from {{ ref('fct_ad_performance') }}
group by 1, 2, 3
