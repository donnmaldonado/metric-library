-- One row per product analytics event.
-- Stub: returns zero rows with the typed columns the metric library needs.
-- (user_activity/user_activity_summary moved to fct_user_activity_months, funnel_events/funnel_analysis to fct_funnel_step_users)
select
    cast(null as varchar) as event_id,
    cast(null as date   ) as event_date,
    cast(null as varchar) as user_id,
    cast(null as varchar) as session_id,
    cast(null as varchar) as platform,
    cast(null as varchar) as product_area,
    cast(null as varchar) as user_segment,
    cast(null as varchar) as event_type,
    cast(null as varchar) as event_name,
    cast(null as varchar) as feature_name,
    cast(null as varchar) as plan_tier,
    cast(null as boolean) as is_active_event
where false
