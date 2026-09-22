select
    date_trunc('month', posted_date) as period,
    cost_center,
    product_id,
    sum(cogs_amount) as stg_cogs_event
from {{ ref('fct_gl_entries') }}
group by all
order by all
