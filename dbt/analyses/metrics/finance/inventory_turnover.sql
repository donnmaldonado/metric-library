with cogs as (
    select date_trunc('month', posted_date) as period, sum(cogs_amount) as cogs
    from {{ ref('fct_gl_entries') }}
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
    c.cogs / nullif((i.inventory_value + i.beginning_inventory_value) / 2, 0) as inventory_turnover
from inventory_with_opening as i
left join cogs as c on c.period = i.period
order by 1
