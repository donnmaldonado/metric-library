select
    date_trunc('month', posted_date) as period,
    department,
    sum(opex_amount) as opex
from {{ ref('fct_gl_entries') }}
group by all
order by all
