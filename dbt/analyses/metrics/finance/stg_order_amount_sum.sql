select
    date_trunc('month', order_date) as period,
    sum(order_amount) as stg_order_amount_sum
from {{ ref('fct_orders') }}
group by 1
order by 1
