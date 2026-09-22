select
    date_trunc('month', close_date) as period,
    segment,
    count(case when is_won then opportunity_id end)
        / nullif(count(opportunity_id), 0) as win_rate
from {{ ref('fct_opportunities') }}
where is_closed
  and is_qualified
group by 1, 2
