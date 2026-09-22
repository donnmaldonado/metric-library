select
    date_trunc('month', order_date) as period,
    segment,
    count(order_id) / nullif(count(distinct customer_id), 0) as purchase_frequency
from {{ ref('fct_orders') }}
group by 1, 2
order by 1, 2
