-- Alias of stg_events_count.
select
    date_trunc('month', event_date) as period,
    event_name,
    platform,
    count(event_id) as stg_user_event_row
from {{ ref('fct_user_events') }}
group by 1, 2, 3
