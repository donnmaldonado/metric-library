select
    date_trunc('month', acquired_date) as period,
    segment,
    count(customer_id) as stg_customer_count
from {{ ref('dim_customers') }}
group by 1, 2
