-- Snapshot: stars on primary repos on the last as_of_date of each month.
with latest as (
    select
        *,
        max(as_of_date) over (partition by date_trunc('month', as_of_date)) as last_date
    from {{ ref('fct_github_repos') }}
)
select
    date_trunc('month', as_of_date) as period,
    repo,
    sum(star_count) as oss_stars
from latest
where as_of_date = last_date
    and is_primary
group by 1, 2
