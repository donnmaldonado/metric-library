# Metric library standardization

Tasks that bring `data/metrics.json` to one consistent style: 01–06, then follow-ups 07–09. Each task has its own handoff; this file holds the rules they share. Read this file first, then your task's handoff.

| # | Handoff | Changes | Depends on |
|---|---|---|---|
| 01 | [Remove staging metrics](01-remove-staging-metrics.md) | deletes/renames `stg_*` metrics | — |
| 02 | [Merge duplicates](02-merge-duplicates.md) | deletes alias metrics, adds `retiredIds` | 01 |
| 03 | [Derive domain](03-derive-domain.md) | `vertical` → `domain`, taxonomy | 02 |
| 04 | [Data sources](04-data-sources.md) | `dataSources`, new `data/sources.json` | 03 |
| 05 | [Labels](05-labels.md) | `label`, new `shortLabel` and `unit` | 03 |
| 06 | [Dimensions](06-dimensions.md) | `dimensions`, new `data/dimensions.json` | 03 |
| 07 | [Queryable dimensions](07-queryability.md) | `dimensions`, mart semantic models, `data/dimensions.json` | 06 |
| 08 | [One row per edge](08-relationships-dedupe.md) | `scripts/build.py`, `data/relationships.csv` | 06 |
| 09 | [formulaInputs follows the formulas](09-formula-inputs.md) | `formulaInputs`, new `scripts/formula_inputs.py` | 07 |

## Order

01 → 02 → 03 run one after another: each shrinks or reshapes the set of metrics the next one works on. 04, 05 and 06 touch different fields and can run in parallel, each in its own worktree branched from `main` after 03 merges. 07 and 08 can run in parallel the same way; 09 branches after 07 merges. Merge them one at a time; for conflicts in generated files (`dbt/models/metrics/`, `dbt/analyses/metrics/`, `data/relationships.csv`, `CATALOG.md`), take either side and rerun `python3 scripts/build.py`.

## Workflow

1. Branch from `main`: `std/<nn>-<slug>` (e.g. `std/01-remove-staging-metrics`).
2. **Review table.** Write your task's proposed mapping to `docs/standardization/review/<nn>-<slug>.csv` with the columns your handoff names, changing nothing else. Stop and return a summary: row counts per decision, and every row you are unsure of. The user approves or edits the CSV; apply it only after approval.
3. Apply the approved CSV with a one-off script (keep it in the scratchpad, not the repo).
4. Pass the **done gate**, then commit on the branch.

## Editing `data/metrics.json`

- Edit through `json.load` / `json.dumps(metrics, indent=2, ensure_ascii=False)` plus a trailing newline (as in `dbt/CONVENTIONS.md`), so formatting stays byte-stable and parallel branches merge cleanly.
- Keep key order: new fields go right after the field they relate to (named in each handoff).
- Every graph edit is two-sided: `parentMetrics`/`childMetrics` pairs and `correlatedMetrics` are symmetric. When a metric is deleted, remove it from every other metric's `parentMetrics`, `childMetrics`, `correlatedMetrics` and `formulaInputs`, and from any `formulaYaml` that names it as an input.
- A metric ID appears in more places than the JSON. Grep the whole repo for each ID you delete or rename: the hand-maintained `dbt/models/marts/**/*.yml` carry `# Metrics on this model:` headers and `Used by:` descriptions, and `README.md` names metrics in Known issues.

## Done gate

All of these, on your branch:

- `python3 scripts/build.py` runs clean.
- `python3 scripts/validate.py` exits 0, including the new checks your handoff adds.
- `scripts/check_dbt.sh` passes (needs `DBT_VENV`; see `dbt/CONVENTIONS.md#environment`).
- `grep -rn` for every deleted or renamed ID returns only intended hits (e.g. `retiredIds`).
- `README.md` is current: metric and tier counts in the intro, the Layout and conventions sections your change touches, and each Known issues entry your task resolves deleted.
