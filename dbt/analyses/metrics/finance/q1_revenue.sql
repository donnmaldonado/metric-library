select
    date_trunc('month', recognized_date) as period,
    fiscal_year,
    sum(recognized_revenue) as q1_revenue
from {{ ref('fct_revenue') }}
where fiscal_quarter = 1
group by all
order by all
