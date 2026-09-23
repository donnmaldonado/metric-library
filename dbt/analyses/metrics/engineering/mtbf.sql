-- Operating (available) hours per unplanned failure.
select
    date_trunc('month', period_start) as period,
    system_id,
    facility_id,
    sum(available_minutes) / 60.0 / nullif(sum(failure_count), 0) as mtbf
from {{ ref('fct_service_availability') }}
group by 1, 2, 3
