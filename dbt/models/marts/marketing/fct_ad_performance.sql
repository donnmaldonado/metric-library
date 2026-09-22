-- One row per ad, channel and day with spend, impressions, clicks and attributed results.
-- Stub: returns zero rows with the typed columns the metric library needs.
-- attributed_revenue, leads_generated and new_customers_acquired are attributed to the ad-day by the attribution model.
select
    cast(null as varchar) as ad_day_id,
    cast(null as date   ) as ad_date,
    cast(null as varchar) as campaign_id,
    cast(null as varchar) as ad_set_id,
    cast(null as varchar) as channel,
    cast(null as varchar) as campaign_name,
    cast(null as varchar) as ad_set_name,
    cast(null as varchar) as ad,
    cast(null as double ) as spend,
    cast(null as double ) as impressions,
    cast(null as double ) as clicks,
    cast(null as double ) as attributed_revenue,
    cast(null as double ) as new_customers_acquired,
    cast(null as double ) as leads_generated
where false
