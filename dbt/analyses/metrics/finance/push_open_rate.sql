select
    date_trunc('month', sent_date) as period,
    campaign_name,
    count(case when is_delivered and is_opened then push_notification_id end)
        / nullif(count(case when is_delivered then push_notification_id end), 0) as push_open_rate
from {{ ref('fct_push_notifications') }}
group by 1, 2
