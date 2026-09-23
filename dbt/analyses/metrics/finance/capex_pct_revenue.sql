with

capex as (
    select
        date_trunc('month', posted_date) as period,
        sum(capex_amount) as capex
    from {{ ref('fct_fixed_asset_entries') }}
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
    select period from capex
    union
    select period from revenue
)

select
    period,
    capex / nullif(revenue, 0) as capex_pct_revenue
from periods
left join capex using (period)
left join revenue using (period)
order by period
