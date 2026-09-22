-- One row per order line.
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- is_fully_shipped = qty_shipped >= qty_ordered.
select
    cast(null as varchar) as line_id,
    cast(null as date   ) as order_date,
    cast(null as varchar) as order_id,
    cast(null as varchar) as product_id,
    cast(null as varchar) as warehouse_id,
    cast(null as varchar) as status,
    cast(null as varchar) as product_category,
    cast(null as double ) as qty_ordered,
    cast(null as double ) as qty_shipped,
    cast(null as boolean) as is_fully_shipped
where false
