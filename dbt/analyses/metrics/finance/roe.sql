with

net_income as (
    select
        date_trunc('month', fiscal_period_start) as period,
        sum(net_income) as net_income
    from {{ ref('fct_income_statement') }}
    group by 1
),

balances as (
    select
        date_trunc('month', as_of_date) as period,
        sum(total_assets) - sum(total_liabilities) as shareholder_equity
    from (
        select *
        from {{ ref('fct_balance_sheet') }}
        qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
    ) as latest
    group by 1
),

periods as (
    select period from net_income
    union
    select period from balances
)

select
    period,
    net_income / nullif(shareholder_equity, 0) as roe
from periods
left join net_income using (period)
left join balances using (period)
order by period
