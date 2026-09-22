-- One row per deployment.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as deployment_id,
    cast(null as date   ) as deployed_date,
    cast(null as varchar) as team,
    cast(null as varchar) as service,
    cast(null as varchar) as environment,
    cast(null as double ) as lead_time_hours,
    cast(null as boolean) as is_failed
where false
