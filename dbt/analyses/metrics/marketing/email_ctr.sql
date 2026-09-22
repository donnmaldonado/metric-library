-- Alias of email_click_rate (unique clicks / delivered).
select
    date_trunc('month', send_date) as period,
    campaign_name,
    count(case when is_delivered and is_clicked then send_id end)
        / nullif(count(case when is_delivered then send_id end), 0) as email_ctr
from {{ ref('fct_email_sends') }}
group by 1, 2
