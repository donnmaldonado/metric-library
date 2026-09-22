-- One row per customer ARR/MRR movement (new, expansion, contraction, churn) with period start/end balances.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as arr_movement_id,
    cast(null as date   ) as movement_date,
    cast(null as varchar) as rep_id,
    cast(null as varchar) as company_id,
    cast(null as varchar) as movement_type,
    cast(null as varchar) as channel,
    cast(null as varchar) as segment,
    cast(null as varchar) as plan_tier,
    cast(null as varchar) as cohort_month,
    cast(null as varchar) as geography,
    cast(null as double ) as arr_delta,
    cast(null as double ) as net_new_arr,
    cast(null as double ) as prior_quarter_sm_spend,
    cast(null as double ) as ending_arr,
    cast(null as double ) as beginning_arr,
    cast(null as double ) as starting_arr,
    cast(null as double ) as churned_mrr,
    cast(null as double ) as beginning_mrr,
    cast(null as double ) as ending_mrr,
    cast(null as double ) as ending_mrr_from_existing,
    cast(null as double ) as starting_mrr,
    cast(null as double ) as lost_arr
where false
