with

revenue as (
    select
        date_trunc('month', recognized_date) as period,
        sum(recognized_revenue) as revenue
    from {{ ref('fct_revenue') }}
    group by 1
)

-- revenue shifted forward one year: each period shows the revenue of the same period a year earlier
select
    cast(period + interval 1 year as date) as period,
    revenue as prior_year_revenue
from revenue
order by period
