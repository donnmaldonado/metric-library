-- One row per customer survey response (NPS, CSAT, CES).
-- Stub: returns zero rows with the typed columns the metric library needs.
-- survey_type: 'nps', 'csat' or 'ces'. is_satisfied: CSAT rating in the top two boxes (4-5 on a 5-point scale).
-- satisfied_responses, total_responses, promoters, detractors and responses are unused pre-aggregates;
-- the library metrics use survey_type, score and is_satisfied.
select
    cast(null as varchar) as response_id,
    cast(null as date   ) as response_date,
    cast(null as varchar) as customer_id,
    cast(null as varchar) as interaction_id,
    cast(null as varchar) as respondent_id,
    cast(null as date   ) as survey_date,
    cast(null as varchar) as channel,
    cast(null as varchar) as interaction_type,
    cast(null as varchar) as product_name,
    cast(null as varchar) as support_team,
    cast(null as double ) as score,
    cast(null as varchar) as segment,
    cast(null as double ) as effort_score,
    cast(null as double ) as satisfaction_score,
    cast(null as double ) as satisfied_responses,
    cast(null as double ) as total_responses,
    cast(null as double ) as promoters,
    cast(null as double ) as detractors,
    cast(null as double ) as responses,
    cast(null as double ) as responses_received,
    cast(null as double ) as surveys_sent,
    cast(null as varchar) as survey_type,
    cast(null as boolean) as is_satisfied
where false
