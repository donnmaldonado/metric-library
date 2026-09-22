-- One row per event or webinar registration (attendance flag and allocated cost).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as event_registration_id,
    cast(null as date   ) as event_date,
    cast(null as varchar) as event,
    cast(null as varchar) as webinar,
    cast(null as varchar) as event_type,
    cast(null as boolean) as attended,
    cast(null as double ) as event_cost
where false
