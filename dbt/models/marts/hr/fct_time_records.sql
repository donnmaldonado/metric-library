-- One row per employee and work day (hours worked, overtime, absences).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as time_record_id,
    cast(null as date   ) as work_date,
    cast(null as varchar) as employee_id,
    cast(null as varchar) as department,
    cast(null as double ) as labor_hours_worked,
    cast(null as double ) as overtime_hours,
    cast(null as double ) as unplanned_absence_days,
    cast(null as double ) as available_working_days
where false
