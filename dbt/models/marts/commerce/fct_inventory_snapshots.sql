-- One row per product, location and snapshot date (on-hand units, value, stockouts, shrinkage).
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- units_on_hand and unit_cost are balances as of snapshot_date (semi-additive).
-- item_id is the SKU. is_stocked_out = units_on_hand = 0.
-- inventory_shrinkage is a flow: the value written off (theft, damage,
-- administrative error) since the previous snapshot, so it sums over time.
select
    cast(null as varchar) as inventory_snapshot_id,
    cast(null as date   ) as snapshot_date,
    cast(null as varchar) as item_id,
    cast(null as varchar) as product_name,
    cast(null as varchar) as location,
    cast(null as double ) as units_on_hand,
    cast(null as double ) as unit_cost,
    cast(null as boolean) as is_stocked_out,
    cast(null as double ) as inventory_shrinkage
where false
