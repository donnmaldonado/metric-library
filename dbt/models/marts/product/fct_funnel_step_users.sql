-- One row per user, funnel and step the user reached, with whether the user went on to reach the next step.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as funnel_step_user_id,
    cast(null as date   ) as reached_date,
    cast(null as varchar) as user_id,
    cast(null as varchar) as funnel_name,
    cast(null as varchar) as funnel_step,
    cast(null as double ) as step_number,
    cast(null as boolean) as reached_next_step
where false
