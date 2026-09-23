select
    date_trunc('month', po_date) as period,
    supplier_id,
    count(case when is_compliant then 1 end)
        / nullif(count(*), 0) as vendor_compliance_rate
from {{ ref('fct_purchase_orders') }}
group by 1, 2
order by 1, 2
