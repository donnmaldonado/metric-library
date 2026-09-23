select
    date_trunc('month', recognized_date) as period,
    product_name,
    sum(recognized_revenue) as license_revenue
from {{ ref('fct_revenue') }}
where revenue_type = 'license'
group by all
order by all
