with

arr as (
    select
        date_trunc('month', snapshot_date) as period,
        sum(monthly_amount * 12) as arr
    from (
        select *
        from {{ ref('fct_subscriptions') }}
        where status = 'active'
        qualify snapshot_date = max(snapshot_date) over (partition by date_trunc('month', snapshot_date))
    ) as latest
    group by 1
),

market as (
    select
        date_trunc('month', as_of_date) as period,
        sum(tam_estimate) as tam
    from (
        select *
        from {{ ref('fct_market_sizing') }}
        qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
    ) as latest
    group by 1
),

periods as (
    select period from arr
    union
    select period from market
)

select
    period,
    arr / nullif(tam, 0) as market_penetration_rate
from periods
left join arr using (period)
left join market using (period)
order by period
