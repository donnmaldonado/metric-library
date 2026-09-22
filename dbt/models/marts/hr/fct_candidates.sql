-- One row per candidate application (stage reached, offer, acceptance).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as candidate_id,
    cast(null as date   ) as applied_date,
    cast(null as varchar) as req_id,
    cast(null as varchar) as department,
    cast(null as varchar) as status,
    cast(null as boolean) as reached_final_round,
    cast(null as boolean) as offer_extended,
    cast(null as boolean) as offer_accepted,
    cast(null as date   ) as offer_accepted_date
where false
