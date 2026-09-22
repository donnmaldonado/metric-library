select
    date_trunc('month', signup_date) as period,
    count(case when is_product_led then user_id end) / nullif(count(user_id), 0) as plg_rate
from {{ ref('dim_users') }}
group by 1
