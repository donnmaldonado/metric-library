-- Alias of otd_rate.

select
    date_trunc('month', ship_date) as period,
    carrier,
    count(case when is_on_time then 1 end)
        / nullif(count(*), 0) as on_time_delivery_rate
from {{ ref('fct_shipments') }}
where is_delivered
group by 1, 2
order by 1, 2
