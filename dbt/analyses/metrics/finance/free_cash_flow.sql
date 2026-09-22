with

ocf as (
    select
        date_trunc('month', period_start) as period,
        sum(operating_cash_flow) as operating_cash_flow
    from {{ ref('fct_cash_flow') }}
    group by 1
),

capex as (
    select
        date_trunc('month', posted_date) as period,
        sum(capex_amount) as capex
    from {{ ref('fct_fixed_asset_entries') }}
    group by 1
),

periods as (
    select period from ocf
    union
    select period from capex
)

select
    period,
    operating_cash_flow - capex as free_cash_flow
from periods
left join ocf using (period)
left join capex using (period)
order by period
