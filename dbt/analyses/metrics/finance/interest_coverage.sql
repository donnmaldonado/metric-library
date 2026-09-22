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

opex as (
    select
        date_trunc('month', posted_date) as period,
        sum(opex_amount) as opex
    from {{ ref('fct_gl_entries') }}
    group by 1
),

interest as (
    select
        date_trunc('month', fiscal_period_start) as period,
        sum(interest_expense) as interest_expense
    from {{ ref('fct_income_statement') }}
    group by 1
),

periods as (
    select period from revenue
    union
    select period from cogs
    union
    select period from opex
    union
    select period from interest
)

select
    period,
    (revenue - cogs - opex) / nullif(interest_expense, 0) as interest_coverage
from periods
left join revenue using (period)
left join cogs using (period)
left join opex using (period)
left join interest using (period)
order by period
