-- One row per catalogued business process and catalog snapshot date.
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- as_of_date is the catalog snapshot date; counts are taken from the latest
-- snapshot in the period. is_automated: the process runs end to end without
-- manual intervention.
select
    cast(null as varchar) as process_id,
    cast(null as date   ) as as_of_date,
    cast(null as varchar) as process_name,
    cast(null as varchar) as department,
    cast(null as boolean) as is_automated
where false
