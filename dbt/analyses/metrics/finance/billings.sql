select
    date_trunc('month', invoice_date) as period,
    segment,
    product_tier,
    sum(invoice_amount) as billings
from {{ ref('fct_invoices') }}
group by all
order by all
