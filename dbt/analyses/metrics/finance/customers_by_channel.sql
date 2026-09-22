select
    date_trunc('month', acquired_date) as period,
    acquisition_channel,
    count(customer_id) as customers_by_channel
from {{ ref('dim_customers') }}
group by 1, 2
