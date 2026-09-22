select
    date_trunc('month', event_date) as period,
    product_name,
    sum(purchase_amount) as iap_revenue
from {{ ref('fct_app_store') }}
where event_type = 'in_app_purchase'
group by 1, 2
