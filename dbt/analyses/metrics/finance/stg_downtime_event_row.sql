select
    date_trunc('month', start_time) as period,
    system_id,
    facility_id,
    cause,
    count(event_id) as stg_downtime_event_row
from {{ ref('fct_service_availability') }}
where event_id is not null
group by 1, 2, 3, 4
