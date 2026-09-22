-- One row per SLA-tracked service event.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as sla_event_id,
    cast(null as date   ) as event_date,
    cast(null as varchar) as client_id,
    cast(null as varchar) as service_type,
    cast(null as double ) as sla_met_count,
    cast(null as double ) as total_sla_events,
    cast(null as boolean) as is_sla_met
where false
