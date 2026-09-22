with tickets as (
    select
        date_trunc('month', created_date) as period,
        count(ticket_id) as tickets
    from {{ ref('fct_support_tickets') }}
    group by 1
),

snapshots as (
    select
        *,
        max(snapshot_date) over (partition by date_trunc('month', snapshot_date)) as last_snapshot_date
    from {{ ref('fct_subscriptions') }}
),

customers as (
    select
        date_trunc('month', snapshot_date) as period,
        count(distinct customer_id) as active_customers
    from snapshots
    where snapshot_date = last_snapshot_date
      and status = 'active'
    group by 1
)

select
    tickets.period,
    tickets.tickets / nullif(customers.active_customers, 0) as tickets_per_customer
from tickets
left join customers using (period)
