select
    date_trunc('month', ship_date) as period,
    carrier,
    count(shipment_id) as stg_shipment_row
from {{ ref('fct_shipments') }}
group by 1, 2
order by 1, 2
