-- One row per social account (or brand listening topic) and day.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as social_account_day_id,
    cast(null as date   ) as metric_date,
    cast(null as varchar) as platform,
    cast(null as varchar) as account_name,
    cast(null as varchar) as keyword_group,
    cast(null as double ) as followers,
    cast(null as double ) as brand_mentions,
    cast(null as double ) as total_category_mentions,
    cast(null as double ) as total_engagements
where false
