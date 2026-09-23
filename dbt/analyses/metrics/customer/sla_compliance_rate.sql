select
    date_trunc('month', event_date) as period,
    service_type,
    count(case when is_sla_met then sla_event_id end)
        / nullif(count(sla_event_id), 0) as sla_compliance_rate
from {{ ref('fct_sla_events') }}
group by 1, 2
