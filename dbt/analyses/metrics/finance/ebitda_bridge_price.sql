select
    date_trunc('month', fiscal_period_start) as period,
    company_id,
    product_line,
    -- evaluated per product line, then summed
    sum((avg_price - prior_avg_price) * prior_volume) as ebitda_bridge_price
from {{ ref('fct_ebitda_bridge') }}
group by all
order by all
