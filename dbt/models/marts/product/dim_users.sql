-- One row per product user (signup, trial, activation, onboarding and retention milestones).
-- Stub: returns zero rows with the typed columns the metric library needs.
-- The double columns from activated_users to cohort_size are unused pre-aggregates;
-- the library metrics use the boolean milestone flags and timestamps at the end.
select
    cast(null as varchar) as user_id,
    cast(null as date   ) as signup_date,
    cast(null as varchar) as acquisition_channel,
    cast(null as varchar) as plan_tier,
    cast(null as varchar) as geography,
    cast(null as varchar) as cohort,
    cast(null as varchar) as channel,
    cast(null as varchar) as signup_type,
    cast(null as date   ) as activation_date,
    cast(null as double ) as days_to_value_event,
    cast(null as double ) as activated_users,
    cast(null as double ) as total_signups,
    cast(null as double ) as paid_conversions,
    cast(null as double ) as free_users,
    cast(null as double ) as self_serve_signups,
    cast(null as double ) as total_new_signups,
    cast(null as double ) as trial_starts,
    cast(null as double ) as completed_onboarding,
    cast(null as double ) as started_onboarding,
    cast(null as double ) as day_30_retained_users,
    cast(null as double ) as cohort_starting_size,
    cast(null as double ) as day_7_retained_users,
    cast(null as double ) as active_on_d30,
    cast(null as double ) as cohort_size,
    cast(null as timestamp) as signed_up_at,
    cast(null as timestamp) as activated_at,
    cast(null as boolean) as is_activated,
    cast(null as boolean) as is_converted_to_paid,
    cast(null as boolean) as is_product_led,
    cast(null as boolean) as has_started_onboarding,
    cast(null as boolean) as has_completed_onboarding,
    cast(null as boolean) as is_retained_d7,
    cast(null as boolean) as is_retained_d30
where false
