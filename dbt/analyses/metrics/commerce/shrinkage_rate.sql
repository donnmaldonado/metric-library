with shrinkage as (
    select date_trunc('month', snapshot_date) as period, sum(inventory_shrinkage) as inventory_shrinkage
    from {{ ref('fct_inventory_snapshots') }}
    group by 1
),
inventory as (
    select
        date_trunc('month', snapshot_date) as period,
        sum(units_on_hand * unit_cost) as inventory_value
    from (
        select
            *,
            max(snapshot_date) over (partition by date_trunc('month', snapshot_date)) as month_end_date
        from {{ ref('fct_inventory_snapshots') }}
    )
    where snapshot_date = month_end_date
    group by 1
),
inventory_with_opening as (
    -- beginning inventory = prior month's closing inventory (offset_window: 1 month)
    select
        i.period,
        i.inventory_value,
        p.inventory_value as beginning_inventory_value
    from inventory as i
    left join inventory as p
        on p.period = i.period - interval 1 month
)
select
    i.period,
    s.inventory_shrinkage / nullif(i.beginning_inventory_value, 0) as shrinkage_rate
from inventory_with_opening as i
left join shrinkage as s on s.period = i.period
order by 1
