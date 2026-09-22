-- Active teachers on the year-end roster who return next year / active teachers on that roster.
select
    school_year,
    school_id,
    count(staff_id) filter (where returned_next_year)
        / nullif(count(staff_id), 0) as teacher_retention_rate
from {{ ref('dim_staff') }}
where role = 'teacher'
    and status = 'active'
    and as_of_date in (select max(as_of_date) from {{ ref('dim_staff') }} group by school_year)
group by 1, 2
order by 1, 2
