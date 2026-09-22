-- One row per marketplace transaction (buyer, seller, GMV, platform revenue).
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- transaction_value is the gross merchandise value before returns and fees;
-- platform_revenue is the fees the marketplace keeps on the transaction.
select
    cast(null as varchar) as transaction_id,
    cast(null as date   ) as transaction_date,
    cast(null as varchar) as buyer_id,
    cast(null as varchar) as seller_id,
    cast(null as varchar) as listing_id,
    cast(null as varchar) as category,
    cast(null as varchar) as channel,
    cast(null as varchar) as status,
    cast(null as varchar) as tier,
    cast(null as double ) as transaction_value,
    cast(null as double ) as platform_revenue
where false
