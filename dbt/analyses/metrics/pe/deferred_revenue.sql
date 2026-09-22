with month_end as (
    select *
    from {{ ref('fct_deferred_revenue') }}
    qualify as_of_date = max(as_of_date) over (partition by date_trunc('month', as_of_date))
)

select
    date_trunc('month', as_of_date) as period,
    company_id,
    product_tier,
    sum(deferred_amount) as deferred_revenue
from month_end
group by all
order by all
