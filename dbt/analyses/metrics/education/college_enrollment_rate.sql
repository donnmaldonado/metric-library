-- Graduates enrolled in a 2- or 4-year college within 16 months / graduates, per graduating class.
select
    grad_year,
    school_id,
    count(student_cohort_outcome_id) filter (where is_graduate and enrolled_college_within_16_months)
        / nullif(count(student_cohort_outcome_id) filter (where is_graduate), 0) as college_enrollment_rate
from {{ ref('fct_student_cohort_outcomes') }}
group by 1, 2
order by 1, 2
