select
    date_trunc('month', movement_date) as period,
    sum(case when movement_type in ('new_business', 'expansion') then arr_delta else 0 end)
        / nullif(sum(case when movement_type in ('contraction', 'churn') then -arr_delta else 0 end), 0)
        as saas_quick_ratio
from {{ ref('fct_arr_movements') }}
group by 1
