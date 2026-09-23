select
    date_trunc('month', recognized_date) as period,
    plan_tier,
    sum(recognized_revenue) as subscription_revenue
from {{ ref('fct_revenue') }}
where revenue_type = 'subscription'
group by all
order by all
