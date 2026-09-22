-- One row per segment and period with beginning, new, churned and upsold customer counts.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as customer_movement_period_id,
    cast(null as date   ) as period_start,
    cast(null as varchar) as product_name,
    cast(null as varchar) as channel,
    cast(null as varchar) as segment,
    cast(null as varchar) as product_tier,
    cast(null as double ) as upsold_customers,
    cast(null as double ) as starting_customers,
    cast(null as double ) as new_customers,
    cast(null as double ) as churned_customers,
    cast(null as double ) as beginning_customers,
    cast(null as double ) as lost_customers
where false
