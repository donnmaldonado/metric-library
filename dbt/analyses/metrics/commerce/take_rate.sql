select
    date_trunc('month', transaction_date) as period,
    category,
    sum(platform_revenue) / nullif(sum(transaction_value), 0) as take_rate
from {{ ref('fct_marketplace_transactions') }}
group by 1, 2
order by 1, 2
