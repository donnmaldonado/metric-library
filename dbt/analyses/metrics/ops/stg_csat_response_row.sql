-- Alias of csat.
select
    date_trunc('month', response_date) as period,
    avg(satisfaction_score) as stg_csat_response_row
from {{ ref('fct_customer_survey_responses') }}
group by 1
