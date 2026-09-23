-- Snapshot: take the last as_of_date in each month (semi-additive), then aggregate across rows.
with latest as (
    select
        *,
        max(as_of_date) over (partition by date_trunc('month', as_of_date), service) as last_date
    from {{ ref('fct_code_quality') }}
)
select
    date_trunc('month', as_of_date) as period,
    service,
    sum(tech_debt_hours) / nullif(sum(total_dev_hours), 0) as tech_debt_ratio
from latest
where as_of_date = last_date
group by 1, 2
