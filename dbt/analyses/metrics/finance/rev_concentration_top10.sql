select
    date_trunc('month', period_start) as period,
    company_id,
    sum(top10_customer_revenue)
        / nullif(sum(total_customer_revenue), 0) as rev_concentration_top10
from {{ ref('fct_customer_concentration') }}
group by all
order by all
