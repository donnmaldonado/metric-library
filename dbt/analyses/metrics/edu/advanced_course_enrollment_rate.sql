-- Students in at least one AP, IB or dual-enrollment course / active enrollment, per school year.
with advanced as (
    select
        school_year,
        school_id,
        count(distinct student_id) as advanced_course_students
    from {{ ref('fct_course_enrollments') }}
    where course_level in ('ap', 'ib', 'dual_enrollment')
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
        and snapshot_date in (select max(snapshot_date) from {{ ref('fct_enrollments') }} group by school_year)
    group by 1, 2
)

select
    e.school_year,
    e.school_id,
    coalesce(a.advanced_course_students, 0) / nullif(e.enrollment_count, 0) as advanced_course_enrollment_rate
from enrollment as e
left join advanced as a
    on a.school_year = e.school_year
    and a.school_id = e.school_id
order by 1, 2
