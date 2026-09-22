select
    date_trunc('month', ad_date) as period,
    channel,
    campaign_name,
    sum(attributed_revenue) / nullif(sum(spend), 0) as roas
from {{ ref('fct_ad_performance') }}
group by 1, 2, 3
