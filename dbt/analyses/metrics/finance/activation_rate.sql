-- Signup cohorts by month.
select
    date_trunc('month', signup_date) as period,
    acquisition_channel,
    plan_tier,
    count(case when is_activated then user_id end) / nullif(count(user_id), 0) as activation_rate
from {{ ref('dim_users') }}
group by 1, 2, 3
