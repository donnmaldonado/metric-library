select
    date_trunc('month', created_date) as period,
    sum(case when channel = 'organic' then arr_value else 0 end)
        / nullif(sum(arr_value), 0) as organic_attribution_pct
from {{ ref('fct_opportunities') }}
group by 1
