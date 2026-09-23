-- (promoters - detractors) * 100 / responses, per month.
select
    date_trunc('month', response_date) as period,
    department,
    (count(enps_score) filter (where enps_score >= 9) - count(enps_score) filter (where enps_score <= 6))
        * 100.0 / nullif(count(enps_score), 0) as enps
from {{ ref('fct_employee_survey_responses') }}
group by 1, 2
order by 1, 2
