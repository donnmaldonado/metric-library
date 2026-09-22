-- One row per staff member per roster snapshot date (role, FTE, experience, returned next year). Snapshot model: measures take the latest snapshot in the period.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as staff_id,
    cast(null as date   ) as as_of_date,
    cast(null as varchar) as school_id,
    cast(null as varchar) as school_year,
    cast(null as varchar) as school_name,
    cast(null as varchar) as role,
    cast(null as varchar) as status,
    cast(null as double ) as fte,
    cast(null as varchar) as subject_area,
    cast(null as varchar) as experience_band,
    cast(null as double ) as years_of_experience,
    cast(null as boolean) as returned_next_year
where false
