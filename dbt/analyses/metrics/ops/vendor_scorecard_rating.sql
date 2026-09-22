-- Equal-weight composite (weights unconfirmed).

select
    date_trunc('month', po_date) as period,
    supplier_id,
    avg((quality_score + delivery_score + cost_score) / 3) as vendor_scorecard_rating
from {{ ref('fct_purchase_orders') }}
group by 1, 2
order by 1, 2
