-- One row per general ledger posting (opex, COGS and other expense lines).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as gl_entry_id,
    cast(null as date   ) as posted_date,
    cast(null as varchar) as company_id,
    cast(null as varchar) as product_id,
    cast(null as varchar) as product_line,
    cast(null as varchar) as department,
    cast(null as varchar) as gl_category,
    cast(null as varchar) as cost_center,
    cast(null as varchar) as gl_account,
    cast(null as double ) as cogs_amount,
    cast(null as double ) as opex_amount,
    cast(null as double ) as expense_amount,
    cast(null as double ) as ga_spend,
    cast(null as double ) as rd_spend
where false
