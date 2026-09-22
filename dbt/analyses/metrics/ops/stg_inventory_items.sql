select
    date_trunc('month', snapshot_date) as period,
    count(distinct item_id) as stg_inventory_items
from {{ ref('fct_inventory_snapshots') }}
group by 1
order by 1
