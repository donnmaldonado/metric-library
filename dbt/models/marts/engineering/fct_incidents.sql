-- One row per production incident or repair.
-- Stub: returns zero rows with the typed columns the metric library needs.
-- total_repair_hours, repair_count, incidents_with_root_cause and total_incidents are unused pre-aggregates;
-- the library metrics use the timestamps and has_root_cause.
select
    cast(null as varchar  ) as incident_id,
    cast(null as date     ) as incident_date,
    cast(null as varchar  ) as service,
    cast(null as varchar  ) as severity,
    cast(null as timestamp) as incident_start,
    cast(null as timestamp) as detection_time,
    cast(null as timestamp) as resolved_at,
    cast(null as boolean  ) as has_root_cause,
    cast(null as double   ) as total_repair_hours,
    cast(null as double   ) as repair_count,
    cast(null as double   ) as incidents_with_root_cause,
    cast(null as double   ) as total_incidents
where false
