select
    date_trunc('month', inspection_date) as period,
    production_line,
    sum(defective_units) / nullif(sum(units_inspected), 0) as defect_rate
from {{ ref('fct_quality_inspections') }}
group by 1, 2
order by 1, 2
