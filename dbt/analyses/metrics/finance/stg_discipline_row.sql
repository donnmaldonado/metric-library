-- Discipline incident records, per month and school.
select
    date_trunc('month', incident_date) as period,
    school_id,
    count(discipline_incident_id) as stg_discipline_row
from {{ ref('fct_discipline_incidents') }}
group by 1, 2
order by 1, 2
