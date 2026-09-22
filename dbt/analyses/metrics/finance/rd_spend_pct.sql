with

rd as (
    select
        date_trunc('month', posted_date) as period,
        sum(opex_amount) as rd_expense
    from {{ ref('fct_gl_entries') }}
    where gl_category = 'R&D'
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
    select period from rd
    union
    select period from revenue
)

select
    period,
    rd_expense / nullif(revenue, 0) as rd_spend_pct
from periods
left join rd using (period)
left join revenue using (period)
order by period
