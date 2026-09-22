select
    date_trunc('month', recognized_date) as period,
    sum(case when source_type = 'partner' then recognized_revenue end)
        / nullif(sum(recognized_revenue), 0) as partner_revenue_pct
from {{ ref('fct_revenue') }}
group by all
order by all
