select
    date_trunc('month', mention_date) as period,
    outlet,
    count(media_mention_id) as pr_mentions
from {{ ref('fct_media_mentions') }}
group by 1, 2
