with

revenue as (
    select
        date_trunc('month', recognized_date) as period,
        sum(recognized_revenue) as revenue
    from {{ ref('fct_revenue') }}
    group by 1
)

select
    period,
    sum(revenue) over (
        partition by date_trunc('year', period)
        order by period
    ) as revenue_ytd
from revenue
order by period
