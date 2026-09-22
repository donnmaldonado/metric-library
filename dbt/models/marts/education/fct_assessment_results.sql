-- One row per student assessment result (state tests, AP exams, kindergarten screening, ELL proficiency).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as assessment_result_id,
    cast(null as date   ) as assessment_date,
    cast(null as varchar) as student_id,
    cast(null as varchar) as assessment_id,
    cast(null as varchar) as school_id,
    cast(null as varchar) as assessment_type,
    cast(null as varchar) as subject,
    cast(null as varchar) as grade_level,
    cast(null as varchar) as school_year,
    cast(null as varchar) as school_name,
    cast(null as varchar) as subgroup,
    cast(null as varchar) as academic_year,
    cast(null as varchar) as home_language,
    cast(null as double ) as score,
    cast(null as double ) as proficiency_level,
    cast(null as boolean) as met_standard,
    cast(null as double ) as proficiency_level_gain,
    cast(null as double ) as growth_percentile
where false
