select
    date_trunc('month', created_date) as period,
    segment,
    sum(arr_value) as pipeline_value
from {{ ref('fct_opportunities') }}
where not is_closed
group by 1, 2
