with

hr_cost as (
    select
        date_trunc('month', fiscal_period_start) as period,
        sum(hr_total_cost) as hr_total_cost
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
    select period from hr_cost
    union
    select period from revenue
)

select
    period,
    hr_total_cost / nullif(revenue, 0) as hr_cost_pct_revenue
from periods
left join hr_cost using (period)
left join revenue using (period)
order by period
