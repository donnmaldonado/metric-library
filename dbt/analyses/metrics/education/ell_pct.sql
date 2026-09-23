-- Share of active enrolled students who are English Language Learners, latest enrollment snapshot of each month.
select
    date_trunc('month', snapshot_date) as period,
    school_id,
    count(distinct student_id) filter (where is_ell)
        / nullif(count(distinct student_id), 0) as ell_pct
from {{ ref('fct_enrollments') }}
where status = 'active'
    and snapshot_date in (select max(snapshot_date) from {{ ref('fct_enrollments') }} group by date_trunc('month', snapshot_date))
group by 1, 2
order by 1, 2
