-- Alias of uptime, by system and facility.
select
    date_trunc('month', period_start) as period,
    system_id,
    facility_id,
    sum(available_minutes) / nullif(sum(scheduled_minutes), 0) as system_uptime
from {{ ref('fct_service_availability') }}
group by 1, 2, 3
