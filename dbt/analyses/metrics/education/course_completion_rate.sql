-- Completed course enrollments / course enrollments, per school year.
select
    school_year,
    school_id,
    count(course_enrollment_id) filter (where is_completed)
        / nullif(count(course_enrollment_id), 0) as course_completion_rate
from {{ ref('fct_course_enrollments') }}
group by 1, 2
order by 1, 2
