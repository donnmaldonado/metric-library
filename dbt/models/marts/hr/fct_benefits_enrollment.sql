-- One row per employee per benefits snapshot date (eligibility and active use).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as benefits_enrollment_id,
    cast(null as date   ) as as_of_date,
    cast(null as varchar) as employee_id,
    cast(null as varchar) as plan_year,
    cast(null as boolean) as is_eligible,
    cast(null as boolean) as is_active_user
where false
