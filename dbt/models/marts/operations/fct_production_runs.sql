-- One row per production run / work item (output, capacity, cost, energy and emissions).
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- actual_output and units_produced are good units completed by the run;
-- max_capacity is the theoretical maximum output of the line over the run window.
select
    cast(null as varchar  ) as production_run_id,
    cast(null as date     ) as production_date,
    cast(null as varchar  ) as facility_id,
    cast(null as varchar  ) as plant_id,
    cast(null as varchar  ) as product_id,
    cast(null as varchar  ) as product_name,
    cast(null as varchar  ) as line,
    cast(null as varchar  ) as production_line,
    cast(null as varchar  ) as process_type,
    cast(null as timestamp) as start_time,
    cast(null as timestamp) as complete_time,
    cast(null as double   ) as actual_output,
    cast(null as double   ) as max_capacity,
    cast(null as double   ) as total_co2e_kg,
    cast(null as double   ) as units_produced,
    cast(null as double   ) as total_production_cost,
    cast(null as double   ) as energy_cost
where false
