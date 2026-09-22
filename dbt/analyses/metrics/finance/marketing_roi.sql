-- Net return: (attributed revenue - spend) / spend. roas is the gross version (revenue / spend).
select
    date_trunc('month', ad_date) as period,
    campaign_name,
    (sum(attributed_revenue) - sum(spend)) / nullif(sum(spend), 0) as marketing_roi
from {{ ref('fct_ad_performance') }}
group by 1, 2
