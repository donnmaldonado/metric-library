-- Share of CSAT responses that were satisfied (top-two-box).
select
    date_trunc('month', response_date) as period,
    product_name,
    channel,
    count(case when is_satisfied then response_id end) / nullif(count(response_id), 0) as cx_csat
from {{ ref('fct_customer_survey_responses') }}
where survey_type = 'csat'
group by 1, 2, 3
