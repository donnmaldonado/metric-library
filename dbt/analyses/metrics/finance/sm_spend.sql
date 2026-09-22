select
    date_trunc('month', posted_date) as period,
    department,
    sum(expense_amount) as sm_spend
from {{ ref('fct_gl_entries') }}
where department in ('sales', 'marketing')
group by all
order by all
