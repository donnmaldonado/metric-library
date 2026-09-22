-- One row per public review, app store review or testimonial.
-- Stub: returns zero rows with the typed columns the metric library needs.
-- review_source: 'app_store' (iOS App Store / Google Play), 'review_site' (G2, Capterra, Trustpilot, ...), 'testimonial'.
select
    cast(null as varchar) as review_id,
    cast(null as date   ) as review_date,
    cast(null as varchar) as platform,
    cast(null as varchar) as review_source,
    cast(null as double ) as rating_score
where false
