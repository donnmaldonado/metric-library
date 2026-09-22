select
    date_trunc('month', posted_date) as period,
    company_id,
    asset_category,
    sum(capex_amount) as capex
from {{ ref('fct_fixed_asset_entries') }}
group by all
order by all
