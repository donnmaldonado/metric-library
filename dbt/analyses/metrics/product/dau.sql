-- Daily grain: this is the one metric whose natural period is the day.
select
    event_date as period,
    platform,
    count(distinct user_id) as dau
from {{ ref('fct_user_events') }}
where is_active_event
group by 1, 2
