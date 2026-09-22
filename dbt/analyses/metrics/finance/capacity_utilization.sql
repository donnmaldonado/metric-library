select
    date_trunc('month', production_date) as period,
    production_line,
    sum(actual_output) / nullif(sum(max_capacity), 0) as capacity_utilization
from {{ ref('fct_production_runs') }}
group by 1, 2
order by 1, 2
