select
    date_trunc('month', period_start) as period,
    team,
    sum(qualified_pipeline) / nullif(sum(remaining_quota), 0) as pipeline_coverage
from {{ ref('fct_sales_rep_periods') }}
group by 1, 2
