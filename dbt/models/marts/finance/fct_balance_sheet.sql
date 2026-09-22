-- One row per company and balance sheet date (balances pivoted to columns).
-- Stub: returns zero rows with the typed columns the metric library needs.
select
    cast(null as varchar) as balance_sheet_snapshot_id,
    cast(null as date   ) as as_of_date,
    cast(null as varchar) as company_id,
    cast(null as double ) as accounts_payable_balance,
    cast(null as double ) as accounts_receivable_balance,
    cast(null as double ) as cash_balance,
    cast(null as double ) as total_assets,
    cast(null as double ) as total_liabilities,
    cast(null as double ) as current_assets,
    cast(null as double ) as current_liabilities,
    cast(null as double ) as ttm_ebitda,
    cast(null as double ) as shareholders_equity,
    cast(null as double ) as cash,
    cast(null as double ) as short_term_debt,
    cast(null as double ) as long_term_debt
where false
