select
    date_trunc('month', production_date) as period,
    production_line,
    avg(datediff('hour', start_time, complete_time)) as cycle_time
from {{ ref('fct_production_runs') }}
group by 1, 2
order by 1, 2
