"""Tests for scripts/domains.py. Run: python3 -m unittest discover -s scripts"""
import tempfile, textwrap, unittest
from pathlib import Path

from domains import derived_domains, domain_issues

TAXONOMY = {"domains": {"finance": {}, "hr": {}, "saas": {}}}


def metric(mid, yaml_body, **fields):
    yml = f"metrics:\n  - name: {mid}\n" + textwrap.indent(textwrap.dedent(yaml_body), "    ")
    return {"metricId": mid, "formulaYaml": yml, **fields}


class DerivedDomainsTest(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        marts = Path(self.tmp.name)
        for domain, measure in (("finance", "revenue_amount"), ("hr", "employee_count")):
            (marts / domain).mkdir()
            (marts / domain / "models.yml").write_text(textwrap.dedent(f"""\
                semantic_models:
                  - name: sm_{domain}
                    measures:
                      - name: {measure}
                """))
        (marts / "finance" / "mart_metrics.yml").write_text(textwrap.dedent("""\
            metrics:
              - name: mart_revenue
                type: simple
                type_params:
                  measure: revenue_amount
            """))
        self.marts = marts

    def tearDown(self):
        self.tmp.cleanup()

    def derive(self, *library):
        return derived_domains(list(library), self.marts)

    def test_simple_metric_takes_its_measure_domain(self):
        lib = [metric("headcount", "type: simple\ntype_params:\n  measure: employee_count\n")]
        self.assertEqual(self.derive(*lib), {"headcount": "hr"})

    def test_ratio_follows_numerator_first(self):
        lib = [
            metric("revenue", "type: simple\ntype_params:\n  measure: {name: revenue_amount}\n"),
            metric("headcount", "type: simple\ntype_params:\n  measure: employee_count\n"),
            metric("rev_per_head", "type: ratio\ntype_params:\n  numerator: revenue\n  denominator: headcount\n"),
            metric("head_per_rev", "type: ratio\ntype_params:\n  numerator: {name: headcount}\n  denominator: revenue\n"),
        ]
        d = self.derive(*lib)
        self.assertEqual((d["rev_per_head"], d["head_per_rev"]), ("finance", "hr"))

    def test_derived_skips_inputs_without_a_domain(self):
        lib = [
            metric("headcount", "type: simple\ntype_params:\n  measure: employee_count\n"),
            metric("mystery", "type: simple\ntype_params:\n  measure: not_in_any_mart\n"),
            metric("combo", "type: derived\ntype_params:\n  expr: mystery + headcount\n"
                            "  metrics:\n    - name: mystery\n    - name: headcount\n"),
        ]
        d = self.derive(*lib)
        self.assertEqual((d["mystery"], d["combo"]), (None, "hr"))

    def test_resolves_through_mart_defined_metrics(self):
        lib = [metric("rev", "type: derived\ntype_params:\n  expr: mart_revenue\n  metrics:\n    - name: mart_revenue\n")]
        self.assertEqual(self.derive(*lib), {"rev": "finance"})

    def test_unparsable_yaml_derives_none_instead_of_raising(self):
        lib = [
            {"metricId": "broken", "formulaYaml": "metrics: [unclosed"},
            metric("uses_broken", "type: derived\ntype_params:\n  expr: broken\n  metrics:\n    - name: broken\n"),
        ]
        self.assertEqual(self.derive(*lib), {"broken": None, "uses_broken": None})

    def test_cycle_returns_none(self):
        lib = [
            metric("a", "type: derived\ntype_params:\n  expr: b\n  metrics:\n    - name: b\n"),
            metric("b", "type: derived\ntype_params:\n  expr: a\n  metrics:\n    - name: a\n"),
        ]
        self.assertEqual(self.derive(*lib), {"a": None, "b": None})


class DomainIssuesTest(unittest.TestCase):
    def issues(self, derived="finance", **fields):
        m = {"metricId": "m", "domain": "finance", **fields}
        return domain_issues(m, derived, TAXONOMY)

    def test_matching_domain_is_clean(self):
        self.assertEqual(self.issues(), [])

    def test_unknown_domain(self):
        self.assertEqual(self.issues(derived="ops", domain="ops"), ["m: domain 'ops' is not in taxonomy.domains"])

    def test_domain_must_equal_derived(self):
        self.assertEqual(self.issues(derived="hr"),
                         ["m: domain is 'finance' but derives as 'hr'; fix it or add a domainOverride"])

    def test_no_derived_domain_needs_override(self):
        self.assertEqual(self.issues(derived=None),
                         ["m: domain is 'finance' but no domain derives from its inputs; add a domainOverride"])

    def test_valid_override(self):
        o = {"domain": "finance", "reason": "Finance readers look here."}
        self.assertEqual(self.issues(derived="hr", domainOverride=o), [])
        self.assertEqual(self.issues(derived=None, domainOverride=o), [])

    def test_override_must_match_domain(self):
        o = {"domain": "saas", "reason": "x"}
        self.assertEqual(self.issues(derived="hr", domainOverride=o),
                         ["m: domain is 'finance' but domainOverride.domain is 'saas'"])

    def test_override_needs_reason(self):
        o = {"domain": "finance", "reason": " "}
        self.assertEqual(self.issues(derived="hr", domainOverride=o), ["m: domainOverride has no reason"])

    def test_override_must_differ_from_derived(self):
        o = {"domain": "finance", "reason": "x"}
        self.assertEqual(self.issues(derived="finance", domainOverride=o),
                         ["m: domainOverride.domain equals the derived domain 'finance'; drop the override"])


if __name__ == "__main__":
    unittest.main()
