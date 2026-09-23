# 04 — Data sources

Read [README.md](README.md) first for the shared workflow and done gate. Runs after 03, in parallel with 05 and 06.

## Goal

`dataSources` names source *systems* from one controlled list. Today there are 199 distinct strings in mixed styles: the same system in two cases (`crm`/`CRM`, `hris`/`HRIS`, `finance`/`Finance`), table names (`orders`, `general_ledger`, `balance_sheet`), vendor names (`Zendesk`, `Ahrefs`, `Meta Ads`), and vendors in parentheses (`CRM (Salesforce / HubSpot)`).

## The source list

Create `data/sources.json`, keyed by source ID (snake_case), each with `label`, a one-line `desc` and `vendors` (examples, may be empty):

```json
{
  "crm": {"label": "CRM", "desc": "Accounts, contacts, opportunities", "vendors": ["Salesforce", "HubSpot"]},
  "web_analytics": {"label": "Web analytics", "desc": "Sessions, page views, events", "vendors": ["GA4", "Amplitude", "Mixpanel", "Segment"]}
}
```

Aim for roughly 40–50 IDs: one per kind of system a data team would connect (CRM, ERP, HRIS, SIS, billing, ad platforms, helpdesk, APM…). Vendors live here, never in a metric's `dataSources`.

## Mapping rules

- **Split fragments.** An upstream comma split broke some parenthesized lists into pieces: `"Fleet management system (GPS"` + `"telematics)"`, `"Social media APIs (LinkedIn"` + `"X"` + `"Instagram)"`. Rejoin them before mapping.
- **Tables map to the system that owns them**: `orders` → the commerce/order system, `general_ledger`/`balance_sheet`/`income_statement` → `erp` (or a `general_ledger` system if you judge it distinct). Which dbt model a metric reads is already visible from its `ref()`s, so `dataSources` doesn't repeat it.
- **Vendors map to their category** (`Zendesk` → `helpdesk`, `Sentry` → error tracking) and are added to that source's `vendors`.
- After mapping, dedupe each metric's list and keep first-seen order.
- A string that fits no system (`Attribution model`, `ML model output`, `Market research`) gets its own ID only if it is a real input a data team would connect; otherwise flag it in the review table.

## Review table

Two files:
- `review/04-data-sources.csv`: `raw_string, count, example_metrics, source_id, notes`, one row per distinct raw string (fragments marked).
- `review/04-sources.json`: the proposed `data/sources.json`.

## Wiring

- `scripts/build.py`: the `CATALOG.md` "Data sources" line shows labels from `sources.json`.
- `scripts/validate.py`: every `dataSources` entry is a key of `sources.json`; no metric lists a source twice; every source in `sources.json` is used by at least one metric.
- README Layout table: add `data/sources.json`.

## Done when

- Every metric's `dataSources` holds only IDs from `data/sources.json`.
- The number of distinct values equals the number of keys in `sources.json`, and every approved CSV row is applied.
