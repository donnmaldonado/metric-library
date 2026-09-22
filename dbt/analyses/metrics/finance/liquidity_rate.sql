select
    date_trunc('month', listing_date) as period,
    category,
    count(distinct case when has_transaction then listing_id end)
        / nullif(count(distinct listing_id), 0) as liquidity_rate
from {{ ref('fct_marketplace_listings') }}
where is_active
group by 1, 2
order by 1, 2
