-- One row per planned lesson (delivered on schedule or not).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as lesson_id,
    cast(null as date   ) as planned_date,
    cast(null as varchar) as teacher_id,
    cast(null as varchar) as school_id,
    cast(null as varchar) as subject,
    cast(null as boolean) as delivered_on_time
where false
