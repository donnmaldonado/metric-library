-- Recruiting spend / hires made, per month.
select
    date_trunc('month', period_start) as period,
    department,
    sum(total_recruiting_cost) / nullif(sum(hires_made), 0) as cost_per_hire
from {{ ref('fct_recruiting_costs') }}
group by 1, 2
order by 1, 2
