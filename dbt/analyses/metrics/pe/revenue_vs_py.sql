with

revenue as (
    select
        date_trunc('month', recognized_date) as period,
        sum(recognized_revenue) as revenue
    from {{ ref('fct_revenue') }}
    group by 1
),

prior_year as (
    select
        cast(period + interval 1 year as date) as period,
        revenue as prior_year_revenue
    from revenue
),

periods as (
    select period from revenue
    union
    select period from prior_year
)

select
    period,
    (revenue - prior_year_revenue)
        / nullif(prior_year_revenue, 0) as revenue_vs_py
from periods
left join revenue using (period)
left join prior_year using (period)
order by period
