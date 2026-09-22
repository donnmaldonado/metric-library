-- Alias of marketing_spend: daily ad spend rows rolled up to the month.
select
    date_trunc('month', ad_date) as period,
    channel,
    campaign_id,
    ad_set_id,
    sum(spend) as stg_ad_spend_row
from {{ ref('fct_ad_performance') }}
group by 1, 2, 3, 4
