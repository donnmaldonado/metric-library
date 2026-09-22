select
    date_trunc('month', posted_date) as period,
    company_id,
    department,
    sum(opex_amount) as rd_expense
from {{ ref('fct_gl_entries') }}
where gl_category = 'R&D'
group by all
order by all
