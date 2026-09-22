select
    date_trunc('month', period_start) as period,
    department,
    sum(budgeted_amount) as annual_budget
from {{ ref('fct_budget_lines') }}
group by all
order by all
