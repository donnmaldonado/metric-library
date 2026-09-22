select
    date_trunc('month', go_live_date) as period,
    segment,
    avg(datediff('day', contract_date, go_live_date)) as onboarding_time
from {{ ref('dim_customers') }}
where go_live_date is not null
group by 1, 2
