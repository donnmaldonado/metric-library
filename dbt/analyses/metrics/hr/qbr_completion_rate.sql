select
    date_trunc('month', scheduled_date) as period,
    csm,
    count(case when is_completed then qbr_id end)
        / nullif(count(qbr_id), 0) as qbr_completion_rate
from {{ ref('fct_qbrs') }}
group by 1, 2
