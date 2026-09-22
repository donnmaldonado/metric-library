-- Alias of content_published_count.
select
    date_trunc('month', published_date) as period,
    content_type,
    count(content_asset_id) as content_published
from {{ ref('fct_content_assets') }}
where status = 'published'
group by 1, 2
