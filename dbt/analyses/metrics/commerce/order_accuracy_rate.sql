select
    date_trunc('month', ship_date) as period,
    warehouse_id,
    count(distinct case when order_is_accurate then order_id end)
        / nullif(count(distinct order_id), 0) as order_accuracy_rate
from {{ ref('fct_shipments') }}
group by 1, 2
order by 1, 2
