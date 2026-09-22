-- One row per workplace safety incident, plus one hours-worked row per facility and period.
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- Incident rows have incident_id set and total_hours_worked null; hours rows
-- have incident_id null and total_hours_worked set (incident_date = period start).
-- is_recordable: the incident is OSHA recordable.
select
    cast(null as varchar) as safety_incident_id,
    cast(null as date   ) as incident_date,
    cast(null as varchar) as incident_id,
    cast(null as varchar) as employee_id,
    cast(null as varchar) as facility_id,
    cast(null as varchar) as incident_type,
    cast(null as varchar) as severity,
    cast(null as varchar) as department,
    cast(null as boolean) as is_recordable,
    cast(null as double ) as total_hours_worked
where false
