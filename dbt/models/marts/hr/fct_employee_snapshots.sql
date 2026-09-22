-- One row per employee per snapshot date (status, employment type, department, location, FTE, manager). Snapshot model: point-in-time measures take the latest snapshot in the period; the *_day measures are additive employee-days used for period averages.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as employee_snapshot_id,
    cast(null as date   ) as snapshot_date,
    cast(null as varchar) as employee_id,
    cast(null as varchar) as company_id,
    cast(null as varchar) as manager_id,
    cast(null as date   ) as hire_date,
    cast(null as varchar) as department,
    cast(null as varchar) as location,
    cast(null as varchar) as job_level,
    cast(null as varchar) as status,
    cast(null as varchar) as employment_type,
    cast(null as varchar) as work_arrangement,
    cast(null as boolean) as carries_quota,
    cast(null as double ) as fte_fraction
where false
