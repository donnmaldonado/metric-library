-- Average hours from incident start to restoration.
select
    date_trunc('month', incident_date) as period,
    service,
    avg(datediff('minute', incident_start, resolved_at) / 60.0) as mttr
from {{ ref('fct_incidents') }}
where resolved_at is not null
group by 1, 2
