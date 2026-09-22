with

bad_debt as (
    select
        date_trunc('month', fiscal_period_start) as period,
        sum(bad_debt_writeoffs) as bad_debt_writeoffs
    from {{ ref('fct_income_statement') }}
    group by 1
),

revenue as (
    select
        date_trunc('month', recognized_date) as period,
        sum(recognized_revenue) as revenue
    from {{ ref('fct_revenue') }}
    group by 1
),

periods as (
    select period from bad_debt
    union
    select period from revenue
)

select
    period,
    bad_debt_writeoffs / nullif(revenue, 0) as bad_debt_rate
from periods
left join bad_debt using (period)
left join revenue using (period)
order by period
