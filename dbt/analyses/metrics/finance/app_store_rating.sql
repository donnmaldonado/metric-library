select
    date_trunc('month', review_date) as period,
    platform,
    avg(rating_score) as app_store_rating
from {{ ref('fct_reviews') }}
where review_source = 'app_store'
group by 1, 2
