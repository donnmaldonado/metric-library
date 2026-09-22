-- One row per sales rep (or team) and period with quota, closed ARR, pipeline and cost.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as sales_rep_period_id,
    cast(null as date   ) as period_start,
    cast(null as varchar) as company_id,
    cast(null as varchar) as rep_id,
    cast(null as varchar) as team,
    cast(null as varchar) as segment,
    cast(null as double ) as total_sales_cost,
    cast(null as double ) as qualified_pipeline,
    cast(null as double ) as remaining_quota,
    cast(null as double ) as arr_closed,
    cast(null as double ) as quota,
    cast(null as double ) as reps_at_quota,
    cast(null as double ) as total_reps,
    cast(null as double ) as total_arr,
    cast(null as double ) as quota_carrying_reps,
    cast(null as boolean) as is_quota_carrying,
    cast(null as boolean) as is_at_quota
where false
