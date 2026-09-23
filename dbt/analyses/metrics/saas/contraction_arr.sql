select
    date_trunc('month', movement_date) as period,
    segment,
    sum(-arr_delta) as contraction_arr
from {{ ref('fct_arr_movements') }}
where movement_type = 'contraction'
group by 1, 2
