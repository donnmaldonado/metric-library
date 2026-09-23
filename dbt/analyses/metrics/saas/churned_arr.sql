select
    date_trunc('month', movement_date) as period,
    segment,
    sum(-arr_delta) as churned_arr
from {{ ref('fct_arr_movements') }}
where movement_type = 'churn'
group by 1, 2
