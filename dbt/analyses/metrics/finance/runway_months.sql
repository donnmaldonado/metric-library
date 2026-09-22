with

balances as (
    select
        date_trunc('month', as_of_date) as period,
        sum(cash_balance) as cash_and_equivalents
    from (
        select *
        from {{ ref('fct_balance_sheet') }}
        qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
    ) as latest
    group by 1
),

burn as (
    select
        date_trunc('month', period_start) as period,
        sum(beginning_cash - ending_cash) as burn_rate
    from {{ ref('fct_cash_flow') }}
    group by 1
),

periods as (
    select period from balances
    union
    select period from burn
)

select
    period,
    cash_and_equivalents / nullif(burn_rate, 0) as runway_months
from periods
left join balances using (period)
left join burn using (period)
order by period
