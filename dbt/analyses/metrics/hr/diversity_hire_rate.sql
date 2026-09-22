-- Share of hires from underrepresented groups, per month.
select
    date_trunc('month', hire_date) as period,
    department,
    count(hire_id) filter (where is_underrepresented)
        / nullif(count(hire_id), 0) as diversity_hire_rate
from {{ ref('fct_hires') }}
group by 1, 2
order by 1, 2
