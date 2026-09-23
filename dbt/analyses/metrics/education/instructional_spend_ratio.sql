-- Instructional spending / total operating expenditure, per fiscal year.
select
    fiscal_year,
    sum(instructional_expenditure) / nullif(sum(total_expenditure), 0) as instructional_spend_ratio
from {{ ref('fct_school_financials') }}
group by 1
order by 1
