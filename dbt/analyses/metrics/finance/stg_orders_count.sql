select
    date_trunc('month', order_date) as period,
    count(order_id) as stg_orders_count
from {{ ref('fct_orders') }}
group by 1
order by 1
