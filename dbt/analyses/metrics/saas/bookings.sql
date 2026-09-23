select
    date_trunc('month', signed_date) as period,
    segment,
    sum(contract_arr) as bookings
from {{ ref('fct_contracts') }}
group by 1, 2
