with

revenue as (
    select
        date_trunc('month', recognized_date) as period,
        sum(recognized_revenue) as revenue
    from {{ ref('fct_revenue') }}
    group by 1
),

cogs as (
    select
        date_trunc('month', posted_date) as period,
        sum(cogs_amount) as cogs
    from {{ ref('fct_gl_entries') }}
    group by 1
),

headcount as (
    select
        date_trunc('month', snapshot_date) as period,
        count(employee_id) as headcount
    from (
        select *
        from {{ ref('fct_employee_snapshots') }}
        where status = 'active'
        qualify snapshot_date = max(snapshot_date) over (partition by date_trunc('month', snapshot_date))
    ) as latest
    group by 1
),

periods as (
    select period from revenue
    union
    select period from cogs
    union
    select period from headcount
)

select
    period,
    (revenue - cogs) / nullif(headcount, 0) as gross_profit_per_employee
from periods
left join revenue using (period)
left join cogs using (period)
left join headcount using (period)
order by period
