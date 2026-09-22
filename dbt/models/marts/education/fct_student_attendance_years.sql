-- One row per student per school year: year-to-date enrolled and absent days and chronic-absence flag (absent >= 10% of enrolled days).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as student_attendance_year_id,
    cast(null as date   ) as school_year_start,
    cast(null as varchar) as student_id,
    cast(null as varchar) as school_id,
    cast(null as varchar) as school_year,
    cast(null as varchar) as grade_level,
    cast(null as varchar) as subgroup,
    cast(null as double ) as days_enrolled,
    cast(null as double ) as days_absent,
    cast(null as boolean) as is_chronically_absent
where false
