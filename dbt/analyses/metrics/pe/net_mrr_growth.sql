select
    date_trunc('month', movement_date) as period,
    segment,
    sum(arr_delta) / 12 as net_mrr_growth
from {{ ref('fct_arr_movements') }}
group by 1, 2
