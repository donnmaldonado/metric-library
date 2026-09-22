select
    date_trunc('month', recognized_date) as period,
    region,
    sum(recognized_revenue) as revenue_by_region
from {{ ref('fct_revenue') }}
group by all
order by all
