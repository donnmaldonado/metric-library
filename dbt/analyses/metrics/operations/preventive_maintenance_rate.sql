select
    date_trunc('month', created_date) as period,
    facility_id,
    count(case when maintenance_type = 'preventive' then 1 end)
        / nullif(count(*), 0) as preventive_maintenance_rate
from {{ ref('fct_work_orders') }}
group by 1, 2
order by 1, 2
