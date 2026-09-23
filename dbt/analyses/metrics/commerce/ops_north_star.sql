select
    date_trunc('month', ship_date) as period,
    warehouse_id,
    count(distinct case when order_is_on_time and order_is_complete and order_is_accurate and order_is_undamaged then order_id end)
        / nullif(count(distinct order_id), 0) as ops_north_star
from {{ ref('fct_shipments') }}
group by 1, 2
order by 1, 2
