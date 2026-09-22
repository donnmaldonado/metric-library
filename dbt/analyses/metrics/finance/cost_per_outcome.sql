-- Per-pupil expenditure / state-test proficiency rate, per school and year
-- (fiscal_year and school_year share labels such as '2024-25').
with spend as (
    select
        fiscal_year as school_year,
        school_id,
        sum(total_expenditure) / nullif(sum(avg_daily_membership), 0) as per_pupil_expenditure
    from {{ ref('fct_school_financials') }}
    group by 1, 2
),

proficiency as (
    select
        school_year,
        school_id,
        count(assessment_result_id) filter (where met_standard)
            / nullif(count(assessment_result_id), 0) as student_proficiency
    from {{ ref('fct_assessment_results') }}
    where assessment_type = 'state'
    group by 1, 2
)

select
    s.school_year,
    s.school_id,
    s.per_pupil_expenditure / nullif(p.student_proficiency, 0) as cost_per_outcome
from spend as s
inner join proficiency as p
    on p.school_year = s.school_year
    and p.school_id = s.school_id
order by 1, 2
