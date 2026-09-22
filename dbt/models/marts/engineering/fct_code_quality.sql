-- One row per service and date with coverage, bug and tech-debt measurements.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as code_quality_snapshot_id,
    cast(null as date   ) as as_of_date,
    cast(null as varchar) as service,
    cast(null as varchar) as severity,
    cast(null as double ) as tech_debt_hours,
    cast(null as double ) as total_dev_hours,
    cast(null as double ) as production_bugs,
    cast(null as double ) as total_bugs_found,
    cast(null as double ) as covered_lines,
    cast(null as double ) as total_lines
where false
