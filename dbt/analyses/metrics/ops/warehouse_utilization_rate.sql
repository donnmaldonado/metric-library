with snapshots as (
    select
        *,
        max(snapshot_date) over (partition by date_trunc('month', snapshot_date)) as month_end_date
    from {{ ref('fct_warehouse_capacity') }}
)
select
    date_trunc('month', snapshot_date) as period,
    warehouse_id,
    sum(occupied_locations) / nullif(sum(total_locations), 0) as warehouse_utilization_rate
from snapshots
where snapshot_date = month_end_date
group by 1, 2
order by 1, 2
