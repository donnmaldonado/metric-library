select
    date_trunc('month', created_date) as period,
    segment,
    sum(opportunity_value) as pipeline_generated
from {{ ref('fct_opportunities') }}
where source = 'marketing'
group by 1, 2
