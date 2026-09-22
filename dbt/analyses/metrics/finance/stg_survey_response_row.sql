-- Average raw survey item score, per month.
select
    date_trunc('month', response_date) as period,
    avg(score) as stg_survey_response_row
from {{ ref('fct_employee_survey_responses') }}
group by 1
order by 1
