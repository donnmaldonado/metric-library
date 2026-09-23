select
    date_trunc('month', signup_date) as period,
    channel,
    count(user_id) as trial_signups
from {{ ref('dim_users') }}
where signup_type = 'trial'
group by 1, 2
