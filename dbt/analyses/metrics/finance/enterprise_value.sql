with

valuation as (
    select
        date_trunc('month', as_of_date) as period,
        sum(market_cap) as market_cap
    from (
        select *
        from {{ ref('fct_valuations') }}
        qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
    ) as latest
    group by 1
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
    select period from valuation
    union
    select period from balances
)

select
    period,
    market_cap + total_debt - cash_and_equivalents as enterprise_value
from periods
left join valuation using (period)
left join balances using (period)
order by period
