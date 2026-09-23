-- Candidates still active in the pipeline, by application month.
select
    date_trunc('month', applied_date) as period,
    department,
    count(candidate_id) as recruiting_pipeline
from {{ ref('fct_candidates') }}
where status not in ('rejected', 'hired', 'withdrawn')
group by 1, 2
order by 1, 2
