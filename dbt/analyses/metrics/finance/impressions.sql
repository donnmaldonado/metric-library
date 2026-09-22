select
    date_trunc('month', ad_date) as period,
    channel,
    campaign_name,
    ad_set_name,
    sum(impressions) as impressions
from {{ ref('fct_ad_performance') }}
group by 1, 2, 3, 4
