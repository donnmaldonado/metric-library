select
    date_trunc('month', recognized_date) as period,
    partner,
    sum(recognized_revenue) as partner_revenue
from {{ ref('fct_revenue') }}
where source_type = 'partner'
group by all
order by all
