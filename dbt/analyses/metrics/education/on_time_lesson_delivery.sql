-- Lessons delivered on schedule / planned lessons, per month and teacher.
select
    date_trunc('month', planned_date) as period,
    school_id,
    teacher_id,
    count(lesson_id) filter (where delivered_on_time)
        / nullif(count(lesson_id), 0) as on_time_lesson_delivery
from {{ ref('fct_lessons') }}
group by 1, 2, 3
order by 1, 2, 3
