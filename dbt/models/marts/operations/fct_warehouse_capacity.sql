-- One row per warehouse zone and snapshot date with occupied and total capacity.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as warehouse_snapshot_id,
    cast(null as date   ) as snapshot_date,
    cast(null as varchar) as facility_id,
    cast(null as varchar) as warehouse_id,
    cast(null as varchar) as product_zone,
    cast(null as double ) as occupied_sqft,
    cast(null as double ) as total_sqft,
    cast(null as double ) as occupied_locations,
    cast(null as double ) as total_locations
where false
