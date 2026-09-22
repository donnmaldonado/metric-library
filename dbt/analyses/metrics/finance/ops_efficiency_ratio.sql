with

revenue as (
    select
        date_trunc('month', recognized_date) as period,
        sum(recognized_revenue) as revenue
    from {{ ref('fct_revenue') }}
    group by 1
),

opex as (
    select
        date_trunc('month', posted_date) as period,
        sum(opex_amount) as opex
    from {{ ref('fct_gl_entries') }}
    group by 1
),

periods as (
    select period from revenue
    union
    select period from opex
)

select
    period,
    revenue / nullif(opex, 0) as ops_efficiency_ratio
from periods
left join revenue using (period)
left join opex using (period)
order by period
