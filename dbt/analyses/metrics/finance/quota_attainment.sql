select
    date_trunc('month', period_start) as period,
    rep_id,
    sum(arr_closed) / nullif(sum(quota), 0) as quota_attainment
from {{ ref('fct_sales_rep_periods') }}
group by 1, 2
