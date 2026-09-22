-- Monthly marketing spend / leads reaching MQL in the month (fct_leads is owned by the sales domain).
with spend as (
    select date_trunc('month', ad_date) as period, channel, sum(spend) as marketing_spend
    from {{ ref('fct_ad_performance') }}
    group by 1, 2
),
leads as (
    select date_trunc('month', mql_date) as period, channel, count(lead_id) as qualified_leads
    from {{ ref('fct_leads') }}
    where mql_date is not null
    group by 1, 2
)
select
    spend.period,
    spend.channel,
    spend.marketing_spend / nullif(leads.qualified_leads, 0) as cost_per_mql
from spend
left join leads
    on leads.period = spend.period
    and leads.channel = spend.channel
