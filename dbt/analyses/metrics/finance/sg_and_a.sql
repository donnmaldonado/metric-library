select
    date_trunc('month', posted_date) as period,
    company_id,
    department,
    sum(opex_amount) as sg_and_a
from {{ ref('fct_gl_entries') }}
where gl_category in ('S&M', 'G&A')
group by all
order by all
