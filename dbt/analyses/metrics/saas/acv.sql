select
    date_trunc('month', signed_date) as period,
    segment,
    sum(contract_arr) / nullif(count(contract_id), 0) as acv
from {{ ref('fct_contracts') }}
group by 1, 2
