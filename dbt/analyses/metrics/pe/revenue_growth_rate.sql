with

revenue as (
    select
        date_trunc('month', recognized_date) as period,
        sum(recognized_revenue) as revenue
    from {{ ref('fct_revenue') }}
    group by 1
),

prior_period as (
    select
        cast(period + interval 1 month as date) as period,
        revenue as revenue_prior_period
    from revenue
),

periods as (
    select period from revenue
    union
    select period from prior_period
)

select
    period,
    (revenue - revenue_prior_period)
        / nullif(revenue_prior_period, 0) as revenue_growth_rate
from periods
left join revenue using (period)
left join prior_period using (period)
order by period
