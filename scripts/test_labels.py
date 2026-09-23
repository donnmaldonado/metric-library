"""Tests for scripts/labels.py. Run: python3 -m unittest discover -s scripts"""
import unittest

from labels import label_issues

TAXONOMY = {"acronyms": ["ARR", "R&D"], "units": ["rate", "currency"]}


def metric(mid, label, short=None, unit="rate", desc="A sentence."):
    return {"metricId": mid, "label": label, "shortLabel": short or label, "unit": unit, "shortDescription": desc}


class LabelIssuesTest(unittest.TestCase):
    def test_clean_metrics_pass(self):
        ms = [metric("a", "Net Revenue Retention", "NRR"), metric("b", "R&D Share of ARR", unit="currency")]
        self.assertEqual(label_issues(ms, TAXONOMY), [])

    def test_symbols_in_label(self):
        ms = [metric("a", "Gross Margin %", "a"), metric("b", "Trial → Paid", "b"), metric("c", "# Leads", "c"),
              metric("d", "Debt / Equity", "d")]
        self.assertEqual(label_issues(ms, TAXONOMY), [
            "a: label 'Gross Margin %' contains '%'; use words",
            "b: label 'Trial → Paid' contains '→'; use words",
            "c: label '# Leads' contains '#'; use words",
            "d: label 'Debt / Equity' contains '/'; use words",
        ])

    def test_avg_and_parenthesized_qualifier(self):
        ms = [metric("a", "Avg Tenure", "a"), metric("b", "Tenure (yrs)", "b"), metric("c", "Average Tenure", "c")]
        self.assertEqual(label_issues(ms, TAXONOMY), [
            "a: label 'Avg Tenure' abbreviates 'Avg'; write 'Average'",
            "b: label 'Tenure (yrs)' has a parenthesized qualifier; use words, and put units in `unit`",
        ])

    def test_acronyms_must_be_allowlisted(self):
        ms = [metric("a", "LTV to CAC Ratio", "a"), metric("b", "SG&A Expense", "b"), metric("c", "Q1 ARR", "c"),
              metric("d", "SaaS R&D Spend", "d")]
        self.assertEqual(label_issues(ms, TAXONOMY), [
            "a: label 'LTV to CAC Ratio' uses acronym 'LTV', not in taxonomy.acronyms; spell it out",
            "a: label 'LTV to CAC Ratio' uses acronym 'CAC', not in taxonomy.acronyms; spell it out",
            "b: label 'SG&A Expense' uses acronym 'SG&A', not in taxonomy.acronyms; spell it out",
        ])

    def test_short_label_at_most_24_characters(self):
        ms = [metric("a", "Revenue", "Twenty-Four Characters!!"), metric("b", "Cost", "Twenty-Five Characters!!!")]
        self.assertEqual(label_issues(ms, TAXONOMY), [
            "b: shortLabel 'Twenty-Five Characters!!!' is 25 characters; the limit is 24",
        ])

    def test_labels_and_short_labels_are_unique(self):
        ms = [metric("a", "Revenue", "Rev"), metric("b", "Revenue", "Rev"), metric("c", "Cost", "Rev")]
        self.assertEqual(label_issues(ms, TAXONOMY), [
            "label 'Revenue' is used by 2 metrics (a, b)",
            "shortLabel 'Rev' is used by 3 metrics (a, b, c)",
        ])

    def test_unit_must_be_in_taxonomy(self):
        ms = [metric("a", "Revenue", unit="currency"), metric("b", "Tenure", unit="yrs")]
        self.assertEqual(label_issues(ms, TAXONOMY), ["b: unit 'yrs' is not in taxonomy.units"])

    def test_short_description_is_one_sentence_ending_in_a_period(self):
        ms = [metric("a", "A", desc="Net debt over EBITDA, e.g. 3.2x."), metric("b", "B", desc="No period"),
              metric("c", "C", desc="Two sentences. Here."), metric("d", "D", desc="Ends in a period.")]
        self.assertEqual(label_issues(ms, TAXONOMY), [
            "b: shortDescription doesn't end in a period",
            "c: shortDescription is more than one sentence",
        ])


if __name__ == "__main__":
    unittest.main()
