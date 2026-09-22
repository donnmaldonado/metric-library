-- One row per maintenance work order.
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- maintenance_type is 'preventive' (planned) or 'reactive' (breakdown/corrective).
select
    cast(null as varchar) as work_order_id,
    cast(null as date   ) as created_date,
    cast(null as date   ) as completed_date,
    cast(null as varchar) as facility_id,
    cast(null as varchar) as category,
    cast(null as varchar) as priority,
    cast(null as varchar) as asset_type,
    cast(null as varchar) as maintenance_type,
    cast(null as varchar) as status
where false
