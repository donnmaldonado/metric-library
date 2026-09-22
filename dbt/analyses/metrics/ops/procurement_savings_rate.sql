select
    date_trunc('month', po_date) as period,
    spend_category,
    sum(baseline_spend - actual_spend) / nullif(sum(baseline_spend), 0) as procurement_savings_rate
from {{ ref('fct_purchase_orders') }}
group by 1, 2
order by 1, 2
