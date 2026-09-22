select
    date_trunc('month', ad_date) as period,
    channel,
    sum(spend) / nullif(sum(new_customers_acquired), 0) as marketing_cac
from {{ ref('fct_ad_performance') }}
group by 1, 2
