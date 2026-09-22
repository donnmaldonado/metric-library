with

revenue as (
    select
        date_trunc('month', recognized_date) as period,
        sum(recognized_revenue) as revenue
    from {{ ref('fct_revenue') }}
    group by 1
),

revenue_ttm as (
    select
        period,
        sum(revenue) over (order by period range between interval 11 month preceding and current row) as revenue_ttm
    from revenue
),

balances as (
    select
        date_trunc('month', as_of_date) as period,
        sum(accounts_receivable_balance) as accounts_receivable
    from (
        select *
        from {{ ref('fct_balance_sheet') }}
        qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
    ) as latest
    group by 1
),

periods as (
    select period from revenue_ttm
    union
    select period from balances
)

select
    period,
    accounts_receivable / nullif(revenue_ttm, 0) * 365 as dso
from periods
left join revenue_ttm using (period)
left join balances using (period)
order by period
