-- One row per returned item / refund.
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- units_returned is the quantity returned on this row. is_refunded is true when
-- the return was settled with a refund (refund_amount > 0) rather than an
-- exchange or store credit. Units sold (the return-rate denominator) come from
-- fct_order_lines.
select
    cast(null as varchar) as return_id,
    cast(null as date   ) as return_date,
    cast(null as varchar) as order_id,
    cast(null as varchar) as product_id,
    cast(null as varchar) as product_name,
    cast(null as varchar) as reason_code,
    cast(null as varchar) as product_category,
    cast(null as varchar) as channel,
    cast(null as varchar) as condition,
    cast(null as varchar) as disposition,
    cast(null as boolean) as is_refunded,
    cast(null as double ) as refund_amount,
    cast(null as double ) as units_returned
where false
