select
    date_trunc('month', close_date) as period,
    segment,
    sum(arr_value) / nullif(count(opportunity_id), 0) as avg_deal_size
from {{ ref('fct_opportunities') }}
where is_won
group by 1, 2
