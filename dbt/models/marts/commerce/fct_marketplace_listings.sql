-- One row per marketplace listing and day.
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- is_active: the listing was live on listing_date.
-- has_transaction: the listing sold at least once on listing_date.
select
    cast(null as varchar) as listing_day_id,
    cast(null as date   ) as listing_date,
    cast(null as varchar) as listing_id,
    cast(null as varchar) as seller_id,
    cast(null as varchar) as category,
    cast(null as boolean) as is_active,
    cast(null as boolean) as has_transaction
where false
