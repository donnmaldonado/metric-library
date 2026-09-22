select
    date_trunc('month', signup_date) as period,
    plan_tier,
    acquisition_channel,
    count(case when has_completed_onboarding then user_id end) / nullif(count(user_id), 0) as onboarding_completion_rate
from {{ ref('dim_users') }}
where has_started_onboarding
group by 1, 2, 3
