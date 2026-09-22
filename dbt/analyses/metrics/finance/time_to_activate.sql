-- Median hours from signup to activation, by signup month.
select
    date_trunc('month', signup_date) as period,
    median(datediff('minute', signed_up_at, activated_at) / 60.0) as time_to_activate
from {{ ref('dim_users') }}
where activated_at is not null
group by 1
