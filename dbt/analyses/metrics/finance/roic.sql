with

nopat as (
    select
        date_trunc('month', fiscal_period_start) as period,
        sum(nopat) as nopat
    from {{ ref('fct_income_statement') }}
    group by 1
),

capital as (
    select
        date_trunc('month', fiscal_period_start) as period,
        sum(invested_capital) as invested_capital
    from (
        select *
        from {{ ref('fct_income_statement') }}
        qualify fiscal_period_start = max(fiscal_period_start) over (partition by date_trunc('month', fiscal_period_start))
    ) as latest
    group by 1
),

periods as (
    select period from nopat
    union
    select period from capital
)

select
    period,
    nopat / nullif(invested_capital, 0) as roic
from periods
left join nopat using (period)
left join capital using (period)
order by period
