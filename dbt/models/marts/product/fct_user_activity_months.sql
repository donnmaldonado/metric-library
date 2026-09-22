-- One row per user and calendar month in which the user was active in the month or the month before.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as user_month_id,
    cast(null as date   ) as activity_month,
    cast(null as varchar) as user_id,
    cast(null as varchar) as platform,
    cast(null as varchar) as plan_tier,
    cast(null as boolean) as was_active_prior_month,
    cast(null as boolean) as is_active
where false
