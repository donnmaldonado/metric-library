with month_end as (
    select *
    from {{ ref('fct_customer_concentration') }}
    qualify period_start = max(period_start) over (partition by date_trunc('month', period_start))
)

select
    date_trunc('month', period_start) as period,
    company_id,
    sum(top10_arr) / nullif(sum(total_arr), 0) as customer_concentration_risk
from month_end
group by all
order by all
