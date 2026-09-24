"""Tests for scripts/export_portfolio.py. Run: python3 -m unittest discover -s scripts"""
import unittest

from export_portfolio import (ExportError, apply_exclusion, assign_symbols, build, industry_label, layout,
                              orphan_issues)

DOMAIN_LABELS = {"finance": "Finance", "marketing": "Marketing", "sales": "Sales"}


def metric(mid, tier="kpi", domain="finance", parents=(), label=None, short=None, **extra):
    m = {"metricId": mid, "label": label or mid.replace("_", " ").title(), "shortLabel": short or mid,
         "unit": "rate", "domain": domain, "tier": tier, "industry": "cross_industry",
         "shortDescription": f"{mid}.", "numerator": "", "denominator": "", "dimensions": [], "dataSources": [],
         "formulaYaml": f"yaml {mid}", "formulaSql": f"sql {mid}", "parentMetrics": list(parents),
         "childMetrics": [], "correlatedMetrics": [], "formulaInputs": []}
    m.update(extra)
    return m


def graph(*ms):
    """Fill each metric's childMetrics from the others' parentMetrics, in the order given."""
    by = {m["metricId"]: m for m in ms}
    for m in ms:
        for p in m["parentMetrics"]:
            by[p]["childMetrics"].append(m["metricId"])
    return list(ms)


class ExclusionTest(unittest.TestCase):
    def test_drops_excluded_and_filters_every_edge_list_in_order(self):
        ms = graph(metric("ns", "north_star"), metric("a", parents=["ns"]), metric("b", parents=["ns"]),
                   metric("c", "input", parents=["b", "a"], correlatedMetrics=["x", "b", "a"], formulaInputs=["a", "b"]))
        kept = {m["metricId"]: m for m in apply_exclusion(ms, {"b": "No data source"})}
        self.assertEqual(sorted(kept), ["a", "c", "ns"])
        self.assertEqual(kept["ns"]["childMetrics"], ["a"])
        self.assertEqual(kept["c"]["parentMetrics"], ["a"])
        self.assertEqual(kept["c"]["correlatedMetrics"], ["a"])  # "x" is not a metric
        self.assertEqual(kept["c"]["formulaInputs"], ["a"])
        self.assertEqual(ms[3]["parentMetrics"], ["b", "a"])  # input is not mutated

    def test_unknown_exclusion_id(self):
        with self.assertRaises(ExportError) as e:
            apply_exclusion([metric("a")], {"a": "r", "zzz": "r"})
        self.assertEqual(e.exception.issues,
                         ["data/portfolio_exclude.json: 'zzz' is not a metricId in data/metrics.json"])


class OrphanTest(unittest.TestCase):
    def test_connected_graph_passes(self):
        ms = graph(metric("ns", "north_star"), metric("k", parents=["ns"]), metric("i", "input", parents=["k"]))
        self.assertEqual(orphan_issues(apply_exclusion(ms, {})), [])

    def test_stranded_non_north_stars_and_childless_north_star(self):
        ms = graph(metric("ns", "north_star"), metric("ns2", "north_star"), metric("k", parents=["ns"]),
                   metric("k2", parents=["k"]), metric("i", "input", parents=["k"]), metric("i2", "input", parents=["ns2"]))
        issues = orphan_issues(apply_exclusion(ms, {"k": "r", "ns2": "r"}))
        self.assertEqual(issues, ["ns: north_star has no kept child", "k2: kpi has no kept parent",
                                  "i: input has no kept parent", "i2: input has no kept parent"])


def layout_fixture():
    ms = graph(
        metric("fcf", "north_star", label="Free Cash Flow"),
        metric("rev", "north_star", label="Revenue"),
        metric("mns", "north_star", "marketing", label="Marketing Pipeline"),
        metric("k1", parents=["rev"]),
        metric("k2", parents=["rev"]),
        metric("k3", parents=["fcf"]),
        metric("k4", parents=["k1"]),
        metric("kf", parents=["mns"]),
        metric("mk", domain="marketing", parents=["mns"]),
        metric("mk2", domain="marketing", parents=["rev"]),
        metric("i1", "input", parents=["k2"]),
        metric("i2", "input", parents=["rev", "k1"]),
        metric("i3", "input", parents=["i1"]),
    )
    by = {m["metricId"]: m for m in ms}
    by["rev"]["childMetrics"] = ["k2", "i2", "mk2", "k1"]  # k2 before k1: childMetrics order wins
    by["k1"]["childMetrics"] = ["i2", "k4"]
    return ms


class LayoutTest(unittest.TestCase):
    def setUp(self):
        self.ordered, self.bands = layout(layout_fixture(), DOMAIN_LABELS)

    def test_bands_by_size(self):
        self.assertEqual(self.bands, [("finance", 10), ("marketing", 3)])

    def test_bands_tie_by_label(self):
        ms = graph(metric("s", "north_star", "sales"), metric("m", "north_star", "marketing"))
        _, bands = layout(ms, DOMAIN_LABELS)
        self.assertEqual(bands, [("marketing", 1), ("sales", 1)])

    def test_reading_order_and_groups(self):
        got = [(m["metricId"], m["group"]) for m in self.ordered]
        self.assertEqual(got, [
            # finance: North Stars by descendants (rev has 6, fcf 1)
            ("rev", "rev"), ("fcf", "fcf"),
            # KPIs: rev's family in rev's childMetrics order, k4 nested under k1; then fcf; then foreign mns
            ("k2", "rev"), ("k1", "rev"), ("k4", "rev"), ("k3", "fcf"), ("kf", "mns"),
            # Inputs: under their first parent, in that parent's layout order; i3 nested under i1
            ("i2", "rev"), ("i1", "k2"), ("i3", "i1"),
            # marketing: local North Star group before the foreign (earlier-band) rev group
            ("mns", "mns"), ("mk", "mns"), ("mk2", "rev"),
        ])

    def test_north_stars_tie_by_label(self):
        ms = graph(metric("b", "north_star", label="Beta"), metric("a", "north_star", label="Alpha"),
                   metric("kb", parents=["b"]), metric("ka", parents=["a"]))
        ordered, _ = layout(ms, DOMAIN_LABELS)
        self.assertEqual([m["metricId"] for m in ordered], ["a", "b", "ka", "kb"])

    def test_numbering_follows_the_layout(self):
        portfolio, _ = build(layout_fixture(), TAXONOMY, {}, {}, {}, {})
        self.assertEqual([m["number"] for m in portfolio["metrics"]], list(range(1, 14)))
        self.assertEqual([m["metricId"] for m in portfolio["metrics"]][:3], ["rev", "fcf", "k2"])


def sym(mid, label, short=None):
    return metric(mid, label=label, short=short or label)


class SymbolTest(unittest.TestCase):
    def test_initials_in_element_case_skipping_stopwords(self):
        ms = [sym("nrr", "Net Revenue Retention"), sym("cpl", "Cost per Lead"), sym("arr", "ARR"),
              sym("billings", "Billings"), sym("ev_ebitda", "Enterprise Value to EBITDA Multiple")]
        self.assertEqual(assign_symbols(ms, {}),
                         {"nrr": "Nrr", "cpl": "Cl", "arr": "Arr", "billings": "Bil", "ev_ebitda": "Eve"})

    def test_collision_takes_more_letters_deterministically(self):
        ms = [sym("nrr", "Net Revenue Retention"), sym("nrr2", "Net Revenue Rate"), sym("nrr3", "Net Revenue Ratio")]
        first = assign_symbols(ms, {})
        self.assertEqual(first, {"nrr": "Nrr", "nrr2": "Nra", "nrr3": "Nre"})
        self.assertEqual(assign_symbols(ms, {}), first)

    def test_override_applied_and_generated_symbols_avoid_it(self):
        ms = [sym("nrr", "Net Revenue Retention"), sym("ebitda", "EBITDA")]
        self.assertEqual(assign_symbols(ms, {"ebitda": "Nrr"}), {"nrr": "Nre", "ebitda": "Nrr"})

    def test_duplicate_override_fails(self):
        with self.assertRaises(ExportError) as e:
            assign_symbols([sym("a", "Alpha"), sym("b", "Beta")], {"a": "Xy", "b": "Xy"})
        self.assertEqual(e.exception.issues, ["symbol 'Xy' is used by a, b"])

    def test_long_or_empty_or_badly_cased_override_fails(self):
        with self.assertRaises(ExportError) as e:
            assign_symbols([sym("a", "Alpha"), sym("b", "Beta"), sym("c", "Gamma")], {"a": "Arrr", "b": "", "c": "ARR"})
        self.assertEqual(e.exception.issues, [
            "data/portfolio_symbols.json: a: symbol 'Arrr' is not 1-3 characters in element case",
            "data/portfolio_symbols.json: b: symbol '' is not 1-3 characters in element case",
            "data/portfolio_symbols.json: c: symbol 'ARR' is not 1-3 characters in element case",
        ])

    def test_unused_override_fails(self):
        with self.assertRaises(ExportError) as e:
            assign_symbols([sym("a", "Alpha")], {"gone": "Gn"})
        self.assertEqual(e.exception.issues, ["data/portfolio_symbols.json: 'gone' is not a kept metric"])


TAXONOMY = {
    "tiers": {"north_star": {"label": "North Star"}, "kpi": {"label": "KPI"}, "input": {"label": "Input"}},
    "domains": {d: {"label": label} for d, label in DOMAIN_LABELS.items()},
    "industries": ["cross_industry", "financial_services", "saas"],
}


class BuildTest(unittest.TestCase):
    def test_portfolio_shape(self):
        ms = graph(metric("ns", "north_star", dimensions=["metric_time"], dataSources=["crm"]),
                   metric("k", parents=["ns"], unit="currency"), metric("gone", parents=["ns"]))
        dims = {"metric_time": {"label": "Time", "desc": "t", "semantic": []}, "unused": {"label": "U", "desc": "u"}}
        srcs = {"crm": {"label": "CRM", "desc": "c", "vendors": []}, "erp": {"label": "ERP", "desc": "e", "vendors": []}}
        p, formulas = build(ms, TAXONOMY, dims, srcs, {"gone": "No data source"}, {"ns": "Ns"}, "abc1234", "2026-09-23T00:00:00Z")
        self.assertEqual(p["meta"], {
            "count": 2, "libraryCount": 3, "domains": [{"id": "finance", "label": "Finance", "count": 2}],
            "tiers": {"north_star": 1, "kpi": 1, "input": 0}, "units": {"currency": 1, "rate": 1},
            "commit": "abc1234", "builtAt": "2026-09-23T00:00:00Z"})
        self.assertEqual(p["industryLabels"],
                         {"cross_industry": "Cross-industry", "financial_services": "Financial services", "saas": "SaaS"})
        self.assertEqual(p["dimensions"], {"metric_time": {"label": "Time", "desc": "t"}})
        self.assertEqual(p["sources"], {"crm": {"label": "CRM", "desc": "c"}})
        first = p["metrics"][0]
        self.assertEqual(list(first), ["number", "metricId", "symbol", "label", "shortLabel", "unit", "domain", "tier",
                                       "industry", "shortDescription", "numerator", "denominator", "dimensions",
                                       "dataSources", "parentMetrics", "childMetrics", "correlatedMetrics",
                                       "formulaInputs", "group"])
        self.assertEqual((first["symbol"], first["childMetrics"], first["group"]), ("Ns", ["k"], "ns"))
        self.assertEqual(formulas, {"finance": {"ns": {"yaml": "yaml ns", "sql": "sql ns"},
                                                "k": {"yaml": "yaml k", "sql": "sql k"}}})

    def test_orphans_stop_the_build(self):
        ms = graph(metric("ns", "north_star"), metric("k", parents=["ns"]))
        with self.assertRaises(ExportError) as e:
            build(ms, TAXONOMY, {}, {}, {"k": "r"}, {})
        self.assertEqual(e.exception.issues, ["ns: north_star has no kept child"])

    def test_industry_label(self):
        self.assertEqual(industry_label("manufacturing"), "Manufacturing")


if __name__ == "__main__":
    unittest.main()
