select
    date_trunc('month', opened_date) as period,
    count(case when is_resolved_within_sla then case_id end)
        / nullif(count(case_id), 0) as complaint_resolution_rate
from {{ ref('fct_complaints') }}
where case_type = 'complaint'
group by 1
