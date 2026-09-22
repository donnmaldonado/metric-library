-- One row per company, fiscal period and product line with current and prior price/volume components.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as ebitda_bridge_line_id,
    cast(null as date   ) as fiscal_period_start,
    cast(null as varchar) as company_id,
    cast(null as varchar) as product_line,
    cast(null as double ) as avg_price,
    cast(null as double ) as prior_avg_price,
    cast(null as double ) as prior_volume,
    cast(null as double ) as current_volume
where false
