select
    date_trunc('month', opened_date) as period,
    count(case_id) as complaints_count
from {{ ref('fct_complaints') }}
where case_type = 'complaint'
group by 1
