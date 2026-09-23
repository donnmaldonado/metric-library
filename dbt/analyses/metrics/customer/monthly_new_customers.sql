select
    date_trunc('month', acquired_date) as period,
    segment,
    count(customer_id) as monthly_new_customers
from {{ ref('dim_customers') }}
group by 1, 2
