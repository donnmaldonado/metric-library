select
    date_trunc('month', recognized_date) as period,
    client_name,
    sum(recognized_revenue) as services_revenue
from {{ ref('fct_revenue') }}
where revenue_type = 'professional_services'
group by all
order by all
