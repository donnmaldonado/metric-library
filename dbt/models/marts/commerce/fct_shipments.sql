-- One row per shipment / delivery, with fulfillment and order-quality flags.
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- Shipment-level flags: is_delivered (delivery_date is not null) and
-- is_on_time (delivery_date <= committed_date).
-- Order-level flags (the same value on every shipment of the order, so that
-- count(distinct order_id) filtered on them counts orders):
--   order_is_on_time    every shipment of the order delivered by its committed date
--   order_is_complete   every line shipped in full
--   order_is_accurate   no picking, quantity or address error reported
--   order_is_undamaged  no damage claim reported
-- A perfect order has all four; a fulfilled order is complete and on time.
select
    cast(null as varchar) as shipment_id,
    cast(null as date   ) as ship_date,
    cast(null as varchar) as order_id,
    cast(null as varchar) as warehouse_id,
    cast(null as date   ) as order_date,
    cast(null as date   ) as committed_date,
    cast(null as date   ) as delivery_date,
    cast(null as varchar) as product_name,
    cast(null as varchar) as carrier,
    cast(null as varchar) as status,
    cast(null as varchar) as region,
    cast(null as varchar) as product_category,
    cast(null as boolean) as is_delivered,
    cast(null as boolean) as is_on_time,
    cast(null as boolean) as order_is_on_time,
    cast(null as boolean) as order_is_complete,
    cast(null as boolean) as order_is_accurate,
    cast(null as boolean) as order_is_undamaged
where false
