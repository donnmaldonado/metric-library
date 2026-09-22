-- One row per acquisition cohort and period offset (cohort size, retained customers, cohort revenue).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as customer_cohort_period_id,
    cast(null as date   ) as cohort_start_date,
    cast(null as varchar) as cohort,
    cast(null as varchar) as channel,
    cast(null as varchar) as cohort_month,
    cast(null as varchar) as month_number,
    cast(null as varchar) as segment,
    cast(null as double ) as cohort_revenue_12m,
    cast(null as double ) as cohort_starting_size,
    cast(null as double ) as cohort_revenue_24m,
    cast(null as double ) as cohort_revenue,
    cast(null as double ) as initial_cohort_revenue,
    cast(null as double ) as churned_users_in_cohort,
    cast(null as double ) as months_since_acquisition,
    cast(null as double ) as cumulative_cohort_revenue
where false
