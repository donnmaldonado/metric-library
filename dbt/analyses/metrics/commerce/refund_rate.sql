select
    date_trunc('month', order_date) as period,
    channel,
    count(case when is_refunded then 1 end)
        / nullif(count(*), 0) as refund_rate
from {{ ref('fct_orders') }}
group by 1, 2
order by 1, 2
