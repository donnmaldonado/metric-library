-- One row per signed customer contract.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as contract_id,
    cast(null as date   ) as signed_date,
    cast(null as varchar) as segment,
    cast(null as varchar) as product_tier,
    cast(null as varchar) as channel,
    cast(null as boolean) as billed,
    cast(null as varchar) as status,
    cast(null as double ) as contract_arr,
    cast(null as double ) as contract_value,
    cast(null as double ) as annualized_contract_value,
    cast(null as double ) as total_arr,
    cast(null as double ) as contract_count,
    cast(null as date   ) as start_date,
    cast(null as double ) as billed_amount
where false
