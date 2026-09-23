-- Total operating expenditure / state-reported ADM, per fiscal year and school.
select
    fiscal_year,
    school_id,
    sum(total_expenditure) / nullif(sum(avg_daily_membership), 0) as per_pupil_expenditure
from {{ ref('fct_school_financials') }}
group by 1, 2
order by 1, 2
