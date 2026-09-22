select
    date_trunc('month', created_date) as period,
    count(opportunity_id) as stg_opportunities_count
from {{ ref('fct_opportunities') }}
group by 1
