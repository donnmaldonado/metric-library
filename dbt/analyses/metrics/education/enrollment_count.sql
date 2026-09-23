-- Active enrolled students on the latest enrollment snapshot of each month.
select
    date_trunc('month', snapshot_date) as period,
    school_id,
    grade_level,
    count(distinct student_id) as enrollment_count
from {{ ref('fct_enrollments') }}
where status = 'active'
    and snapshot_date in (select max(snapshot_date) from {{ ref('fct_enrollments') }} group by date_trunc('month', snapshot_date))
group by 1, 2, 3
order by 1, 2, 3
