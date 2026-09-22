select
    date_trunc('month', created_date) as period,
    stage,
    sum(arr_value) as stg_opportunity_row
from {{ ref('fct_opportunities') }}
group by 1, 2
