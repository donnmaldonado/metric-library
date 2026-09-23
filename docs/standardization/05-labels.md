# 05 — Labels

Read [README.md](README.md) first for the shared workflow and done gate. Runs after 03, in parallel with 04 and 06.

## Goal

Every metric has a full `label` in one style, a terse `shortLabel` for dashboard tiles, and a `unit` field so labels stop carrying units. Today some labels are dashboard-tile style (`Gr3 Reading %`, `K-Readiness %`, `Avg Teacher Exp (yrs)`, `Trial → Paid %`), while others are full names (`Advanced Course Enrollment`), and units appear in four spellings (`(mo)`, `(days)`, `(Months)`, `(yrs)`).

## Label style

- **Title Case full name** of the quantity: "Grade 3 Reading Proficiency Rate", "Kindergarten Readiness Rate", "Average Teacher Experience", "Trial-to-Paid Conversion Rate".
- Words, not symbols: `Average` not `Avg`, `Number of` / a plural noun not `#`, a noun such as `Rate` / `Share` / `Margin` not `%`, `to` not `→`.
- No unit, and no parenthesized qualifier. A qualifier becomes words ("Headcount (Dept)" → "Headcount by Department" only if it is a genuinely separate metric; after 02, most are gone).
- Acronyms: spell the term out ("Net Revenue Retention", "Customer Acquisition Cost"). Keep acronyms that *are* the everyday name, listed in an `acronyms` allowlist in `data/taxonomy.json` (starting set to propose: EBITDA, API, SLA, ARR, MRR, NPS, eNPS, CSAT, SEO, IEP, ELL, FAFSA, AP, G&A, R&D, S&M, K-12). Keep the list short: a term belongs there only when the spelled-out form would confuse a reader in that domain.
- Labels are unique across the library.
- Apply the pending fix from README Known issues: `customer_ltv` → "Realized Customer LTV" (or its spelled-out equivalent) if it survived 02.

## `shortLabel`

Required on every metric, placed right after `label`. At most 24 characters, for tiles and chart axes: abbreviations, acronyms and `%` are welcome here (`Gr3 Reading %`, `NRR`, `Avg Teacher Exp`). Use the old terse label where one exists; otherwise shorten the new label. It equals `label` when the label already fits and reads well. Unique across the library.

## `unit`

Required, placed after `shortLabel`. Proposed enum (finalize in the review table and record it in `data/taxonomy.json` under `units`):

| unit | meaning |
|---|---|
| `rate` | fraction 0–1, displayed as % (README: rates are fractions) |
| `ratio` | a multiple, e.g. LTV:CAC 3.2× |
| `currency` | money amount |
| `count` | whole things |
| `score` | a native scale such as NPS (−100–100) or a 1–5 survey |
| `days`, `months`, `years`, `hours`, `minutes` | durations |

Derive the unit from the formula and description, not from the old label; flag disagreements (a label with `%` over a formula that isn't 0–1).

## Wiring

- `scripts/build.py` today refreshes only `config.meta` in the generated YAML, so the YAML `label` drifts from the JSON. Make it also set the MetricFlow `label` from `label`, and add `shortLabel` and `unit` to `config.meta`.
- `CATALOG.md` headings keep `label`; add the unit.
- `scripts/validate.py`: `label` has no forbidden tokens (`%`, `#`, `→`, a standalone `Avg`, a parenthesized suffix) and uses only allowlisted acronyms (any all-caps token of 2+ letters must be in `acronyms`); `shortLabel` ≤ 24 characters; `label` and `shortLabel` are each unique; `unit` is in `taxonomy.units`.
- Also normalize `shortDescription`: one sentence, ending in a period. Only 214 of them end in a period today; this is mechanical and needs no review rows.

## Review table

`review/05-labels.csv`: `metricId, old_label, label, shortLabel, unit, unit_basis (formula|description), flags`.

## Done when

- Every metric has `label`, `shortLabel` and `unit` passing the new checks.
- The generated YAML `label` equals the JSON `label` for every metric.
- README "Labels to fix" entry deleted; the Metric definition conventions section describes `shortLabel` and `unit`.
