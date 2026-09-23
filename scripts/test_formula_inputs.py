"""Tests for scripts/formula_inputs.py. Run: python3 -m unittest discover -s scripts"""
import tempfile, textwrap, unittest
from pathlib import Path

from formula_inputs import derived_formula_inputs, formula_input_issues

ACTIVE = "\"{{ Dimension('employee__status') }} = 'active'\""
FULL_TIME = "\"{{ Dimension('employee__type') }} = 'full_time'\""


def metric(mid, yaml_body, child=(), parent=(), inputs=()):
    yml = f"metrics:\n  - name: {mid}\n" + textwrap.indent(textwrap.dedent(yaml_body), "    ")
    return {"metricId": mid, "formulaYaml": yml, "childMetrics": list(child),
            "parentMetrics": list(parent), "formulaInputs": list(inputs)}


def simple(mid, measure, filter=None, **edges):
    body = f"type: simple\ntype_params:\n  measure: {measure}\n"
    if filter:
        body += f"filter: {filter}\n"
    return metric(mid, body, **edges)


def ratio(mid, num, den, **edges):
    return metric(mid, f"type: ratio\ntype_params:\n  numerator: {num}\n  denominator: {den}\n", **edges)


def derived(mid, *names, **edges):
    refs = "".join(f"    - name: {n}\n" for n in names)
    return metric(mid, f"type: derived\ntype_params:\n  expr: {' + '.join(names)}\n  metrics:\n{refs}", **edges)


class DerivedFormulaInputsTest(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        marts = Path(self.tmp.name)
        (marts / "hr").mkdir()
        (marts / "hr" / "models.yml").write_text(textwrap.dedent(f"""\
            metrics:
              - name: employee_days
                type: simple
                type_params:
                  measure: employee_count
              - name: active_employees
                type: simple
                type_params:
                  measure: employee_count
                filter: {ACTIVE}
              - name: payroll
                type: simple
                type_params:
                  measure: salary_amount
              - name: avg_employees
                type: derived
                type_params:
                  expr: employee_days / 30
                  metrics:
                    - name: employee_days
            """))
        self.marts = marts

    def tearDown(self):
        self.tmp.cleanup()

    def derive(self, *library):
        return derived_formula_inputs(list(library), self.marts)

    def test_derived_metric_reads_library_metrics_by_name_in_order(self):
        d = self.derive(simple("a", "x"), simple("b", "y"), derived("combo", "b", "a"))
        self.assertEqual(d["combo"].inputs, ["b", "a"])

    def test_ratio_reads_library_metrics_by_name(self):
        d = self.derive(simple("revenue", "revenue_amount"), simple("profit", "profit_amount"),
                        ratio("margin", "profit", "revenue"))
        self.assertEqual(d["margin"].inputs, ["profit", "revenue"])

    def test_ratio_input_with_filter_is_still_read_by_name(self):
        d = self.derive(simple("revenue", "revenue_amount"), simple("profit", "profit_amount"),
                        ratio("margin", "{name: profit, filter: \"x = 1\"}", "revenue"))
        self.assertEqual(d["margin"].inputs, ["profit", "revenue"])

    def test_unfiltered_simple_metric_is_read_by_measure_through_a_mart_metric(self):
        d = self.derive(simple("staff", "employee_count"), ratio("cost_per_staff", "payroll", "employee_days"))
        self.assertEqual((d["cost_per_staff"].inputs, d["cost_per_staff"].flagged), (["staff"], []))

    def test_by_measure_follows_mart_derived_metrics(self):
        d = self.derive(simple("staff", "employee_count"), ratio("cost_per_avg", "payroll", "avg_employees"))
        self.assertEqual(d["cost_per_avg"].inputs, ["staff"])

    def test_simple_metric_reads_its_own_measure(self):
        d = self.derive(simple("staff", "employee_count"), simple("active_staff", "employee_count", ACTIVE))
        self.assertEqual((d["active_staff"].inputs, d["staff"].inputs), (["staff"], []))

    def test_filtered_simple_metric_counts_when_the_reader_applies_the_same_filter(self):
        d = self.derive(simple("active_staff", "employee_count", ACTIVE),
                        ratio("cost_per_active", "payroll", "active_employees"))
        self.assertEqual((d["cost_per_active"].inputs, d["cost_per_active"].flagged), (["active_staff"], []))

    def test_filtered_simple_metric_is_flagged_when_filters_differ(self):
        d = self.derive(simple("headcount", "employee_count", FULL_TIME),
                        ratio("cost_per_head", "payroll", "employee_days"),
                        ratio("cost_per_active", "payroll", "active_employees"))
        self.assertEqual((d["cost_per_head"].inputs, d["cost_per_head"].flagged), ([], ["headcount"]))
        self.assertEqual(d["cost_per_active"].flagged, ["headcount"])

    def test_slices_are_not_flagged_when_a_library_metric_matches_the_read(self):
        d = self.derive(simple("staff", "employee_count"), simple("headcount", "employee_count", FULL_TIME),
                        ratio("cost_per_staff", "payroll", "employee_days"))
        self.assertEqual((d["cost_per_staff"].inputs, d["cost_per_staff"].flagged), (["staff"], []))

    def test_simple_metric_is_not_flagged_against_sibling_slices(self):
        d = self.derive(simple("active_staff", "employee_count", ACTIVE),
                        simple("headcount", "employee_count", FULL_TIME))
        self.assertEqual((d["active_staff"].flagged, d["headcount"].flagged), ([], []))

    def test_cumulative_metric_is_not_flagged_against_sibling_slices(self):
        d = self.derive(simple("headcount", "employee_count", FULL_TIME),
                        metric("active_ytd", f"type: cumulative\ntype_params:\n  measure: employee_count\nfilter: {ACTIVE}\n"))
        self.assertEqual(d["active_ytd"].flagged, [])

    def test_ratio_input_filter_is_part_of_the_filter_applied(self):
        d = self.derive(simple("active_staff", "employee_count", ACTIVE),
                        ratio("cost_per_active", "payroll", f"{{name: employee_days, filter: {ACTIVE}}}"))
        self.assertEqual(d["cost_per_active"].inputs, ["active_staff"])

    def test_driver_edges_are_removed(self):
        d = self.derive(simple("a", "x"), simple("b", "y"), simple("c", "z"),
                        derived("combo", "a", "b", "c", child=["a"], parent=["b"]))
        self.assertEqual(d["combo"].inputs, ["c"])

    def test_inputs_are_listed_once(self):
        d = self.derive(simple("a", "x"), simple("a2", "x"), derived("combo", "a", "a"))
        self.assertEqual(d["combo"].inputs, ["a"])

    def test_unparsable_yaml_has_no_inputs(self):
        d = self.derive({"metricId": "broken", "formulaYaml": "metrics: [unclosed",
                         "childMetrics": [], "parentMetrics": []})
        self.assertEqual(d["broken"].inputs, [])


class FormulaInputIssuesTest(unittest.TestCase):
    def test_matching_inputs_have_no_issues(self):
        m = metric("combo", "", inputs=["a", "b"])
        self.assertEqual(formula_input_issues(m, ["a", "b"]), [])

    def test_mismatch_names_missing_and_extra(self):
        m = metric("combo", "", inputs=["b", "headcount"])
        self.assertEqual(formula_input_issues(m, ["a", "b"]), [
            "combo: formulaInputs is ['b', 'headcount'] but derives as ['a', 'b'] (missing ['a'], extra ['headcount'])"])

    def test_order_matters(self):
        m = metric("combo", "", inputs=["b", "a"])
        self.assertEqual(formula_input_issues(m, ["a", "b"]), [
            "combo: formulaInputs is ['b', 'a'] but derives as ['a', 'b'] (wrong order)"])


if __name__ == "__main__":
    unittest.main()
