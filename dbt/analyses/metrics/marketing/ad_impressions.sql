-- Alias of impressions.
select
    date_trunc('month', ad_date) as period,
    channel,
    ad,
    sum(impressions) as ad_impressions
from {{ ref('fct_ad_performance') }}
group by 1, 2, 3
