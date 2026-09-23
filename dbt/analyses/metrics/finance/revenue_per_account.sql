select
    date_trunc('month', recognized_date) as period,
    segment,
    sum(recognized_revenue) / nullif(count(distinct customer_id), 0) as revenue_per_account
from {{ ref('fct_revenue') }}
group by all
order by all
