-- Average raw NPS score (0-10); nps is the promoter/detractor score.
select
    date_trunc('month', response_date) as period,
    avg(score) as stg_nps_response_row
from {{ ref('fct_customer_survey_responses') }}
where survey_type = 'nps'
group by 1
