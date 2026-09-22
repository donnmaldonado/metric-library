-- One row per employee with current attributes (type 1). Gives every HR fact with an employee_id a shared employee__department / employee__location / employee__job_level, so cross-model HR ratios can be broken down by current department.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as employee_id,
    cast(null as date   ) as hire_date,
    cast(null as varchar) as department,
    cast(null as varchar) as location,
    cast(null as varchar) as job_level,
    cast(null as varchar) as status,
    cast(null as varchar) as employment_type
where false
