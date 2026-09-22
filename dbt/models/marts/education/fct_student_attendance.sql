-- One row per student per enrolled school day (attendance status, scheduled instructional minutes).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as record_id,
    cast(null as date   ) as attendance_date,
    cast(null as varchar) as student_id,
    cast(null as varchar) as school_id,
    cast(null as varchar) as school_year,
    cast(null as varchar) as school_name,
    cast(null as varchar) as grade_level,
    cast(null as varchar) as subgroup,
    cast(null as varchar) as academic_year,
    cast(null as varchar) as status,
    cast(null as boolean) as is_excused,
    cast(null as double ) as instructional_minutes
where false
