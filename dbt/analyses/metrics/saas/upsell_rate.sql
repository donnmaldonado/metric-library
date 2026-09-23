select
    date_trunc('month', period_start) as period,
    segment,
    sum(upsold_customers) / nullif(sum(beginning_customers), 0) as upsell_rate
from {{ ref('fct_customer_movements') }}
group by 1, 2
