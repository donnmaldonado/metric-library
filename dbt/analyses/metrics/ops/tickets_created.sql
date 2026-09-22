select
    date_trunc('month', created_date) as period,
    category,
    priority,
    count(ticket_id) as tickets_created
from {{ ref('fct_support_tickets') }}
group by 1, 2, 3
