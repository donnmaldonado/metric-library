-- One row per pull request.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar  ) as pull_request_id,
    cast(null as date     ) as opened_date,
    cast(null as varchar  ) as team,
    cast(null as timestamp) as opened_at,
    cast(null as timestamp) as merged_at
where false
