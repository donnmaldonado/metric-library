-- Monthly count; year-to-date is a running sum over these rows (see the window column).
select
    date_trunc('month', review_date) as period,
    count(review_id) as testimonials_count,
    sum(count(review_id)) over (
        partition by date_trunc('year', date_trunc('month', review_date))
        order by date_trunc('month', review_date)
    ) as testimonials_count_ytd
from {{ ref('fct_reviews') }}
where review_source = 'testimonial'
group by 1
