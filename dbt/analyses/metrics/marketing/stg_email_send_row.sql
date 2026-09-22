select
    date_trunc('month', send_date) as period,
    campaign_id,
    status,
    count(send_id) as stg_email_send_row
from {{ ref('fct_email_sends') }}
group by 1, 2, 3
