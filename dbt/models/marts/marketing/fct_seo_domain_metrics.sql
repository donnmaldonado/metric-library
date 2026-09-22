-- One row per domain and date with authority and backlink data (snapshot).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as seo_domain_snapshot_id,
    cast(null as date   ) as as_of_date,
    cast(null as varchar) as domain,
    cast(null as varchar) as link_type,
    cast(null as double ) as domain_authority_score,
    cast(null as double ) as referring_domain_count,
    cast(null as double ) as backlink_count
where false
