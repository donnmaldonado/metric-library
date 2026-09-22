-- One row per budget line (department, cost center, period) with budgeted and actual amounts.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as budget_line_id,
    cast(null as date   ) as period_start,
    cast(null as varchar) as budget_year,
    cast(null as varchar) as department,
    cast(null as varchar) as cost_center,
    cast(null as double ) as budgeted_amount,
    cast(null as double ) as actual_spend,
    cast(null as double ) as budgeted_spend
where false
