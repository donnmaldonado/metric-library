-- ELL students gaining at least one proficiency level / ELL students assessed, per school year.
select
    school_year,
    school_id,
    count(assessment_result_id) filter (where proficiency_level_gain >= 1)
        / nullif(count(assessment_result_id), 0) as ell_proficiency_growth
from {{ ref('fct_assessment_results') }}
where assessment_type = 'ell'
group by 1, 2
order by 1, 2
