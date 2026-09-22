select
    date_trunc('month', transaction_date) as period,
    count(distinct buyer_id) as marketplace_buyers
from {{ ref('fct_marketplace_transactions') }}
group by 1
order by 1
