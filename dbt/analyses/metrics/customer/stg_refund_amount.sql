select
    date_trunc('month', return_date) as period,
    sum(refund_amount) as stg_refund_amount
from {{ ref('fct_returns') }}
group by 1
order by 1
