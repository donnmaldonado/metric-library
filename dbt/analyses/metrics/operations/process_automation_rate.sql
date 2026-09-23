-- Latest catalog snapshot in each month.
with catalog as (
    select
        *,
        max(as_of_date) over (partition by date_trunc('month', as_of_date)) as month_end_date
    from {{ ref('dim_processes') }}
)
select
    date_trunc('month', as_of_date) as period,
    count(case when is_automated then 1 end)
        / nullif(count(process_id), 0) as process_automation_rate
from catalog
where as_of_date = month_end_date
group by 1
order by 1
