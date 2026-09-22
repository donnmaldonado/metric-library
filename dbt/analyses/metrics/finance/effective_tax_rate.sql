select
    date_trunc('month', fiscal_period_start) as period,
    company_id,
    jurisdiction,
    sum(income_tax_expense) / nullif(sum(pretax_income), 0) as effective_tax_rate
from {{ ref('fct_income_statement') }}
group by all
order by all
