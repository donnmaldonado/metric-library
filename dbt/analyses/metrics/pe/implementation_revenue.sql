select
    date_trunc('month', recognized_date) as period,
    sum(recognized_revenue) as implementation_revenue
from {{ ref('fct_revenue') }}
where revenue_type = 'implementation'
group by all
order by all
