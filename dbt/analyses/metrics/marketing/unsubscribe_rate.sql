select
    date_trunc('month', send_date) as period,
    campaign_id,
    segment,
    count(case when is_delivered and is_unsubscribed then send_id end)
        / nullif(count(case when is_delivered then send_id end), 0) as unsubscribe_rate
from {{ ref('fct_email_sends') }}
group by 1, 2, 3
