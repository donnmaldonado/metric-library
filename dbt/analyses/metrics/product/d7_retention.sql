select
    date_trunc('month', signup_date) as period,
    count(case when is_retained_d7 then user_id end) / nullif(count(user_id), 0) as d7_retention
from {{ ref('dim_users') }}
group by 1
