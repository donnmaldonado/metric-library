-- One row per employee survey response (engagement composite, eNPS 0-10, upward feedback).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as employee_survey_response_id,
    cast(null as date   ) as response_date,
    cast(null as varchar) as manager_id,
    cast(null as varchar) as employee_id,
    cast(null as varchar) as survey_id,
    cast(null as varchar) as question_id,
    cast(null as varchar) as department,
    cast(null as varchar) as survey_cycle,
    cast(null as varchar) as job_level,
    cast(null as varchar) as location,
    cast(null as double ) as manager_score,
    cast(null as double ) as composite_score,
    cast(null as double ) as score,
    cast(null as double ) as enps_score
where false
