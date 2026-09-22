select
    date_trunc('month', response_date) as period,
    product_name,
    channel,
    support_team,
    avg(satisfaction_score) as csat
from {{ ref('fct_customer_survey_responses') }}
group by 1, 2, 3, 4
