-- One row per quality inspection.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as inspection_id,
    cast(null as date   ) as inspection_date,
    cast(null as varchar) as product_id,
    cast(null as varchar) as supplier_id,
    cast(null as varchar) as production_line,
    cast(null as varchar) as result,
    cast(null as double ) as defective_units,
    cast(null as double ) as units_inspected
where false
