with returned as (
    select date_trunc('month', return_date) as period, sum(units_returned) as units_returned
    from {{ ref('fct_returns') }}
    group by 1
),
sold as (
    select date_trunc('month', order_date) as period, sum(qty_shipped) as units_sold
    from {{ ref('fct_order_lines') }}
    group by 1
)
select
    coalesce(r.period, s.period) as period,
    r.units_returned / nullif(s.units_sold, 0) as return_rate
from returned as r
full outer join sold as s on s.period = r.period
order by 1
