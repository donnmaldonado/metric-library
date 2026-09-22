-- Average years of experience of active teachers, latest roster snapshot of each school year.
select
    school_year,
    school_id,
    avg(years_of_experience) as avg_teacher_experience
from {{ ref('dim_staff') }}
where role = 'teacher'
    and status = 'active'
    and as_of_date in (select max(as_of_date) from {{ ref('dim_staff') }} group by school_year)
group by 1, 2
order by 1, 2
