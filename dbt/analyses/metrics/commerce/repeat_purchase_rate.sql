select
    date_trunc('month', order_date) as period,
    segment,
    count(distinct case when is_repeat_order then customer_id end)
        / nullif(count(distinct customer_id), 0) as repeat_purchase_rate
from {{ ref('fct_orders') }}
group by 1, 2
order by 1, 2
