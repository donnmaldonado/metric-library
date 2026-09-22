select
    date_trunc('month', transaction_date) as period,
    category,
    sum(transaction_value) as gmv
from {{ ref('fct_marketplace_transactions') }}
group by 1, 2
order by 1, 2
