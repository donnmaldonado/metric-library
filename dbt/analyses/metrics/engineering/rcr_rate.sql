select
    date_trunc('month', incident_date) as period,
    count(case when has_root_cause then incident_id end) / nullif(count(incident_id), 0) as rcr_rate
from {{ ref('fct_incidents') }}
group by 1
