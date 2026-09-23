-- Median hours from commit to production deploy.
select
    date_trunc('month', deployed_date) as period,
    team,
    service,
    median(lead_time_hours) as lead_time_for_changes
from {{ ref('fct_deployments') }}
where environment = 'production'
group by 1, 2, 3
