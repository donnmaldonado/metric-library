-- Personnel cost / operating budget, per fiscal year and school.
select
    fiscal_year,
    school_id,
    sum(total_personnel_cost) / nullif(sum(total_operating_budget), 0) as staff_student_cost_ratio
from {{ ref('fct_school_financials') }}
group by 1, 2
order by 1, 2
