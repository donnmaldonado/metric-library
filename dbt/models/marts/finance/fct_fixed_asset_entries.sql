-- One row per fixed asset transaction (capex additions, depreciation, amortization).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as fixed_asset_entry_id,
    cast(null as date   ) as posted_date,
    cast(null as varchar) as company_id,
    cast(null as varchar) as asset_category,
    cast(null as double ) as capex_amount,
    cast(null as double ) as depreciation_amount,
    cast(null as double ) as amortization_amount
where false
