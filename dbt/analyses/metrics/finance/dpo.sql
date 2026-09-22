with

cogs as (
    select
        date_trunc('month', posted_date) as period,
        sum(cogs_amount) as cogs
    from {{ ref('fct_gl_entries') }}
    group by 1
),

cogs_ttm as (
    select
        period,
        sum(cogs) over (order by period range between interval 11 month preceding and current row) as cogs_ttm
    from cogs
),

balances as (
    select
        date_trunc('month', as_of_date) as period,
        sum(accounts_payable_balance) as accounts_payable
    from (
        select *
        from {{ ref('fct_balance_sheet') }}
        qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
    ) as latest
    group by 1
),

periods as (
    select period from cogs_ttm
    union
    select period from balances
)

select
    period,
    accounts_payable / nullif(cogs_ttm, 0) * 365 as dpo
from periods
left join cogs_ttm using (period)
left join balances using (period)
order by period
