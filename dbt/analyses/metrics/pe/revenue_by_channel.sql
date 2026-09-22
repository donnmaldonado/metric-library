select
    date_trunc('month', recognized_date) as period,
    channel,
    sum(recognized_revenue) as revenue_by_channel
from {{ ref('fct_revenue') }}
group by all
order by all
