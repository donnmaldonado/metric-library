select
    date_trunc('month', invoice_date) as period,
    company_id,
    segment,
    sum(invoice_amount) as ar_aging_90d
from {{ ref('fct_invoices') }}
where days_outstanding > 90
  and status != 'paid'
group by all
order by all
