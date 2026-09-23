# 01 — Remove staging metrics

Read [README.md](README.md) first for the shared workflow and done gate.

## Goal

The metric library holds business metrics only. The 53 `stg_*` metrics plus `cogs_stg` are scaffolding that point a metric at every dbt model (`stg_page_view_row` "Raw Page View Row", `stg_student_assessment_row` "Raw Assessment Row"). The dbt models behind them stay; only the metric entries go.

## Classify each one

Every staging metric gets exactly one decision:

- **delete** — nothing consumes it, or it is an alias of a real metric (`stg_session_row` → `website_sessions`). Repoint its graph edges to the real metric where the edge still makes sense (a parent that listed it as a child may list the real metric instead), otherwise drop them.
- **rename** — another metric's `formulaYaml` uses it as an input, so it carries a real quantity. Give it a business ID and label (`stg_leads_count` → `leads`, "Leads"), keep it as an `input`-tier metric, and update every reference. Known consumers today:
  - `stg_leads_count` ← `lead_to_mql_rate`
  - `stg_inventory_items` ← `stockout_rate`
  - `stg_order_line_row` ← `fill_rate`
  - `stg_work_order_row` ← `preventive_maintenance_rate`

  Staging metrics that only feed other staging metrics (`stg_orders_count` ← `stg_purchases_count`) follow the fate of their consumers. Before renaming, check whether an existing real metric already measures the same thing (e.g. an `orders` or `leads` metric); if so, point the consumer at it and **delete** instead.

Re-derive the consumer list yourself (search every `formulaYaml` for each staging ID); the list above is a starting point.

## Review table

`review/01-remove-staging-metrics.csv`: `metricId, label, decision (delete|rename), new_id, new_label, repoint_to, consumers, notes`.

## Graph consequences

Deleting a child can leave a parent with no children, or a KPI/Input with no parent. `validate.py` reports these as orphans; resolve each by attaching the metric to the correct real driver, never by re-adding a staging metric. List every such fix in your summary.

## Validation to add

In `scripts/validate.py`: a metricId matching `^stg_` or `_stg$` is an issue.

## Done when

- No metric ID in `data/metrics.json` starts with `stg_` or ends with `_stg`.
- The four consumers above (and any you found) compute from a real metric, and `check_dbt.sh` runs their SQL.
- The mart YAML headers and `Used by:` descriptions no longer name deleted IDs.
- README: the Known issues lines about `stg_*` metrics (`stg_products_active` in Model gaps; "The `stg_*` and alias metrics…" in Graph and catalog) are updated to cover only what remains.
