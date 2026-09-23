"""Tests for scripts/dimensions.py. Run: python3 -m unittest discover -s scripts"""
import unittest

from dimensions import dimension_issues

DIMENSIONS = {
    "metric_time": {"label": "Time", "desc": "Time axis", "semantic": ["metric_time"]},
    "school": {"label": "School", "desc": "School", "semantic": ["school"]},
}


def metric(mid, *dims):
    return {"metricId": mid, "dimensions": list(dims)}


class DimensionIssuesTest(unittest.TestCase):
    def test_known_used_dimensions_pass(self):
        ms = [metric("a", "metric_time"), metric("b", "school", "metric_time"), metric("c")]
        self.assertEqual(dimension_issues(ms, DIMENSIONS), [])

    def test_unknown_dimension(self):
        issues = dimension_issues([metric("a", "metric_time", "school_id"), metric("b", "school")], DIMENSIONS)
        self.assertEqual(issues, ["a: dimensions 'school_id' is not a key of data/dimensions.json"])

    def test_dimension_listed_twice(self):
        issues = dimension_issues([metric("a", "school", "metric_time", "school")], DIMENSIONS)
        self.assertEqual(issues, ["a: dimensions lists 'school' twice"])

    def test_unused_dimension(self):
        issues = dimension_issues([metric("a", "metric_time")], DIMENSIONS)
        self.assertEqual(issues, ["data/dimensions.json: 'school' is not used by any metric"])


if __name__ == "__main__":
    unittest.main()
