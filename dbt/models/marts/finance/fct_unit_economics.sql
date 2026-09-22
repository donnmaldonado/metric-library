-- One row per channel, segment and period with acquisition spend, LTV and payback inputs.
-- Stub: returns zero rows with the typed columns the metric library needs.
-- Additive columns only feed measures: total_acquisition_spend, new_customers, new_customer_mrr,
-- churned_customers, churned_customer_lifetime_years. The avg_*/per-customer columns are pre-computed
-- averages and are not used by any measure.
select
    cast(null as varchar) as unit_economics_period_id,
    cast(null as date   ) as period_start,
    cast(null as varchar) as segment,
    cast(null as varchar) as cohort,
    cast(null as varchar) as channel,
    cast(null as double ) as avg_order_value,
    cast(null as double ) as avg_lifespan_years,
    cast(null as double ) as total_acquisition_spend,
    cast(null as double ) as new_customers,
    cast(null as double ) as new_customer_mrr,
    cast(null as double ) as churned_customers,
    cast(null as double ) as churned_customer_lifetime_years,
    cast(null as double ) as monthly_revenue_per_customer,
    cast(null as double ) as avg_ltv,
    cast(null as double ) as avg_cac,
    cast(null as double ) as monthly_gross_profit_per_customer
where false
