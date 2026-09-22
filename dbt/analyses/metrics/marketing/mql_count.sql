select
    date_trunc('month', mql_date) as period,
    channel,
    count(lead_id) as mql_count
from {{ ref('fct_leads') }}
where mql_date is not null
group by 1, 2
