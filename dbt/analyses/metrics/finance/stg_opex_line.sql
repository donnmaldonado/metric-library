select
    date_trunc('month', posted_date) as period,
    gl_account,
    department,
    sum(opex_amount) as stg_opex_line
from {{ ref('fct_gl_entries') }}
group by all
order by all
