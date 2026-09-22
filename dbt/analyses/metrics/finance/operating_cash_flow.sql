select
    date_trunc('month', period_start) as period,
    company_id,
    sum(operating_cash_flow) as operating_cash_flow
from {{ ref('fct_cash_flow') }}
group by all
order by all
