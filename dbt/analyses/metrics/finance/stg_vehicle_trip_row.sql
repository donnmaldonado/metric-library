select
    date_trunc('month', trip_date) as period,
    count(trip_id) as stg_vehicle_trip_row
from {{ ref('fct_vehicle_trips') }}
group by 1
order by 1
