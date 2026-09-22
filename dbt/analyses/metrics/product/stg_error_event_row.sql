select
    date_trunc('month', error_date) as period,
    endpoint,
    error_type,
    count(error_id) as stg_error_event_row
from {{ ref('fct_app_errors') }}
group by 1, 2, 3
