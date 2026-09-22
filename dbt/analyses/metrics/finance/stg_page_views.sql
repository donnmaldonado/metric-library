select
    date_trunc('month', view_date) as period,
    page_name,
    count(page_view_id) as stg_page_views
from {{ ref('fct_page_views') }}
group by 1, 2
