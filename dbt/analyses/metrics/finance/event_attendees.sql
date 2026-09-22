select
    date_trunc('month', event_date) as period,
    event,
    count(case when attended then event_registration_id end) as event_attendees
from {{ ref('fct_event_attendance') }}
group by 1, 2
