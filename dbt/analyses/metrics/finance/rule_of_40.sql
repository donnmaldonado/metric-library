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

da as (
    select
        date_trunc('month', posted_date) as period,
        sum(depreciation_amount + amortization_amount) as da
    from {{ ref('fct_fixed_asset_entries') }}
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
    select period from cogs
    union
    select period from opex
    union
    select period from da
    union
    select period from prior_year
)

select
    period,
    (
        (revenue - prior_year_revenue) / nullif(prior_year_revenue, 0)
        + (revenue - cogs - opex + da) / nullif(revenue, 0)
    ) * 100 as rule_of_40
from periods
left join revenue using (period)
left join cogs using (period)
left join opex using (period)
left join da using (period)
left join prior_year using (period)
order by period
