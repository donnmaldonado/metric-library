select
    date_trunc('month', recognized_date) as period,
    region,
    product_line,
    channel,
    sum(recognized_revenue) as total_revenue
from {{ ref('fct_revenue') }}
group by all
order by all
