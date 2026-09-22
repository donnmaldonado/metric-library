select
    date_trunc('month', period_start) as period,
    service,
    sum(available_minutes) / nullif(sum(scheduled_minutes), 0) as uptime
from {{ ref('fct_service_availability') }}
group by 1, 2
