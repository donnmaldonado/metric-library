-- Alias of chronic_absenteeism_rate: students absent 10%+ of enrolled days / enrolled students, per school year and grade.
select
    school_year,
    school_id,
    grade_level,
    count(distinct student_id) filter (where is_chronically_absent)
        / nullif(count(distinct student_id), 0) as chronic_absenteeism
from {{ ref('fct_student_attendance_years') }}
group by 1, 2, 3
order by 1, 2, 3
