-- Average daily membership: student membership days / school days in session, per month.
select
    date_trunc('month', attendance_date) as period,
    school_id,
    count(record_id) / nullif(count(distinct attendance_date), 0) as adm
from {{ ref('fct_student_attendance') }}
group by 1, 2
order by 1, 2
