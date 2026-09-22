-- Accepted offers / offers extended, by application month.
select
    date_trunc('month', applied_date) as period,
    department,
    count(candidate_id) filter (where offer_extended and offer_accepted)
        / nullif(count(candidate_id) filter (where offer_extended), 0) as offer_acceptance_rate
from {{ ref('fct_candidates') }}
group by 1, 2
order by 1, 2
