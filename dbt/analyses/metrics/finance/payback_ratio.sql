with

acquisition as (
    select
        date_trunc('month', period_start) as period,
        sum(total_acquisition_spend) as acquisition_spend,
        sum(new_customers) as new_customers,
        sum(new_customer_mrr) as new_customer_mrr
    from {{ ref('fct_unit_economics') }}
    group by 1
),

revenue as (
    select
        date_trunc('month', recognized_date) as period,
        sum(recognized_revenue) as revenue
    from {{ ref('fct_revenue') }}
    group by 1
),

cogs as (
    select
        date_trunc('month', posted_date) as period,
        sum(cogs_amount) as cogs
    from {{ ref('fct_gl_entries') }}
    group by 1
),

periods as (
    select period from acquisition
    union
    select period from revenue
    union
    select period from cogs
)

select
    period,
    (acquisition_spend / nullif(new_customers, 0))
        / nullif(
            new_customer_mrr / nullif(new_customers, 0)
            * (revenue - cogs) / nullif(revenue, 0),
            0
        ) as payback_ratio
from periods
left join acquisition using (period)
left join revenue using (period)
left join cogs using (period)
order by period
