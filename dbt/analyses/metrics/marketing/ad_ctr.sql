-- Alias of ctr.
select
    date_trunc('month', ad_date) as period,
    channel,
    ad,
    sum(clicks) / nullif(sum(impressions), 0) as ad_ctr
from {{ ref('fct_ad_performance') }}
group by 1, 2, 3
