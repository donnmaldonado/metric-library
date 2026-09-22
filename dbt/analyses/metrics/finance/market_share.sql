with month_end as (
    select *
    from {{ ref('fct_market_sizing') }}
    qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
)

select
    date_trunc('month', as_of_date) as period,
    region,
    sum(company_revenue) / nullif(sum(tam_estimate), 0) as market_share
from month_end
group by all
order by all
