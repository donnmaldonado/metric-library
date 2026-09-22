#!/usr/bin/env bash
# Regenerate dbt/ from data/metrics.json and check it.
#
#   scripts/check_dbt.sh          build.py, dbt parse, dbt build, run the ref()-based metric SQL,
#                                 mf validate-configs
#   scripts/check_dbt.sh --fast   build.py, dbt parse only
#
# Uses the dbt-core + dbt-duckdb + dbt-metricflow venv at $DBT_VENV. The `dbt`
# on PATH may be the dbt Cloud CLI, which can't run this project.
# Fails on any error, and on any deprecation warning from dbt parse.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VENV="${DBT_VENV:-/private/tmp/claude-501/-Users-donnobanmaldonado-Projects-metrics/7b5b290a-330a-4c5f-882c-972e94fe51d5/scratchpad/.venv-dbt}"
DBT="$VENV/bin/dbt"
MF="$VENV/bin/mf"
[ -x "$DBT" ] || { echo "dbt not found at $DBT; set DBT_VENV" >&2; exit 2; }

python3 "$ROOT/scripts/build.py"
cd "$ROOT/dbt"
export DBT_PROFILES_DIR="$ROOT/dbt"

echo "== dbt parse"
out="$("$DBT" parse --no-partial-parse 2>&1)" || { echo "$out"; exit 1; }
echo "$out" | grep -iE "warn|error" || true
if echo "$out" | grep -qi "deprecat"; then echo "dbt parse reported deprecations" >&2; exit 1; fi

[ "${1:-}" = "--fast" ] && exit 0

echo "== dbt build"
"$DBT" build --quiet

echo "== metric SQL (analyses/metrics)"
"$DBT" compile --quiet --select "path:analyses/metrics"
"$VENV/bin/python" "$ROOT/scripts/run_analyses.py"

if [ -x "$MF" ]; then
  echo "== mf validate-configs"
  out="$("$MF" validate-configs 2>&1 | tr '\r' '\n' | grep -E '✔|✖|•' | grep -v '⠋' || true)"
  echo "$out"
  if echo "$out" | grep -q '✖' || ! echo "$out" | grep -q 'validated metrics against data warehouse'; then exit 1; fi
fi
echo "dbt checks passed"
