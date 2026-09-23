with mqls as (
    select
        date_trunc('month', mql_date) as period,
        count(lead_id) as mqls
    from {{ ref('fct_leads') }}
    where mql_date is not null
    group by 1
),

sqls as (
    select
        date_trunc('month', sql_date) as period,
        count(lead_id) as sqls
    from {{ ref('fct_leads') }}
    where sql_date is not null
    group by 1
)

select
    mqls.period,
    coalesce(sqls.sqls, 0) / nullif(mqls.mqls, 0) as mql_to_sql_rate
from mqls
left join sqls using (period)
