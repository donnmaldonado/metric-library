select
    date_trunc('month', period_start) as period,
    company_id,
    sum(beginning_cash - ending_cash) as burn_rate
from {{ ref('fct_cash_flow') }}
group by all
order by all
