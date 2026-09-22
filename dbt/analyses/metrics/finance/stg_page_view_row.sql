-- Alias of stg_page_views.
select
    date_trunc('month', view_date) as period,
    device,
    referrer,
    count(page_view_id) as stg_page_view_row
from {{ ref('fct_page_views') }}
group by 1, 2, 3
