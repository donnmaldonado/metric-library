-- One row per user and score date from the churn prediction model.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as churn_score_id,
    cast(null as date   ) as score_date,
    cast(null as varchar) as user_id,
    cast(null as varchar) as plan_tier,
    cast(null as varchar) as cohort,
    cast(null as double ) as churn_probability
where false
