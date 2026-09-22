-- One row per email send (delivery, open, click and unsubscribe flags).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as send_id,
    cast(null as date   ) as send_date,
    cast(null as varchar) as contact_id,
    cast(null as varchar) as campaign_id,
    cast(null as varchar) as status,
    cast(null as varchar) as segment,
    cast(null as varchar) as campaign_name,
    cast(null as boolean) as is_delivered,
    cast(null as boolean) as is_opened,
    cast(null as boolean) as is_clicked,
    cast(null as boolean) as is_unsubscribed
where false
