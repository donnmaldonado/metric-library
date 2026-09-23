-- Distinct students with an expulsion / active enrollment, per school year.
with disciplined as (
    select
        school_year,
        school_id,
        count(distinct student_id) as disciplined_students
    from {{ ref('fct_discipline_incidents') }}
    where consequence = 'expulsion'
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
    coalesce(d.disciplined_students, 0) / nullif(e.enrollment_count, 0) as expulsion_rate
from enrollment as e
left join disciplined as d
    on d.school_year = e.school_year
    and d.school_id = e.school_id
order by 1, 2
