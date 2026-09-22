-- Alias of employee_engagement_score. Average engagement composite score, per month.
select
    date_trunc('month', response_date) as period,
    department,
    avg(composite_score) as engagement_score
from {{ ref('fct_employee_survey_responses') }}
group by 1, 2
order by 1, 2
