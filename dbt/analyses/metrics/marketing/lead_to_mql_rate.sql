with mqls as (
    select
        date_trunc('month', mql_date) as period,
        count(lead_id) as mqls
    from {{ ref('fct_leads') }}
    where mql_date is not null
    group by 1
),

leads as (
    select
        date_trunc('month', created_date) as period,
        count(lead_id) as leads
    from {{ ref('fct_leads') }}
    group by 1
)

select
    leads.period,
    coalesce(mqls.mqls, 0) / nullif(leads.leads, 0) as lead_to_mql_rate
from leads
left join mqls using (period)
