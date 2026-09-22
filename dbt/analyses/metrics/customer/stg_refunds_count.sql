select
    date_trunc('month', return_date) as period,
    count(return_id) as stg_refunds_count
from {{ ref('fct_returns') }}
where is_refunded
group by 1
order by 1
