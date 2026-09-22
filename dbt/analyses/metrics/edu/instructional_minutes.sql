-- Average scheduled instructional minutes per student per school day, per month.
select
    date_trunc('month', attendance_date) as period,
    school_id,
    grade_level,
    avg(instructional_minutes) as instructional_minutes
from {{ ref('fct_student_attendance') }}
group by 1, 2, 3
order by 1, 2, 3
