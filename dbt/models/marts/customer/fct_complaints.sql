-- One row per customer complaint case.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as case_id,
    cast(null as date   ) as opened_date,
    cast(null as varchar) as case_type,
    cast(null as double ) as resolved_within_sla,
    cast(null as double ) as total_complaints,
    cast(null as boolean) as is_resolved_within_sla
where false
