-- Cohort students who reached grade 12 and completed the FAFSA / cohort students who reached grade 12.
select
    cohort_year,
    school_id,
    count(student_cohort_outcome_id) filter (where completed_fafsa)
        / nullif(count(student_cohort_outcome_id), 0) as fafsa_completion_rate
from {{ ref('fct_student_cohort_outcomes') }}
where reached_grade_12
group by 1, 2
order by 1, 2
