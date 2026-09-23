select
    date_trunc('month', snapshot_date) as period,
    location,
    count(distinct case when is_stocked_out then item_id end)
        / nullif(count(distinct item_id), 0) as stockout_rate
from {{ ref('fct_inventory_snapshots') }}
group by 1, 2
order by 1, 2
