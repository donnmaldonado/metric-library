-- Average raw assessment score, per month and subject.
select
    date_trunc('month', assessment_date) as period,
    subject,
    avg(score) as stg_student_assessment_row
from {{ ref('fct_assessment_results') }}
group by 1, 2
order by 1, 2
