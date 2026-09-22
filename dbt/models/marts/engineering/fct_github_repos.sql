-- One row per repository and date (stars, forks). Snapshot.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as repo_snapshot_id,
    cast(null as date   ) as as_of_date,
    cast(null as varchar) as repo,
    cast(null as boolean) as is_primary,
    cast(null as double ) as star_count
where false
