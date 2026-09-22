select
    date_trunc('month', recognized_date) as period,
    company_id,
    product_line,
    geography,
    channel,
    sum(recognized_revenue) as revenue
from {{ ref('fct_revenue') }}
group by all
order by all
