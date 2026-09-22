-- Alias of uptime (compare against the contractual SLA target, e.g. 0.999, downstream).
select
    date_trunc('month', period_start) as period,
    service,
    environment,
    sum(available_minutes) / nullif(sum(scheduled_minutes), 0) as product_uptime_sla
from {{ ref('fct_service_availability') }}
group by 1, 2, 3
