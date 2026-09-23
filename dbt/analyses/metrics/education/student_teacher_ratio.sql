-- Active enrolled students / active teacher FTE, latest snapshots of each month.
with enrollment as (
    select
        date_trunc('month', snapshot_date) as period,
        school_id,
        count(distinct student_id) as enrollment_count
    from {{ ref('fct_enrollments') }}
    where status = 'active'
        and snapshot_date in (select max(snapshot_date) from {{ ref('fct_enrollments') }} group by date_trunc('month', snapshot_date))
    group by 1, 2
),

teachers as (
    select
        date_trunc('month', as_of_date) as period,
        school_id,
        sum(fte) as fte_teachers
    from {{ ref('dim_staff') }}
    where role = 'teacher'
        and status = 'active'
        and as_of_date in (select max(as_of_date) from {{ ref('dim_staff') }} group by date_trunc('month', as_of_date))
    group by 1, 2
)

select
    t.period,
    t.school_id,
    e.enrollment_count / nullif(t.fte_teachers, 0) as student_teacher_ratio
from teachers as t
left join enrollment as e
    on e.period = t.period
    and e.school_id = t.school_id
order by 1, 2
