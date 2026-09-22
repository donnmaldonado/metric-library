select
    date_trunc('month', trip_date) as period,
    fleet_type,
    sum(hours_in_service) / nullif(sum(available_hours), 0) as fleet_utilization_rate
from {{ ref('fct_vehicle_trips') }}
group by 1, 2
order by 1, 2
