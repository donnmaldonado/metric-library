select
    date_trunc('month', sql_date) as period,
    channel,
    count(lead_id) as sql_count
from {{ ref('fct_leads') }}
where sql_date is not null
group by 1, 2
