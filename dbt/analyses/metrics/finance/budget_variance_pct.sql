select
    date_trunc('month', period_start) as period,
    department,
    cost_center,
    (sum(actual_spend) - sum(budgeted_amount))
        / nullif(sum(budgeted_amount), 0) as budget_variance_pct
from {{ ref('fct_budget_lines') }}
group by all
order by all
