select
    date_trunc('month', order_date) as period,
    channel,
    sum(order_amount) / nullif(count(order_id), 0) as aov
from {{ ref('fct_orders') }}
where status = 'completed'
group by 1, 2
order by 1, 2
