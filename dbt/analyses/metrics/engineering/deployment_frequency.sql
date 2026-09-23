-- Production deployments per month (query MetricFlow at metric_time__week for the weekly DORA view).
select
    date_trunc('month', deployed_date) as period,
    team,
    service,
    count(deployment_id) as deployment_frequency
from {{ ref('fct_deployments') }}
where environment = 'production'
group by 1, 2, 3
