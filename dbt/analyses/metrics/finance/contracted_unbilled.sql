select
    date_trunc('month', signed_date) as period,
    segment,
    sum(contract_arr - coalesce(billed_amount, 0)) as contracted_unbilled
from {{ ref('fct_contracts') }}
where status = 'active'
group by 1, 2
