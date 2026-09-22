-- One row per school, grade and period with seat capacity (snapshot: latest period wins).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as school_period_id,
    cast(null as date   ) as period_start,
    cast(null as varchar) as school_id,
    cast(null as varchar) as school_year,
    cast(null as varchar) as school_name,
    cast(null as varchar) as grade_level,
    cast(null as double ) as total_seats
where false
