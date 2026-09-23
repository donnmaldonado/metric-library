select
    date_trunc('month', created_date) as period,
    priority,
    count(case when is_sla_breached then ticket_id end)
        / nullif(count(ticket_id), 0) as sla_breach_rate
from {{ ref('fct_support_tickets') }}
group by 1, 2
