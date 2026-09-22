select
    date_trunc('month', po_date) as period,
    sum(po_amount) as stg_purchase_order_row
from {{ ref('fct_purchase_orders') }}
group by 1
order by 1
