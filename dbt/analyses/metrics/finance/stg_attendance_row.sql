-- Daily attendance records, per month and school.
select
    date_trunc('month', attendance_date) as period,
    school_id,
    count(record_id) as stg_attendance_row
from {{ ref('fct_student_attendance') }}
group by 1, 2
order by 1, 2
