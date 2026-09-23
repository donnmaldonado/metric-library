select
    date_trunc('month', order_date) as period,
    warehouse_id,
    count(case when is_fully_shipped then 1 end)
        / nullif(count(*), 0) as fill_rate
from {{ ref('fct_order_lines') }}
group by 1, 2
order by 1, 2
