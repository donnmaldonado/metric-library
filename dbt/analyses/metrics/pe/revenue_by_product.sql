select
    date_trunc('month', recognized_date) as period,
    product_line,
    sum(recognized_revenue) as revenue_by_product
from {{ ref('fct_revenue') }}
group by all
order by all
