with snapshots as (
    select
        *,
        max(snapshot_date) over (partition by date_trunc('month', snapshot_date)) as month_end_date
    from {{ ref('fct_inventory_snapshots') }}
)
select
    date_trunc('month', snapshot_date) as period,
    location,
    sum(units_on_hand * unit_cost) as inventory_value
from snapshots
where snapshot_date = month_end_date
group by 1, 2
order by 1, 2
