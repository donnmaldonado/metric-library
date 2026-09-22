-- Alias of d30_retention.
select
    date_trunc('month', signup_date) as period,
    acquisition_channel,
    plan_tier,
    count(case when is_retained_d30 then user_id end) / nullif(count(user_id), 0) as retention_d30
from {{ ref('dim_users') }}
group by 1, 2, 3
