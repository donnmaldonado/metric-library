select
    date_trunc('month', period_start) as period,
    team,
    count(distinct case when is_at_quota then rep_id end)
        / nullif(count(distinct rep_id), 0) as pct_reps_at_quota
from {{ ref('fct_sales_rep_periods') }}
where is_quota_carrying
group by 1, 2
