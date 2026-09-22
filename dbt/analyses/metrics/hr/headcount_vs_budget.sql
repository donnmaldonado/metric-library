-- Headcount (active full-time, latest snapshot) minus budgeted headcount (latest plan period), per month.
with actual as (
    select
        date_trunc('month', snapshot_date) as period,
        count(employee_id) as headcount
    from {{ ref('fct_employee_snapshots') }}
    where status = 'active'
        and employment_type = 'full_time'
        and snapshot_date in (select max(snapshot_date) from {{ ref('fct_employee_snapshots') }} group by date_trunc('month', snapshot_date))
    group by 1
),

budget as (
    select
        date_trunc('month', period_start) as period,
        sum(budgeted_headcount) as budgeted_headcount
    from {{ ref('fct_headcount_plan') }}
    where period_start in (select max(period_start) from {{ ref('fct_headcount_plan') }} group by date_trunc('month', period_start))
    group by 1
)

select
    b.period,
    coalesce(a.headcount, 0) - b.budgeted_headcount as headcount_vs_budget
from budget as b
left join actual as a
    on a.period = b.period
order by 1
