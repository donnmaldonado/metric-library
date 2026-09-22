-- Alias of chronic_absenteeism_rate, by subgroup: students absent 10%+ of enrolled days / enrolled students, per school year.
select
    school_year,
    school_id,
    subgroup,
    count(distinct student_id) filter (where is_chronically_absent)
        / nullif(count(distinct student_id), 0) as absenteeism_by_subgroup
from {{ ref('fct_student_attendance_years') }}
group by 1, 2, 3
order by 1, 2, 3
