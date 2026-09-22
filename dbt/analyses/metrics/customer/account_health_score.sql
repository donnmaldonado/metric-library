select
    date_trunc('month', score_date) as period,
    segment,
    avg(usage_score * 0.4 + nps_score * 0.3 + support_score * 0.3) as account_health_score
from {{ ref('fct_customer_health_scores') }}
group by 1, 2
