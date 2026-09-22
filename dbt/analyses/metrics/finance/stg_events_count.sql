select
    date_trunc('month', event_date) as period,
    event_type,
    count(event_id) as stg_events_count
from {{ ref('fct_user_events') }}
group by 1, 2
