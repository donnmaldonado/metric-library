-- One row per company, fiscal period and P&L segment (income statement lines pivoted to columns).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as financial_period_id,
    cast(null as date   ) as fiscal_period_start,
    cast(null as varchar) as company_id,
    cast(null as varchar) as segment,
    cast(null as varchar) as jurisdiction,
    cast(null as varchar) as product_line,
    cast(null as varchar) as channel,
    cast(null as varchar) as department,
    cast(null as double ) as net_income,
    cast(null as double ) as operating_expenses,
    cast(null as double ) as shareholders_equity,
    cast(null as double ) as revenue_growth_pct,
    cast(null as double ) as ebitda_margin_pct,
    cast(null as double ) as income_tax_expense,
    cast(null as double ) as pretax_income,
    cast(null as double ) as interest_expense,
    cast(null as double ) as nopat,
    cast(null as double ) as invested_capital,
    cast(null as double ) as bad_debt_writeoffs,
    cast(null as double ) as gna_expense,
    cast(null as double ) as hr_total_cost,
    cast(null as double ) as prior_period_revenue,
    cast(null as double ) as fte_headcount
where false
