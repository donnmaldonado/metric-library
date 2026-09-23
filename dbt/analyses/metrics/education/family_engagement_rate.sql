-- Families attending at least one event or conference / families, per school year.
select
    school_year,
    school_id,
    count(distinct family_id) filter (where attended_event)
        / nullif(count(distinct family_id), 0) as family_engagement_rate
from {{ ref('fct_family_engagement') }}
group by 1, 2
order by 1, 2
