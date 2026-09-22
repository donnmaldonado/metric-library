with

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
    select period from revenue
    union
    select period from cogs
)

select
    period,
    (revenue - cogs) / nullif(revenue, 0) as gross_margin_pct
from periods
left join revenue using (period)
left join cogs using (period)
order by period
