select
    date_trunc('month', ship_date) as period,
    carrier,
    avg(datediff('day', order_date, delivery_date)) as lead_time
from {{ ref('fct_shipments') }}
group by 1, 2
order by 1, 2
