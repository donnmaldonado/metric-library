with

net_income as (
    select
        date_trunc('month', fiscal_period_start) as period,
        sum(net_income) as net_income
    from {{ ref('fct_income_statement') }}
    group by 1
),

revenue as (
    select
        date_trunc('month', recognized_date) as period,
        sum(recognized_revenue) as revenue
    from {{ ref('fct_revenue') }}
    group by 1
),

periods as (
    select period from net_income
    union
    select period from revenue
)

select
    period,
    net_income / nullif(revenue, 0) as net_income_margin
from periods
left join net_income using (period)
left join revenue using (period)
order by period
