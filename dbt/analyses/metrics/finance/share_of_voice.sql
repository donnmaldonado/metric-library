select
    date_trunc('month', metric_date) as period,
    platform,
    keyword_group,
    sum(brand_mentions) / nullif(sum(total_category_mentions), 0) as share_of_voice
from {{ ref('fct_social_metrics') }}
group by 1, 2, 3
