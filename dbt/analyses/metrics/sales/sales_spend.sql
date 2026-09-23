select
    date_trunc('month', period_start) as period,
    team,
    sum(total_sales_cost) as sales_spend
from {{ ref('fct_sales_rep_periods') }}
group by 1, 2
