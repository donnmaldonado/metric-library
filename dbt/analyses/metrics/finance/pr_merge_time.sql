select
    date_trunc('month', opened_date) as period,
    team,
    avg(datediff('minute', opened_at, merged_at) / 60.0) as pr_merge_time
from {{ ref('fct_pull_requests') }}
where merged_at is not null
group by 1, 2
