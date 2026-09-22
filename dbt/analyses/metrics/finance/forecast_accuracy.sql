select
    date_trunc('month', forecast_period_start) as period,
    segment,
    1 - abs(sum(actual_revenue) - sum(forecast_revenue))
        / nullif(sum(forecast_revenue), 0) as forecast_accuracy
from {{ ref('fct_revenue_forecasts') }}
group by all
order by all
