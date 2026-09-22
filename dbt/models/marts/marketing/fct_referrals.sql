-- One row per referral invite.
-- Stub: returns zero rows with the typed columns the metric library needs.
-- invites_sent and referral_conversion_rate are unused pre-aggregated columns;
-- the library metrics use referrer_user_id and is_converted.
select
    cast(null as varchar) as referral_id,
    cast(null as date   ) as referral_date,
    cast(null as varchar) as referrer_user_id,
    cast(null as boolean) as is_converted,
    cast(null as double ) as invites_sent,
    cast(null as double ) as referral_conversion_rate
where false
