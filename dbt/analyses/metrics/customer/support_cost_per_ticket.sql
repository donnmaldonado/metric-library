with cost as (
    select
        date_trunc('month', created_date) as period,
        sum(support_team_cost) as support_team_cost
    from {{ ref('fct_support_tickets') }}
    group by 1
),

resolved as (
    select
        date_trunc('month', resolved_date) as period,
        count(ticket_id) as tickets_resolved
    from {{ ref('fct_support_tickets') }}
    where resolved_at is not null
    group by 1
)

select
    cost.period,
    cost.support_team_cost / nullif(resolved.tickets_resolved, 0) as support_cost_per_ticket
from cost
left join resolved using (period)
