-- Share of users reaching a step who did not reach the next one (1 - step N / step N-1).
select
    date_trunc('month', reached_date) as period,
    funnel_name,
    funnel_step,
    count(case when not reached_next_step then funnel_step_user_id end)
        / nullif(count(funnel_step_user_id), 0) as funnel_dropoff
from {{ ref('fct_funnel_step_users') }}
group by 1, 2, 3
