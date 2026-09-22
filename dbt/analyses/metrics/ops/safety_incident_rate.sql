-- OSHA recordable incident rate: recordable incidents x 200,000 / employee-hours worked.
select
    date_trunc('month', incident_date) as period,
    facility_id,
    count(case when is_recordable then incident_id end) * 200000
        / nullif(sum(total_hours_worked), 0) as safety_incident_rate
from {{ ref('fct_safety_incidents') }}
group by 1, 2
order by 1, 2
