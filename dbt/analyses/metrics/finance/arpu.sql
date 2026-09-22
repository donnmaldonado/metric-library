with revenue as (
    select date_trunc('month', recognized_date) as period, sum(recognized_revenue) as total_revenue
    from {{ ref('fct_revenue') }}
    group by 1
),
customers as (
    select date_trunc('month', order_date) as period, count(distinct customer_id) as ordering_customers
    from {{ ref('fct_orders') }}
    group by 1
)
select
    coalesce(r.period, c.period) as period,
    r.total_revenue / nullif(c.ordering_customers, 0) as arpu
from revenue as r
full outer join customers as c on c.period = r.period
order by 1
