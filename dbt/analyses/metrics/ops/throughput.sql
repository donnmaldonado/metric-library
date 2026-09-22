select
    date_trunc('month', production_date) as period,
    production_line,
    sum(units_produced) as throughput
from {{ ref('fct_production_runs') }}
group by 1, 2
order by 1, 2
