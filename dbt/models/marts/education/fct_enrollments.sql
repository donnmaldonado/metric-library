-- One row per student enrollment per snapshot date (monthly snapshots, including the official census date). Snapshot model: measures take the latest snapshot in the period.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as enrollment_id,
    cast(null as date   ) as snapshot_date,
    cast(null as date   ) as enrollment_date,
    cast(null as date   ) as exit_date,
    cast(null as varchar) as school_id,
    cast(null as varchar) as student_id,
    cast(null as varchar) as grade_level,
    cast(null as varchar) as demographic_group,
    cast(null as varchar) as subgroup,
    cast(null as varchar) as school_year,
    cast(null as varchar) as school_name,
    cast(null as varchar) as status,
    cast(null as boolean) as is_ell,
    cast(null as boolean) as is_frl_eligible,
    cast(null as boolean) as has_iep,
    cast(null as boolean) as in_extracurricular,
    cast(null as boolean) as is_on_credit_pace
where false
