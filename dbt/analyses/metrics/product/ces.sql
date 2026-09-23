select
    date_trunc('month', response_date) as period,
    channel,
    interaction_type,
    avg(effort_score) as ces
from {{ ref('fct_customer_survey_responses') }}
group by 1, 2, 3
