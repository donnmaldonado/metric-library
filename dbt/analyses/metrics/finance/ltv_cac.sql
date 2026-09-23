with

orders as (
    select
        date_trunc('month', order_date) as period,
        sum(order_amount) as order_amount,
        count(order_id) as order_count,
        count(distinct customer_id) as customer_count
    from {{ ref('fct_orders') }}
    where status = 'completed'
    group by 1
),

lifespan as (
    select
        date_trunc('month', period_start) as period,
        sum(churned_customer_lifetime_years) as lifetime_years,
        sum(churned_customers) as churned_customers
    from {{ ref('fct_unit_economics') }}
    group by 1
),

acquisition as (
    select
        date_trunc('month', period_start) as period,
        sum(total_acquisition_spend) as acquisition_spend,
        sum(new_customers) as new_customers,
        sum(new_customer_mrr) as new_customer_mrr
    from {{ ref('fct_unit_economics') }}
    group by 1
),

periods as (
    select period from orders
    union
    select period from lifespan
    union
    select period from acquisition
)

select
    period,
    (
        order_amount / nullif(order_count, 0)                  -- aov
            * order_count / nullif(customer_count, 0)          -- purchase frequency
            * lifetime_years / nullif(churned_customers, 0)    -- avg lifespan (years)
    )
        / nullif(acquisition_spend / nullif(new_customers, 0), 0) as ltv_cac
from periods
left join orders using (period)
left join lifespan using (period)
left join acquisition using (period)
order by period
