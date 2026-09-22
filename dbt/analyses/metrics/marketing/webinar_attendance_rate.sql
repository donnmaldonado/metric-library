select
    date_trunc('month', event_date) as period,
    webinar,
    count(case when attended then event_registration_id end)
        / nullif(count(event_registration_id), 0) as webinar_attendance_rate
from {{ ref('fct_event_attendance') }}
where event_type = 'webinar'
group by 1, 2
