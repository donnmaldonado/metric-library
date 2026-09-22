select
    date_trunc('month', close_date) as period,
    avg(datediff('day', created_date, close_date)) as avg_sales_cycle
from {{ ref('fct_opportunities') }}
where is_won
group by 1
