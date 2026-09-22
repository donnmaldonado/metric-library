select
    date_trunc('month', return_date) as period,
    reason_code,
    count(return_id) as stg_return_row
from {{ ref('fct_returns') }}
group by 1, 2
order by 1, 2
