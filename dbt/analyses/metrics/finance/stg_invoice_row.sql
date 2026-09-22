select
    date_trunc('month', invoice_date) as period,
    status,
    sum(invoice_amount) as stg_invoice_row
from {{ ref('fct_invoices') }}
group by all
order by all
