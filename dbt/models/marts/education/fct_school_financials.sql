-- One row per school per fiscal year (expenditure, budget, reported ADM).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as school_financial_period_id,
    cast(null as date   ) as fiscal_year_start,
    cast(null as varchar) as school_id,
    cast(null as varchar) as fiscal_year,
    cast(null as varchar) as school_year,
    cast(null as double ) as total_personnel_cost,
    cast(null as double ) as total_operating_budget,
    cast(null as double ) as instructional_expenditure,
    cast(null as double ) as total_expenditure,
    cast(null as double ) as avg_daily_membership
where false
