-- Users active last month who were inactive this month / users active last month.
select
    date_trunc('month', activity_month) as period,
    count(case when was_active_prior_month and not is_active then user_month_id end)
        / nullif(count(case when was_active_prior_month then user_month_id end), 0) as product_churn_rate
from {{ ref('fct_user_activity_months') }}
group by 1
