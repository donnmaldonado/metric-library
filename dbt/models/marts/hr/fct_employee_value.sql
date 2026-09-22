-- One row per employee per estimate date with modelled lifetime revenue contribution and employment cost (snapshot: take the latest estimate in the period).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as employee_value_id,
    cast(null as date   ) as as_of_date,
    cast(null as varchar) as employee_id,
    cast(null as varchar) as job_level,
    cast(null as varchar) as department,
    cast(null as varchar) as hire_cohort,
    cast(null as double ) as lifetime_revenue_contribution,
    cast(null as double ) as lifetime_employment_cost
where false
