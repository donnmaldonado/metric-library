select
    date_trunc('month', sprint_end_date) as period,
    team,
    avg(story_points_completed) as sprint_velocity
from {{ ref('fct_sprints') }}
group by 1, 2
