select
    date_trunc('month', created_date) as period,
    channel,
    sum(arr_value) as marketing_influenced_pipeline
from {{ ref('fct_opportunities') }}
where marketing_touched
group by 1, 2
