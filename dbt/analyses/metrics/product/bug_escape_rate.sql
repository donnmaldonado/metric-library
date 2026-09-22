select
    date_trunc('month', as_of_date) as period,
    severity,
    sum(production_bugs) / nullif(sum(total_bugs_found), 0) as bug_escape_rate
from {{ ref('fct_code_quality') }}
group by 1, 2
