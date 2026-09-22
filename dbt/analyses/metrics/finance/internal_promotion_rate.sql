-- Share of hires filled by internal candidates, per month.
select
    date_trunc('month', hire_date) as period,
    department,
    count(hire_id) filter (where hire_type = 'internal')
        / nullif(count(hire_id), 0) as internal_promotion_rate
from {{ ref('fct_hires') }}
group by 1, 2
order by 1, 2
