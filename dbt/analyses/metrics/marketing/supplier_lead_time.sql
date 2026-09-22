select
    date_trunc('month', po_date) as period,
    supplier_id,
    avg(datediff('day', po_date, receipt_date)) as supplier_lead_time
from {{ ref('fct_purchase_orders') }}
group by 1, 2
order by 1, 2
