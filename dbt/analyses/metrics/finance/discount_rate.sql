select
    date_trunc('month', order_date) as period,
    channel,
    sum(discount_amount) / nullif(sum(order_amount), 0) as discount_rate
from {{ ref('fct_orders') }}
where status = 'completed'
group by 1, 2
order by 1, 2
