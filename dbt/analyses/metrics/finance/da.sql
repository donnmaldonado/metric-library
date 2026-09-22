select
    date_trunc('month', posted_date) as period,
    company_id,
    sum(depreciation_amount + amortization_amount) as da
from {{ ref('fct_fixed_asset_entries') }}
group by all
order by all
