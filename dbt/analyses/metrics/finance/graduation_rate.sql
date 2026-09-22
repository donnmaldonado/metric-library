-- Alias of four_year_grad_rate. On-time (4-year) graduates / adjusted 9th-grade cohort (excludes transfers out), per cohort.
select
    cohort_year,
    school_id,
    count(student_cohort_outcome_id) filter (where graduated_in_4_years and not transferred_out)
        / nullif(count(student_cohort_outcome_id) filter (where not transferred_out), 0) as graduation_rate
from {{ ref('fct_student_cohort_outcomes') }}
group by 1, 2
order by 1, 2
