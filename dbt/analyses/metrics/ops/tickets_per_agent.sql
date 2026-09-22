-- Tickets resolved per agent per working day (agent-days with at least one resolution).
select
    date_trunc('month', resolved_date) as period,
    team,
    count(ticket_id) / nullif(count(distinct agent_id || '|' || cast(resolved_date as varchar)), 0) as tickets_per_agent
from {{ ref('fct_support_tickets') }}
where resolved_at is not null
group by 1, 2
