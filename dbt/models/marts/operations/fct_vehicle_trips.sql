-- One row per fleet vehicle trip (miles, hours in service, operating cost).
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- total_operating_cost is the fully loaded cost allocated to the trip (fuel,
-- maintenance, driver, depreciation). hours_in_service is the trip duration;
-- available_hours is the vehicle availability allocated to the trip's vehicle-day.
select
    cast(null as varchar  ) as trip_id,
    cast(null as date     ) as trip_date,
    cast(null as varchar  ) as vehicle_id,
    cast(null as varchar  ) as driver_id,
    cast(null as timestamp) as start_time,
    cast(null as timestamp) as end_time,
    cast(null as varchar  ) as fleet_type,
    cast(null as varchar  ) as region,
    cast(null as double   ) as distance_miles,
    cast(null as double   ) as total_operating_cost,
    cast(null as double   ) as hours_in_service,
    cast(null as double   ) as available_hours
where false
