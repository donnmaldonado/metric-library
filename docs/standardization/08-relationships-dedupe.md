# 08 — One row per edge in relationships.csv

Read [README.md](README.md) first for the shared workflow and done gate. Runs after 06, in parallel with 07.

## Goal

`data/relationships.csv` has one row per edge. Today `build.py` writes each edge from both metrics that declare it, so every edge appears twice:

| relationship | rows | distinct edges |
|---|---|---|
| `parent_of` | 1054 | 527 |
| `correlated_with` | 1422 | 711 pairs |
| `formula_input` | 40 | 40 (declared on one side only) |

`validate.py` already requires both sides of every `parent_of` and `correlated_with` edge, so the second row adds nothing.

## Change

In `scripts/build.py` (the `relationships.csv` block in `main`):

- `parent_of`: write from `childMetrics` only (`from` = parent, `to` = child), in metric order. Drop the `parentMetrics` loop.
- `correlated_with`: write each unordered pair once, from the metric that comes first in `metrics.json`.
- `formula_input`: unchanged.
- `declared_on` no longer says anything once every edge is declared on both sides. Drop the column. `to_exists` stays.
- Sort nothing else. Row order follows `metrics.json`, so diffs stay small.

This task changes only a generated file and its generator, so there is no review table. The row counts above, and the counts after the change, go in the summary instead.

## Wiring

- `build.py` docstring: "one row per edge" is now true; leave it.
- README Layout table: drop "noting which metric declared each edge" from the `relationships.csv` row, and say that `correlated_with` is unordered.
- README Known issues: delete the "`relationships.csv` lists each parent/child edge twice" entry.
- Grep for other readers of the file (`grep -rn relationships.csv`) and of `declared_on`. None outside `build.py` and README exist today; check again.

## Done when

- `relationships.csv` has 527 `parent_of`, 711 `correlated_with` and 40 `formula_input` rows (or the counts at the time, if the graph has changed), with no duplicate `(from, to, relationship)` and no reversed duplicate `correlated_with` pair.
