-- External hires starting in each month.
select
    date_trunc('month', hire_date) as period,
    department,
    count(hire_id) as new_hires
from {{ ref('fct_hires') }}
where hire_type = 'external'
group by 1, 2
order by 1, 2
