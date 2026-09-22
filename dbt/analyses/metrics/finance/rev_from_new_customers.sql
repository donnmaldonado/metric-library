select
    date_trunc('month', recognized_date) as period,
    sum(recognized_revenue) as rev_from_new_customers
from {{ ref('fct_revenue') }}
where customer_age_days <= 90
group by all
order by all
