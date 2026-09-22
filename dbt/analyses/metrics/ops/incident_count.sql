select
    date_trunc('month', incident_date) as period,
    service,
    severity,
    count(incident_id) as incident_count
from {{ ref('fct_incidents') }}
group by 1, 2, 3
