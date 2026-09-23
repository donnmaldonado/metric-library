select
    date_trunc('month', order_date) as period,
    channel,
    sum(order_amount) - sum(returned_amount) - sum(discount_amount) as net_revenue
from {{ ref('fct_orders') }}
where status = 'completed'
group by 1, 2
order by 1, 2
