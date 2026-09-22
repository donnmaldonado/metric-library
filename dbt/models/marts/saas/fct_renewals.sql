-- One row per contract up for renewal.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as renewal_id,
    cast(null as date   ) as renewal_date,
    cast(null as varchar) as cs_rep_id,
    cast(null as varchar) as segment,
    cast(null as varchar) as plan_tier,
    cast(null as double ) as renewed_contracts,
    cast(null as double ) as up_for_renewal,
    cast(null as boolean) as is_renewed
where false
