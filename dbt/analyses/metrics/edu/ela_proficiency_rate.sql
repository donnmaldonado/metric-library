-- ELA state assessment results at or above proficiency / ELA results tested, per school year.
select
    school_year,
    school_id,
    count(assessment_result_id) filter (where met_standard)
        / nullif(count(assessment_result_id), 0) as ela_proficiency_rate
from {{ ref('fct_assessment_results') }}
where assessment_type = 'state'
and subject = 'ela'
group by 1, 2
order by 1, 2
