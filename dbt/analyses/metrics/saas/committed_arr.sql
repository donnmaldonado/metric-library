select
    date_trunc('month', signed_date) as period,
    segment,
    sum(contract_arr) as committed_arr
from {{ ref('fct_contracts') }}
where status = 'signed_not_started'
group by 1, 2
