select
    date_trunc('month', response_date) as period,
    sum(responses_received) / nullif(sum(surveys_sent), 0) as survey_response_rate
from {{ ref('fct_customer_survey_responses') }}
group by 1
