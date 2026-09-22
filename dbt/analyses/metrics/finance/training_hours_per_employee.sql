-- Training hours / average active FTE (FTE-days / snapshot days), per month.
with training as (
    select
        date_trunc('month', completed_date) as period,
        sum(training_hours) as total_training_hours
    from {{ ref('fct_training_records') }}
    group by 1
),

fte as (
    select
        date_trunc('month', snapshot_date) as period,
        sum(fte_fraction) filter (where status = 'active')
            / nullif(count(distinct snapshot_date), 0) as avg_fte
    from {{ ref('fct_employee_snapshots') }}
    group by 1
)

select
    f.period,
    coalesce(t.total_training_hours, 0) / nullif(f.avg_fte, 0) as training_hours_per_employee
from fte as f
left join training as t
    on t.period = f.period
order by 1
