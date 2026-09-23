select
    date_trunc('month', event_date) as period,
    event,
    sum(event_cost) / nullif(count(case when attended then event_registration_id end), 0) as cost_per_event_attendee
from {{ ref('fct_event_attendance') }}
group by 1, 2
