select
    date_trunc('month', request_date) as period,
    endpoint,
    platform,
    count(case when is_error then request_id end) / nullif(count(request_id), 0) as error_rate
from {{ ref('fct_api_requests') }}
group by 1, 2, 3
