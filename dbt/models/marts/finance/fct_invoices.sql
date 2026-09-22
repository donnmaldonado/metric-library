-- One row per customer invoice (billings and accounts receivable).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as invoice_id,
    cast(null as date   ) as invoice_date,
    cast(null as varchar) as company_id,
    cast(null as varchar) as customer_id,
    cast(null as date   ) as due_date,
    cast(null as varchar) as segment,
    cast(null as double ) as days_outstanding,
    cast(null as varchar) as product_tier,
    cast(null as varchar) as status,
    cast(null as double ) as invoice_amount,
    cast(null as double ) as period_days
where false
