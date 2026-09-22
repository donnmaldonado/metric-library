select
    date_trunc('month', submitted_date) as period,
    feature_area,
    segment,
    channel,
    count(feedback_id) as feature_request_volume
from {{ ref('fct_feature_feedback') }}
group by 1, 2, 3, 4
