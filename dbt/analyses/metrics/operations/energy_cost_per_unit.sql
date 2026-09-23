select
    date_trunc('month', production_date) as period,
    facility_id,
    sum(energy_cost) / nullif(sum(units_produced), 0) as energy_cost_per_unit
from {{ ref('fct_production_runs') }}
group by 1, 2
order by 1, 2
