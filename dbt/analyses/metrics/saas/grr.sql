with snapshots as (
    select
        *,
        max(snapshot_date) over (partition by date_trunc('month', snapshot_date)) as last_snapshot_date
    from {{ ref('fct_subscriptions') }}
),

ending_arr as (
    -- ARR on the last snapshot of each month
    select
        date_trunc('month', snapshot_date) as period,
        sum(monthly_amount * 12) as ending_arr
    from snapshots
    where snapshot_date = last_snapshot_date
      and status = 'active'
    group by 1
),

movements as (
    select
        date_trunc('month', movement_date) as period,
        sum(arr_delta) as net_new_arr,
        sum(case when movement_type = 'new_business' then arr_delta else 0 end) as new_arr,
        sum(case when movement_type = 'expansion' then arr_delta else 0 end) as expansion_arr,
        sum(case when movement_type = 'contraction' then -arr_delta else 0 end) as contraction_arr,
        sum(case when movement_type = 'churn' then -arr_delta else 0 end) as churned_arr
    from {{ ref('fct_arr_movements') }}
    group by 1
),

waterfall as (
    -- starting ARR = ending ARR - net movements in the month
    select
        e.period,
        e.ending_arr - coalesce(m.net_new_arr, 0) as starting_arr,
        coalesce(m.expansion_arr, 0) as expansion_arr,
        coalesce(m.contraction_arr, 0) as contraction_arr,
        coalesce(m.churned_arr, 0) as churned_arr
    from ending_arr as e
    left join movements as m using (period)
)

select
    period,
    (starting_arr - churned_arr - contraction_arr) / nullif(starting_arr, 0) as grr
from waterfall
order by period
