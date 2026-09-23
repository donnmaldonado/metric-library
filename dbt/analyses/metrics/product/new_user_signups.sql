select
    date_trunc('month', signup_date) as period,
    acquisition_channel,
    plan_tier,
    geography,
    count(user_id) as new_user_signups
from {{ ref('dim_users') }}
group by 1, 2, 3, 4
