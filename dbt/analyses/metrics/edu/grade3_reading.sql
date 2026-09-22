-- Grade 3 students proficient on the state reading/ELA test / grade 3 enrollment, per school year.
with proficient as (
    select
        school_year,
        school_id,
        count(assessment_result_id) filter (where met_standard) as grade3_reading_proficient
    from {{ ref('fct_assessment_results') }}
    where assessment_type = 'state'
        and subject in ('ela', 'reading')
        and grade_level = '3'
    group by 1, 2
),

enrollment as (
    -- active students on the latest enrollment snapshot of each school year
    select
        school_year,
        school_id,
        count(distinct student_id) as enrollment_count
    from {{ ref('fct_enrollments') }}
    where status = 'active'
        and grade_level = '3'
        and snapshot_date in (select max(snapshot_date) from {{ ref('fct_enrollments') }} group by school_year)
    group by 1, 2
)

select
    e.school_year,
    e.school_id,
    coalesce(p.grade3_reading_proficient, 0) / nullif(e.enrollment_count, 0) as grade3_reading
from enrollment as e
left join proficient as p
    on p.school_year = e.school_year
    and p.school_id = e.school_id
order by 1, 2
