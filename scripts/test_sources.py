"""Tests for scripts/sources.py. Run: python3 -m unittest discover -s scripts"""
import unittest

from sources import source_issues

SOURCES = {
    "crm": {"label": "CRM", "desc": "Accounts", "vendors": ["Salesforce"]},
    "erp": {"label": "ERP", "desc": "GL", "vendors": []},
}


def metric(mid, *sources):
    return {"metricId": mid, "dataSources": list(sources)}


class SourceIssuesTest(unittest.TestCase):
    def test_known_used_sources_pass(self):
        self.assertEqual(source_issues([metric("a", "crm"), metric("b", "erp", "crm"), metric("c")], SOURCES), [])

    def test_unknown_source(self):
        issues = source_issues([metric("a", "crm", "Salesforce"), metric("b", "erp")], SOURCES)
        self.assertEqual(issues, ["a: dataSources 'Salesforce' is not a key of data/sources.json"])

    def test_source_listed_twice(self):
        issues = source_issues([metric("a", "crm", "erp", "crm")], SOURCES)
        self.assertEqual(issues, ["a: dataSources lists 'crm' twice"])

    def test_unused_source(self):
        issues = source_issues([metric("a", "crm")], SOURCES)
        self.assertEqual(issues, ["data/sources.json: 'erp' is not used by any metric"])


if __name__ == "__main__":
    unittest.main()
