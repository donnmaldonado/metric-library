-- Stickiness: average DAU in the month / MAU in the month.
with daily as (
    select event_date, count(distinct user_id) as dau
    from {{ ref('fct_user_events') }}
    where is_active_event
    group by 1
),
monthly as (
    select date_trunc('month', event_date) as period, count(distinct user_id) as mau
    from {{ ref('fct_user_events') }}
    where is_active_event
    group by 1
)
select
    monthly.period,
    avg(daily.dau) / nullif(max(monthly.mau), 0) as dau_mau_ratio
from monthly
join daily on date_trunc('month', daily.event_date) = monthly.period
group by 1
