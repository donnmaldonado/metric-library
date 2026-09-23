-- Average hours from incident start to detection.
select
    date_trunc('month', incident_date) as period,
    severity,
    avg(datediff('minute', incident_start, detection_time) / 60.0) as mttd
from {{ ref('fct_incidents') }}
where detection_time is not null
group by 1, 2
