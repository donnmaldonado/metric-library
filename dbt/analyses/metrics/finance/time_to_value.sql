-- Average days from signup to the first value event, users who reached it, by signup month.
select
    date_trunc('month', signup_date) as period,
    plan_tier,
    acquisition_channel,
    avg(days_to_value_event) as time_to_value
from {{ ref('dim_users') }}
where days_to_value_event is not null
group by 1, 2, 3
