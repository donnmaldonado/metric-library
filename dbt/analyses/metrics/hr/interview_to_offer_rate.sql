-- Offers extended / applications reaching the final round, by application month.
select
    date_trunc('month', applied_date) as period,
    department,
    count(candidate_id) filter (where offer_extended)
        / nullif(count(candidate_id) filter (where reached_final_round), 0) as interview_to_offer_rate
from {{ ref('fct_candidates') }}
group by 1, 2
order by 1, 2
