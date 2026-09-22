select
    date_trunc('month', fiscal_period_start) as period,
    company_id,
    sum(net_income) as net_income
from {{ ref('fct_income_statement') }}
group by all
order by all
