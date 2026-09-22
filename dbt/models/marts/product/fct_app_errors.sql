-- One row per application error event.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as error_id,
    cast(null as date   ) as error_date,
    cast(null as varchar) as user_id,
    cast(null as varchar) as endpoint,
    cast(null as varchar) as error_type
where false
