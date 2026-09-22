select
    date_trunc('month', event_date) as period,
    webinar,
    count(event_registration_id) as webinar_registrants
from {{ ref('fct_event_attendance') }}
where event_type = 'webinar'
group by 1, 2
