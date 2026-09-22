-- % promoters (9-10) minus % detractors (0-6), on a -100..100 scale.
select
    date_trunc('month', response_date) as period,
    segment,
    product_name,
    (count(case when score >= 9 then response_id end) - count(case when score <= 6 then response_id end))
        * 100.0 / nullif(count(response_id), 0) as nps
from {{ ref('fct_customer_survey_responses') }}
where survey_type = 'nps'
group by 1, 2, 3
