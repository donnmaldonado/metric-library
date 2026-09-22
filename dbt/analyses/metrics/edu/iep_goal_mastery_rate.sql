-- Mastered IEP goals / IEP goals evaluated, per month.
select
    date_trunc('month', goal_date) as period,
    school_id,
    disability_category,
    count(iep_goal_id) filter (where is_mastered)
        / nullif(count(iep_goal_id), 0) as iep_goal_mastery_rate
from {{ ref('fct_iep_goals') }}
group by 1, 2, 3
order by 1, 2, 3
