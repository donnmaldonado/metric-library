select
    date_trunc('month', created_date) as period,
    count(product_id) as stg_products_active
from {{ ref('dim_products') }}
where status = 'active'
group by 1
order by 1
