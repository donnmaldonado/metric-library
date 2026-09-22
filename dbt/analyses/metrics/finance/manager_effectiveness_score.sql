-- Average upward-feedback score, per month and manager.
select
    date_trunc('month', response_date) as period,
    manager_id,
    avg(manager_score) as manager_effectiveness_score
from {{ ref('fct_employee_survey_responses') }}
group by 1, 2
order by 1, 2
