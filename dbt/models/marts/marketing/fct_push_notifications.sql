-- One row per push notification sent.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as push_notification_id,
    cast(null as date   ) as sent_date,
    cast(null as varchar) as campaign_name,
    cast(null as boolean) as is_delivered,
    cast(null as boolean) as is_opened
where false
