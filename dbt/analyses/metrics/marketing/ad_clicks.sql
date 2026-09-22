select
    date_trunc('month', ad_date) as period,
    channel,
    campaign_name,
    ad_set_name,
    sum(clicks) as ad_clicks
from {{ ref('fct_ad_performance') }}
group by 1, 2, 3, 4
