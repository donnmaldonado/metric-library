-- One row per API request.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as request_id,
    cast(null as date   ) as request_date,
    cast(null as varchar) as endpoint,
    cast(null as varchar) as environment,
    cast(null as varchar) as error_type,
    cast(null as varchar) as platform,
    cast(null as double ) as response_time_ms,
    cast(null as varchar) as consumer_id,
    cast(null as boolean) as is_error
where false
