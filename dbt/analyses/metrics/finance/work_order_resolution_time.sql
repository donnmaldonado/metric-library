select
    date_trunc('month', created_date) as period,
    facility_id,
    priority,
    avg(datediff('day', created_date, completed_date)) as work_order_resolution_time
from {{ ref('fct_work_orders') }}
where status = 'completed'
group by 1, 2, 3
order by 1, 2, 3
