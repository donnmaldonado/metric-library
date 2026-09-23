# 03 — Derive domain

Read [README.md](README.md) first for the shared workflow and done gate. Runs after 02.

## Goal

Replace the hand-set `vertical` with `domain`: the mart domain (`dbt/models/marts/<domain>/`) whose data the metric reads. The current tags are unreliable (231 metrics are `finance`, but only 71 of those read finance models). `domain` is derived from the model, so it follows the data.

The 11 domains are the directories under `dbt/models/marts/`: commerce, customer, education, engineering, finance, hr, marketing, operations, product, saas, sales.

## Derivation

`scripts/owned_metrics.py` already computes it: the domain of the semantic model behind a metric's first measure, following ratio/derived inputs through other metrics. Move that function into a module both `build.py` and `validate.py` import (e.g. `scripts/domains.py`); keep `owned_metrics.py` as a thin CLI over it.

## Overrides

First-measure order misplaces some cross-domain metrics (e.g. `ltv_cac` resolves to commerce; a finance reader looks for it under finance). For those, set `domainOverride: {"domain": "<domain>", "reason": "<one sentence>"}`. Override sparingly: only where a reader of that domain would clearly look for the metric, and never just to preserve the old vertical. A metric whose derivation returns no domain needs an override.

## Fields

- `domain` replaces `vertical` in place (same key position). Stored in the JSON so it stays self-describing; `validate.py` enforces that it equals the derived value, or `domainOverride.domain` when present.
- `domainOverride` goes right after `domain`, and is present only when used.
- `industry`: the old `pe` vertical ("Private Equity / SaaS") mixed an audience with a business model. For each former `pe` metric, set `industry: saas` when it only makes sense for subscription businesses, otherwise leave `industry` as is. Keep `cross_industry` as the default.

## Other files

- `data/taxonomy.json`: replace `verticals` with `domains` (11 entries, `label` and `desc`); add an `industries` list with the values in use.
- `scripts/build.py`: output paths become `dbt/models/metrics/<domain>/` and `dbt/analyses/metrics/<domain>/`; `config.meta` carries `domain` instead of `vertical`; `CATALOG.md` groups and labels by domain.
- `README.md`, `dbt/CONVENTIONS.md`: replace vertical wording, drop the "`vertical` is unreliable" note, and delete the Known issues entry about wrong verticals.

## Review table

`review/03-derive-domain.csv`: `metricId, label, old_vertical, derived_domain, cross_domain (y/n: inputs span more than one domain), proposed_override, override_reason, old_industry, proposed_industry`. Sort so `cross_domain = y` rows come first; those are where overrides are decided.

## Validation to add

In `scripts/validate.py`:
- `domain` is in `taxonomy.domains`; `industry` is in `taxonomy.industries`;
- `domain` equals the derived domain, or `domainOverride.domain`;
- an override has a non-empty `reason` and differs from the derived domain.

## Done when

- No `vertical` key remains in `data/metrics.json`, the taxonomy, generated YAML meta or scripts (`grep -rn vertical` returns only history you intend to keep).
- `dbt/models/metrics/` and `dbt/analyses/metrics/` contain exactly the domain folders in use.
- Every override in the JSON matches an approved CSV row.
