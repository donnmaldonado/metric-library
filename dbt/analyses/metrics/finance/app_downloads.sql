select
    date_trunc('month', event_date) as period,
    platform,
    count(app_store_event_id) as app_downloads
from {{ ref('fct_app_store') }}
where event_type = 'download'
group by 1, 2
