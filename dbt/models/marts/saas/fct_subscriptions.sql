-- One row per subscription per snapshot date (active subscriptions, MRR).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as subscription_snapshot_id,
    cast(null as date   ) as snapshot_date,
    cast(null as varchar) as company_id,
    cast(null as varchar) as customer_id,
    cast(null as date   ) as start_date,
    cast(null as varchar) as subscription_status,
    cast(null as varchar) as plan_tier,
    cast(null as varchar) as status,
    cast(null as varchar) as segment,
    cast(null as varchar) as product_name,
    cast(null as varchar) as user_id,
    cast(null as double ) as monthly_amount,
    cast(null as varchar) as subscription_id,
    cast(null as boolean) as is_active_30d
where false
