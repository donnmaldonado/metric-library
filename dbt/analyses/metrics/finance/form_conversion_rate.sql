select
    date_trunc('month', event_date) as period,
    form_name,
    page_name,
    sum(form_submissions) / nullif(sum(form_views), 0) as form_conversion_rate
from {{ ref('fct_form_events') }}
group by 1, 2, 3
