select
    date_trunc('month', incident_date) as period,
    incident_type,
    count(incident_id) as stg_safety_incident_row
from {{ ref('fct_safety_incidents') }}
group by 1, 2
order by 1, 2
