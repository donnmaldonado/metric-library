-- One row per web session (source, medium, landing page, conversion flags).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as session_id,
    cast(null as date   ) as session_date,
    cast(null as varchar) as user_id,
    cast(null as varchar) as platform,
    cast(null as varchar) as product_area,
    cast(null as varchar) as user_segment,
    cast(null as varchar) as channel,
    cast(null as varchar) as campaign_name,
    cast(null as varchar) as medium,
    cast(null as varchar) as source,
    cast(null as varchar) as referrer_domain,
    cast(null as varchar) as landing_page,
    cast(null as varchar) as keyword,
    cast(null as varchar) as device,
    cast(null as double ) as duration_seconds,
    cast(null as double ) as page_view_count,
    cast(null as boolean) as is_bounce,
    cast(null as boolean) as is_converted,
    cast(null as boolean) as created_lead
where false
