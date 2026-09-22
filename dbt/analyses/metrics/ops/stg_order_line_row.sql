select
    date_trunc('month', order_date) as period,
    count(line_id) as stg_order_line_row
from {{ ref('fct_order_lines') }}
group by 1
order by 1
