"""Execute every metric SQL file (dbt/analyses/metrics/**) against the dbt duckdb.

Run with the dbt venv's python after `dbt build` and `dbt compile` (scripts/check_dbt.sh does this).
"""
import sys
from pathlib import Path

import duckdb

DBT = Path(__file__).resolve().parent.parent / "dbt"
COMPILED = DBT / "target" / "compiled" / "metric_library"

todo = sorted((DBT / "analyses" / "metrics").rglob("*.sql"))
con = duckdb.connect(str(DBT / "metric_library.duckdb"), read_only=True)
failed = []
for p in todo:
    compiled = COMPILED / p.relative_to(DBT)
    try:
        con.execute(compiled.read_text()).fetchall()
    except Exception as e:  # noqa: BLE001 - report every failure
        failed.append(f"{p.relative_to(DBT)}: {str(e).splitlines()[0]}")
print("\n".join(failed))
print(f"analyses: {len(todo) - len(failed)}/{len(todo)} ran OK", file=sys.stderr)
sys.exit(1 if failed else 0)
