-- Alias of cogs (general-ledger COGS postings).

select
    date_trunc('month', posted_date) as period,
    sum(cogs_amount) as cogs_stg
from {{ ref('fct_gl_entries') }}
group by 1
order by 1
