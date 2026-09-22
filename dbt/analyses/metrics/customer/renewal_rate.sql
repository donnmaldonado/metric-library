select
    date_trunc('month', renewal_date) as period,
    segment,
    count(case when is_renewed then renewal_id end)
        / nullif(count(renewal_id), 0) as renewal_rate
from {{ ref('fct_renewals') }}
group by 1, 2
