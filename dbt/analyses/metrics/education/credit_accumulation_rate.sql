-- Share of active enrolled students who are high-school students on credit pace, latest enrollment snapshot of each month.
select
    date_trunc('month', snapshot_date) as period,
    school_id,
    count(distinct student_id) filter (where is_on_credit_pace)
        / nullif(count(distinct student_id), 0) as credit_accumulation_rate
from {{ ref('fct_enrollments') }}
where status = 'active'
    and grade_level in ('9', '10', '11', '12')
    and snapshot_date in (select max(snapshot_date) from {{ ref('fct_enrollments') }} group by date_trunc('month', snapshot_date))
group by 1, 2
order by 1, 2
