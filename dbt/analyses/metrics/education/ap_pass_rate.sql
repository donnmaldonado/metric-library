-- AP exams scored 3+ / AP exams taken, per school year and subject.
select
    school_year,
    subject,
    count(assessment_result_id) filter (where met_standard)
        / nullif(count(assessment_result_id), 0) as ap_pass_rate
from {{ ref('fct_assessment_results') }}
where assessment_type = 'ap'
group by 1, 2
order by 1, 2
