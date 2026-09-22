select
    date_trunc('month', trip_date) as period,
    fleet_type,
    sum(total_operating_cost) / nullif(sum(distance_miles), 0) as cost_per_mile
from {{ ref('fct_vehicle_trips') }}
group by 1, 2
order by 1, 2
