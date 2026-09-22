select
    date_trunc('month', fiscal_period_start) as period,
    company_id,
    product_line,
    -- evaluated per product line, then summed
    sum((current_volume - prior_volume) * prior_avg_price) as ebitda_bridge_volume
from {{ ref('fct_ebitda_bridge') }}
group by all
order by all
