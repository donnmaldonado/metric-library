-- One row per employee pay record (pay components, annual salary and market midpoint at pay date, gender).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as pay_record_id,
    cast(null as date   ) as pay_date,
    cast(null as varchar) as employee_id,
    cast(null as varchar) as job_level,
    cast(null as varchar) as department,
    cast(null as varchar) as location,
    cast(null as varchar) as pay_period,
    cast(null as varchar) as pay_type,
    cast(null as varchar) as gender,
    cast(null as double ) as annual_salary,
    cast(null as double ) as market_midpoint,
    cast(null as double ) as gross_pay,
    cast(null as double ) as base_pay,
    cast(null as double ) as bonus_pay,
    cast(null as double ) as benefits_cost,
    cast(null as double ) as employer_taxes,
    cast(null as double ) as equity_expense
where false
