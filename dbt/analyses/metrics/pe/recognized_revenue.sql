select
    date_trunc('month', recognized_date) as period,
    company_id,
    sum(recognized_revenue) as recognized_revenue
from {{ ref('fct_revenue') }}
group by all
order by all
