select
    date_trunc('month', recognized_date) as period,
    fiscal_year,
    sum(recognized_revenue) as q3_revenue
from {{ ref('fct_revenue') }}
where fiscal_quarter = 3
group by all
order by all
