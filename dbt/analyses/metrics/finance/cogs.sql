select
    date_trunc('month', posted_date) as period,
    company_id,
    product_line,
    sum(cogs_amount) as cogs
from {{ ref('fct_gl_entries') }}
group by all
order by all
