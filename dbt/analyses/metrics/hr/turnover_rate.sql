-- Separations / average active headcount, per month.
with separations as (
    select
        date_trunc('month', separation_date) as period,
        count(employee_id) as separations
    from {{ ref('fct_separations') }}
    group by 1
),

avg_headcount as (
    -- average active headcount: active employee-days / snapshot days
    select
        date_trunc('month', snapshot_date) as period,
        count(employee_id) filter (where status = 'active')
            / nullif(count(distinct snapshot_date), 0) as avg_headcount
    from {{ ref('fct_employee_snapshots') }}
    group by 1
)

select
    h.period,
    coalesce(s.separations, 0) / nullif(h.avg_headcount, 0) as turnover_rate
from avg_headcount as h
left join separations as s
    on s.period = h.period
order by 1
