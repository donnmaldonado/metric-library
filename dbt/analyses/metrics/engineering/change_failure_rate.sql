select
    date_trunc('month', deployed_date) as period,
    service,
    count(case when is_failed then deployment_id end) / nullif(count(deployment_id), 0) as change_failure_rate
from {{ ref('fct_deployments') }}
where environment = 'production'
group by 1, 2
