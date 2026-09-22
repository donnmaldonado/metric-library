select
    date_trunc('month', mention_date) as period,
    outlet,
    sum(estimated_media_value) as earned_media_value
from {{ ref('fct_media_mentions') }}
group by 1, 2
