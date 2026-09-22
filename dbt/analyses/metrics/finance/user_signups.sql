-- Alias of new_user_signups.
select
    date_trunc('month', signup_date) as period,
    channel,
    count(user_id) as user_signups
from {{ ref('dim_users') }}
group by 1, 2
