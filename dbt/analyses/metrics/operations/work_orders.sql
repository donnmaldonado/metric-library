select
    date_trunc('month', created_date) as period,
    count(work_order_id) as work_orders
from {{ ref('fct_work_orders') }}
group by 1
order by 1
