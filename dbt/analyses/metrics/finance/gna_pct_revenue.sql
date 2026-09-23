with

ga as (
    select
        date_trunc('month', posted_date) as period,
        sum(opex_amount) as ga_expense
    from {{ ref('fct_gl_entries') }}
    where gl_category = 'G&A'
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
    select period from ga
    union
    select period from revenue
)

select
    period,
    ga_expense / nullif(revenue, 0) as gna_pct_revenue
from periods
left join ga using (period)
left join revenue using (period)
order by period
