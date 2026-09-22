-- Average days from posting to accepted offer for filled requisitions, by month of acceptance.
select
    date_trunc('month', offer_accepted_date) as period,
    department,
    avg(datediff('day', opened_date, offer_accepted_date)) as time_to_fill
from {{ ref('fct_requisitions') }}
where status = 'filled'
group by 1, 2
order by 1, 2
