select
    date_trunc('month', invoice_date) as period,
    sum(invoice_amount) as stg_invoices_amount
from {{ ref('fct_invoices') }}
group by all
order by all
