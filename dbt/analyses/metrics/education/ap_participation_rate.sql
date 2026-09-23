-- Grade 11-12 students in at least one AP course / grade 11-12 enrollment, per school year.
with ap as (
    select
        school_year,
        school_id,
        count(distinct student_id) as students_in_ap_courses
    from {{ ref('fct_course_enrollments') }}
    where course_level = 'ap'
        and grade_level in ('11', '12')
    group by 1, 2
),

enrollment as (
    -- active students on the latest enrollment snapshot of each school year
    select
        school_year,
        school_id,
        count(distinct student_id) as enrollment_count
    from {{ ref('fct_enrollments') }}
    where status = 'active'
        and grade_level in ('11', '12')
        and snapshot_date in (select max(snapshot_date) from {{ ref('fct_enrollments') }} group by school_year)
    group by 1, 2
)

select
    e.school_year,
    e.school_id,
    coalesce(a.students_in_ap_courses, 0) / nullif(e.enrollment_count, 0) as ap_participation_rate
from enrollment as e
left join ap as a
    on a.school_year = e.school_year
    and a.school_id = e.school_id
order by 1, 2
