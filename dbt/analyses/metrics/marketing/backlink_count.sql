-- Snapshot: take the last as_of_date in each month (semi-additive), then aggregate across rows.
with latest as (
    select
        *,
        max(as_of_date) over (partition by date_trunc('month', as_of_date), domain, link_type) as last_date
    from {{ ref('fct_seo_domain_metrics') }}
)
select
    date_trunc('month', as_of_date) as period,
    domain,
    link_type,
    sum(referring_domain_count) as backlink_count
from latest
where as_of_date = last_date
group by 1, 2, 3
