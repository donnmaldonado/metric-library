select
    date_trunc('month', published_date) as period,
    content_type,
    topic,
    channel,
    count(content_asset_id) as content_published_count
from {{ ref('fct_content_assets') }}
where status = 'published'
group by 1, 2, 3, 4
