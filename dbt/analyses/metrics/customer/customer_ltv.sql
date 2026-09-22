-- Realized LTV: all-time net revenue from completed orders / all-time customers, as of each month.
with completed as (
    select * from {{ ref('fct_orders') }} where status = 'completed'
),
monthly_revenue as (
    select date_trunc('month', order_date) as period, sum(revenue) as revenue
    from completed
    group by 1
),
new_customers as (
    select first_period as period, count(*) as new_customers
    from (
        select customer_id, date_trunc('month', min(order_date)) as first_period
        from completed
        group by 1
    )
    group by 1
),
periods as (
    select period from monthly_revenue
    union
    select period from new_customers
)
select
    p.period,
    sum(coalesce(r.revenue, 0)) over (order by p.period)
        / nullif(sum(coalesce(n.new_customers, 0)) over (order by p.period), 0) as customer_ltv
from periods as p
left join monthly_revenue as r on r.period = p.period
left join new_customers as n on n.period = p.period
order by 1
