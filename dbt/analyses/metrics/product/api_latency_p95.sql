select
    date_trunc('month', request_date) as period,
    endpoint,
    environment,
    quantile_cont(response_time_ms, 0.95) as api_latency_p95
from {{ ref('fct_api_requests') }}
group by 1, 2, 3
