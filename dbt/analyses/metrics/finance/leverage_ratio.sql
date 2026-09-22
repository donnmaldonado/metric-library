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

ebitda_monthly as (
    select
        period,
        coalesce(revenue, 0) - coalesce(cogs, 0) - coalesce(opex, 0) + coalesce(da, 0) as ebitda
    from (
        select period from revenue
        union
        select period from cogs
        union
        select period from opex
        union
        select period from da
    ) as periods
    left join revenue using (period)
    left join cogs using (period)
    left join opex using (period)
    left join da using (period)
),

ebitda_ttm as (
    select
        period,
        sum(ebitda) over (order by period range between interval 11 month preceding and current row) as ebitda_ttm
    from ebitda_monthly
),

balances as (
    select
        date_trunc('month', as_of_date) as period,
        sum(short_term_debt + long_term_debt) as total_debt,
        sum(cash_balance) as cash_and_equivalents
    from (
        select *
        from {{ ref('fct_balance_sheet') }}
        qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
    ) as latest
    group by 1
),

periods as (
    select period from ebitda_ttm
    union
    select period from balances
)

select
    period,
    (total_debt - cash_and_equivalents) / nullif(ebitda_ttm, 0) as leverage_ratio
from periods
left join ebitda_ttm using (period)
left join balances using (period)
order by period
