select
    date_trunc('month', close_date) as period,
    segment,
    avg(datediff('day', first_touch_date, close_date)) as sales_cycle_length
from {{ ref('fct_opportunities') }}
where is_won
group by 1, 2
