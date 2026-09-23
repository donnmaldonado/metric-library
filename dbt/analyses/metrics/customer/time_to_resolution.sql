select
    date_trunc('month', resolved_date) as period,
    priority,
    avg(datediff('minute', created_at, resolved_at) / 60.0) as time_to_resolution
from {{ ref('fct_support_tickets') }}
where resolved_at is not null
group by 1, 2
