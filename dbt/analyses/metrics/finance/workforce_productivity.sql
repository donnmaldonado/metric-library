-- Recognized revenue (total_revenue) per labor hour worked, per month.
with revenue as (
    select
        date_trunc('month', recognized_date) as period,
        sum(recognized_revenue) as total_revenue
    from {{ ref('fct_revenue') }}
    group by 1
),

hours as (
    select
        date_trunc('month', work_date) as period,
        sum(labor_hours_worked) as labor_hours_worked
    from {{ ref('fct_time_records') }}
    group by 1
)

select
    h.period,
    r.total_revenue / nullif(h.labor_hours_worked, 0) as workforce_productivity
from hours as h
left join revenue as r
    on r.period = h.period
order by 1
