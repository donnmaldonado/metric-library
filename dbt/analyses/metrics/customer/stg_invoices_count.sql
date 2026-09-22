select
    date_trunc('month', invoice_date) as period,
    count(invoice_id) as stg_invoices_count
from {{ ref('fct_invoices') }}
group by all
order by all
