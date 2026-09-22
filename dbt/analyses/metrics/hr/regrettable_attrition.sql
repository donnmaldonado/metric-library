-- Share of separations classified as regrettable, per month.
select
    date_trunc('month', separation_date) as period,
    department,
    count(employee_id) filter (where is_regrettable)
        / nullif(count(employee_id), 0) as regrettable_attrition
from {{ ref('fct_separations') }}
group by 1, 2
order by 1, 2
