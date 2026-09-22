-- One row per purchase order (supplier, lead time, compliance, savings and scorecard inputs).
-- Stub: returns zero rows with the typed columns the metric library needs.
--
-- is_compliant: the vendor fulfilled the PO to specification (quality, quantity, terms).
-- baseline_spend is the budgeted/benchmark cost of the PO, actual_spend what was paid.
-- quality_score, delivery_score and cost_score are the supplier's scorecard
-- ratings (0-100) for this PO.
select
    cast(null as varchar) as po_id,
    cast(null as date   ) as po_date,
    cast(null as varchar) as supplier_id,
    cast(null as varchar) as product_id,
    cast(null as date   ) as receipt_date,
    cast(null as varchar) as product_category,
    cast(null as varchar) as status,
    cast(null as varchar) as vendor,
    cast(null as varchar) as category_manager,
    cast(null as varchar) as spend_category,
    cast(null as varchar) as category,
    cast(null as boolean) as is_compliant,
    cast(null as double ) as po_amount,
    cast(null as double ) as baseline_spend,
    cast(null as double ) as actual_spend,
    cast(null as double ) as quality_score,
    cast(null as double ) as delivery_score,
    cast(null as double ) as cost_score
where false
