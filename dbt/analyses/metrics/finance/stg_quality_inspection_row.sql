select
    date_trunc('month', inspection_date) as period,
    result,
    count(inspection_id) as stg_quality_inspection_row
from {{ ref('fct_quality_inspections') }}
group by 1, 2
order by 1, 2
