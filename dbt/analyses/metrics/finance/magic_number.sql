-- Quarterly: net new ARR in the quarter / S&M spend in the prior quarter.
with net_new as (
    select
        date_trunc('quarter', movement_date) as period,
        sum(arr_delta) as net_new_arr
    from {{ ref('fct_arr_movements') }}
    group by 1
),

sm_spend as (
    select
        date_trunc('quarter', posted_date) as period,
        sum(expense_amount) as sm_spend
    from {{ ref('fct_gl_entries') }}
    where department in ('sales', 'marketing')
    group by 1
)

select
    net_new.period,
    net_new.net_new_arr / nullif(prior.sm_spend, 0) as magic_number
from net_new
left join sm_spend as prior
    on prior.period = net_new.period - interval 3 month
