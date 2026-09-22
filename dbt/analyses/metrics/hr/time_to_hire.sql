-- Average days from application to accepted offer, by month of acceptance.
select
    date_trunc('month', offer_accepted_date) as period,
    department,
    avg(datediff('day', applied_date, offer_accepted_date)) as time_to_hire
from {{ ref('fct_candidates') }}
where offer_accepted_date is not null
group by 1, 2
order by 1, 2
