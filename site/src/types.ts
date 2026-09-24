// Mirrors CONTRACT.md: the JSON written by scripts/export_portfolio.py.

export type Tier = 'north_star' | 'kpi' | 'input';
export type Family = 'rate' | 'currency' | 'count' | 'duration' | 'ratio' | 'score';

export interface DomainMeta {
  id: string;
  label: string;
  count: number;
}

export interface Meta {
  count: number;
  libraryCount: number;
  domains: DomainMeta[];
  tiers: Record<Tier, number>;
  units: Record<string, number>;
  commit: string;
  builtAt: string;
}

export interface LabelDesc {
  label: string;
  desc: string;
}

export interface Metric {
  number: number;
  metricId: string;
  symbol: string;
  label: string;
  shortLabel: string;
  unit: string;
  domain: string;
  tier: Tier;
  industry: string;
  shortDescription: string;
  numerator: string;
  denominator: string;
  dimensions: string[];
  dataSources: string[];
  parentMetrics: string[];
  childMetrics: string[];
  correlatedMetrics: string[];
  formulaInputs: string[];
  group: string;
}

export interface Portfolio {
  meta: Meta;
  tierLabels: Record<Tier, string>;
  domainLabels: Record<string, string>;
  industryLabels: Record<string, string>;
  dimensions: Record<string, LabelDesc>;
  sources: Record<string, LabelDesc>;
  metrics: Metric[];
}

/** formulas/<domain>.json after highlighting: HTML strings (`<pre class="shiki">…`). */
export type DomainFormulas = Record<string, { yaml: string; sql: string }>;
