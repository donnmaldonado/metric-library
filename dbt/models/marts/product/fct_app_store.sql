-- One row per app store event (download or in-app purchase).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as app_store_event_id,
    cast(null as date   ) as event_date,
    cast(null as varchar) as product_name,
    cast(null as varchar) as platform,
    cast(null as double ) as purchase_amount,
    cast(null as varchar) as event_type
where false
