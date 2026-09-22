-- One row per hire (external new hire or internal move into a new role).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as hire_id,
    cast(null as date   ) as hire_date,
    cast(null as varchar) as employee_id,
    cast(null as varchar) as department,
    cast(null as varchar) as job_level,
    cast(null as varchar) as hire_type,
    cast(null as boolean) as is_underrepresented
where false
