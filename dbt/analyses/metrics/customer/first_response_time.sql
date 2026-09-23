select
    date_trunc('month', created_date) as period,
    priority,
    avg(first_response_hours) as first_response_time
from {{ ref('fct_support_tickets') }}
group by 1, 2
