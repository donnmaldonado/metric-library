select
    date_trunc('month', score_date) as period,
    plan_tier,
    avg(churn_probability) as churn_prediction_score
from {{ ref('fct_churn_scores') }}
group by 1, 2
