-- Student days present (present or tardy) / student membership days, per month.
select
    date_trunc('month', attendance_date) as period,
    school_id,
    count(record_id) filter (where status in ('present', 'tardy'))
        / nullif(count(record_id), 0) as student_attendance_rate
from {{ ref('fct_student_attendance') }}
group by 1, 2
order by 1, 2
