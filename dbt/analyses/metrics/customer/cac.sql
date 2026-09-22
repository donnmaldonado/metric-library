select
    date_trunc('month', period_start) as period,
    channel,
    sum(total_acquisition_spend) / nullif(sum(new_customers), 0) as cac
from {{ ref('fct_unit_economics') }}
group by all
order by all
