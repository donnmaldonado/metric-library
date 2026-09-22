-- One row per company and period of the cash flow statement, including cash position.
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as cash_flow_period_id,
    cast(null as date   ) as period_start,
    cast(null as varchar) as company_id,
    cast(null as double ) as operating_cash_flow,
    cast(null as double ) as beginning_cash,
    cast(null as double ) as ending_cash,
    cast(null as double ) as cash_on_hand,
    cast(null as double ) as monthly_burn_rate
where false
