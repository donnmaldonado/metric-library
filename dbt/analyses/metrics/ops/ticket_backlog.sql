select
    date_trunc('month', created_date) as period,
    priority,
    count(ticket_id) as ticket_backlog
from {{ ref('fct_support_tickets') }}
where status = 'open'
  and is_sla_breached
group by 1, 2
