-- Active enrolled students / available seats, latest snapshots of each month.
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

seats as (
    select
        date_trunc('month', period_start) as period,
        school_id,
        sum(total_seats) as total_seats
    from {{ ref('fct_school_periods') }}
    where period_start in (select max(period_start) from {{ ref('fct_school_periods') }} group by date_trunc('month', period_start))
    group by 1, 2
)

select
    s.period,
    s.school_id,
    coalesce(e.enrollment_count, 0) / nullif(s.total_seats, 0) as seat_fill_rate
from seats as s
left join enrollment as e
    on e.period = s.period
    and e.school_id = s.school_id
order by 1, 2
