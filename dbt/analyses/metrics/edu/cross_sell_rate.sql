select
    date_trunc('month', order_date) as period,
    segment,
    count(distinct case when customer_is_multi_category then customer_id end)
        / nullif(count(distinct customer_id), 0) as cross_sell_rate
from {{ ref('fct_orders') }}
group by 1, 2
order by 1, 2
