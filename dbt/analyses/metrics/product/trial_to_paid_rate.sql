-- Trial signups (by signup month) that converted to a paid plan.
select
    date_trunc('month', signup_date) as period,
    count(case when is_converted_to_paid then user_id end) / nullif(count(user_id), 0) as trial_to_paid_rate
from {{ ref('dim_users') }}
where signup_type = 'trial'
group by 1
