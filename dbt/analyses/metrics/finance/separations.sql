-- Employees who left (voluntarily or involuntarily) in each month.
select
    date_trunc('month', separation_date) as period,
    department,
    count(employee_id) as separations
from {{ ref('fct_separations') }}
group by 1, 2
order by 1, 2
