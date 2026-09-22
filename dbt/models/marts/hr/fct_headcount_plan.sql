-- One row per department and period with budgeted headcount (snapshot: latest plan period wins).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as headcount_plan_line_id,
    cast(null as date   ) as period_start,
    cast(null as varchar) as department,
    cast(null as double ) as budgeted_headcount
where false
