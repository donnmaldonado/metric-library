select
    date_trunc('month', score_date) as period,
    segment,
    avg(usage_score * 0.4 + engagement_score * 0.3 + support_score * 0.3) as customer_health_score
from {{ ref('fct_customer_health_scores') }}
group by 1, 2
