select
    date_trunc('month', request_date) as period,
    count(distinct consumer_id) as api_consumers
from {{ ref('fct_api_requests') }}
group by 1
