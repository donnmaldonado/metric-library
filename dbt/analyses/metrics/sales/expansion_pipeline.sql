select
    date_trunc('month', created_date) as period,
    segment,
    sum(arr_value) as expansion_pipeline
from {{ ref('fct_opportunities') }}
where opportunity_type = 'expansion'
  and not is_closed
group by 1, 2
