select
    date_trunc('month', period_start) as period,
    department,
    sum(actual_spend) - sum(budgeted_amount) as budget_variance
from {{ ref('fct_budget_lines') }}
group by all
order by all
