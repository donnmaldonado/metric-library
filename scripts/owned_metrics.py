#!/usr/bin/env python3
"""List metrics by derived domain (see scripts/domains.py), optionally only the given domains.

This is the derived domain, before any domainOverride; the stored `domain` field
in data/metrics.json includes overrides.

Usage: python3 scripts/owned_metrics.py finance saas ...
"""
import json, sys

from domains import ROOT, derived_domains

if __name__ == "__main__":
    wanted = set(sys.argv[1:])
    for mid, d in derived_domains(json.loads((ROOT / "data/metrics.json").read_text())).items():
        if not wanted or d in wanted:
            print(f"{d}\t{mid}")
