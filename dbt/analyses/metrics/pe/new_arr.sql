select
    date_trunc('month', movement_date) as period,
    segment,
    sum(arr_delta) as new_arr
from {{ ref('fct_arr_movements') }}
where movement_type = 'new_business'
group by 1, 2
