with month_end as (
    select *
    from {{ ref('fct_market_sizing') }}
    qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
)

select
    date_trunc('month', as_of_date) as period,
    region,
    segment,
    sum(tam_estimate) as tam
from month_end
group by all
order by all
