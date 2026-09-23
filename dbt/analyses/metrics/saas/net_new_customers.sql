select
    date_trunc('month', period_start) as period,
    segment,
    sum(new_customers - churned_customers) as net_new_customers
from {{ ref('fct_customer_movements') }}
group by 1, 2
