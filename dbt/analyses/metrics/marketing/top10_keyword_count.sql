-- Snapshot: keywords ranking in the top 10 on the last ranking date of each month.
with latest as (
    select
        *,
        max(ranking_date) over (partition by date_trunc('month', ranking_date)) as last_date
    from {{ ref('fct_seo_keyword_rankings') }}
)
select
    date_trunc('month', ranking_date) as period,
    keyword_group,
    count(distinct keyword_id) as top10_keyword_count
from latest
where ranking_date = last_date
    and ranking_position <= 10
group by 1, 2
