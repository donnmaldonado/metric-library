-- One row per customer account (segment, plan tier, geography, acquisition channel and cohort, onboarding milestones).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as customer_id,
    cast(null as date   ) as acquired_date,
    cast(null as varchar) as cs_rep_id,
    cast(null as varchar) as segment,
    cast(null as varchar) as product_name,
    cast(null as varchar) as status,
    cast(null as varchar) as acquisition_channel,
    cast(null as varchar) as channel,
    cast(null as varchar) as plan_tier,
    cast(null as varchar) as geography,
    cast(null as varchar) as cohort_month,
    cast(null as double ) as customer_age_days,
    cast(null as double ) as onboarding_days,
    cast(null as date   ) as contract_date,
    cast(null as date   ) as go_live_date
where false
