-- Enrollment records (any status) on the latest enrollment snapshot of each month.
select
    date_trunc('month', snapshot_date) as period,
    count(enrollment_id) as stg_enrollment_row
from {{ ref('fct_enrollments') }}
where snapshot_date in (select max(snapshot_date) from {{ ref('fct_enrollments') }} group by date_trunc('month', snapshot_date))
group by 1
order by 1
