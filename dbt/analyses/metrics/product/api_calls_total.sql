select
    date_trunc('month', request_date) as period,
    endpoint,
    count(request_id) as api_calls_total
from {{ ref('fct_api_requests') }}
group by 1, 2
