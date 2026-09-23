select
    date_trunc('month', review_date) as period,
    platform,
    avg(rating_score) as review_rating
from {{ ref('fct_reviews') }}
where review_source = 'review_site'
group by 1, 2
