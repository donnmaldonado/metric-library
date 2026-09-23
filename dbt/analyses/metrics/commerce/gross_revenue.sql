select
    date_trunc('month', order_date) as period,
    channel,
    sum(order_amount) as gross_revenue
from {{ ref('fct_orders') }}
where status = 'completed'
group by 1, 2
order by 1, 2
