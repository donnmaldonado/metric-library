select
    date_trunc('month', recognized_date) as period,
    product_line,
    channel,
    geography,
    sum(recognized_revenue) / nullif(sum(units_sold), 0) as asp
from {{ ref('fct_revenue') }}
group by all
order by all
