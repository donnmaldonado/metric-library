-- Cohort students who dropped out / students in the cohort, per cohort.
select
    cohort_year,
    school_id,
    count(student_cohort_outcome_id) filter (where dropped_out)
        / nullif(count(student_cohort_outcome_id), 0) as dropout_rate
from {{ ref('fct_student_cohort_outcomes') }}
group by 1, 2
order by 1, 2
