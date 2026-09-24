# Metric Library

375 business metrics (22 North Star, 266 KPI, 87 Input) across 11 domains. Each one comes with a definition, a MetricFlow metric, runnable SQL and its place in a driver tree.

**[Browse it as a periodic table →](https://donnmaldonado.github.io/metric-library/)**

## What's inside

| Path | Contents |
|---|---|
| `data/metrics.json` | **Source of truth**: every metric's definition, formulas, dimensions, data sources and graph edges. |
| `data/*.json` | Controlled vocabularies: tiers, domains and units (`taxonomy.json`), source systems (`sources.json`) and dimensions (`dimensions.json`). |
| `CATALOG.md` | Readable index of every metric, grouped by tier and domain. |
| `dbt/` | dbt + DuckDB project: stub models with semantic models, plus the generated metric YAML and SQL ([conventions](dbt/CONVENTIONS.md)). |
| `scripts/` | Build, validation and export scripts. |
| `site/` | The Metric Periodic Table, a Vite + TypeScript static site ([spec](https://claude.ai/code/artifact/bf02b340-5baa-47c1-82c5-5d5ad5155005)). |
| `docs/` | [Metric conventions](docs/metric-conventions.md), [known issues](docs/known-issues.md) and past review work. |

## Working on the library

Edit `data/metrics.json` (or the hand-maintained models under `dbt/models/marts/`), then:

```sh
python3 scripts/build.py      # regenerate metric YAML and SQL, relationships.csv and CATALOG.md
python3 scripts/validate.py   # graph, YAML and convention checks; must exit 0
scripts/check_dbt.sh          # dbt parse + build, run every metric's SQL, mf validate-configs
```

`check_dbt.sh` needs a Python 3.11 venv with dbt-core, dbt-duckdb and dbt-metricflow, with `DBT_VENV` pointing at it (see [dbt/CONVENTIONS.md](dbt/CONVENTIONS.md#environment)). Unit tests: `python3 -m unittest discover -s scripts`.

Before adding or changing a metric, read the [metric conventions](docs/metric-conventions.md). When you resolve one of the [known issues](docs/known-issues.md), delete its entry.

## The periodic table site

```sh
python3 scripts/export_portfolio.py   # data/metrics.json → site/public/data/ (not committed)
cd site && npm ci && npm run dev       # local dev server; npm run build for site/dist
```

Every push to `main` builds, validates, exports and deploys the site to GitHub Pages; nothing deploys if a check fails. `data/portfolio_exclude.json` decides which metrics are left out. Every kept metric must stay connected to the tree, so dropping one may need new edges (see [docs/portfolio/stranded-metrics.csv](docs/portfolio/stranded-metrics.csv)). Deep link to a metric with `?m=<metricId>`.
