-- One row per service/system and period with uptime, downtime and failure counts.
-- Stub: returns zero rows with the typed columns the metric library needs.
-- Downtime-event columns (event_id, start_time, cause, duration_hours) are populated on rows that represent a
-- single downtime event (see Known issues in the README).
select
    cast(null as varchar  ) as availability_window_id,
    cast(null as date     ) as period_start,
    cast(null as varchar  ) as system_id,
    cast(null as varchar  ) as facility_id,
    cast(null as timestamp) as start_time,
    cast(null as varchar  ) as cause,
    cast(null as double   ) as duration_hours,
    cast(null as varchar  ) as service,
    cast(null as varchar  ) as environment,
    cast(null as varchar  ) as event_id,
    cast(null as double   ) as failure_count,
    cast(null as double   ) as available_minutes,
    cast(null as double   ) as scheduled_minutes
where false
