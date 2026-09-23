select
    date_trunc('month', resolved_date) as period,
    priority,
    count(ticket_id) as tickets_resolved
from {{ ref('fct_support_tickets') }}
where resolved_at is not null
group by 1, 2
