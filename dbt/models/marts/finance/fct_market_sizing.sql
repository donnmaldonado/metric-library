-- One row per market segment, geography and estimate date (TAM/SAM and company revenue).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as market_estimate_id,
    cast(null as date   ) as as_of_date,
    cast(null as varchar) as region,
    cast(null as varchar) as segment,
    cast(null as varchar) as geography,
    cast(null as double ) as sam_estimate,
    cast(null as double ) as tam_estimate,
    cast(null as double ) as company_revenue
where false
