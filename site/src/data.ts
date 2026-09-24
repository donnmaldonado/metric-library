import type { DomainFormulas, Family, Metric, Portfolio, Tier } from './types';

const BASE = import.meta.env.BASE_URL;

export const FAMILIES: Family[] = ['rate', 'currency', 'count', 'duration', 'ratio', 'score'];
export const TIERS: Tier[] = ['north_star', 'kpi', 'input'];

export const FAMILY_LABEL: Record<Family, string> = {
  rate: 'Rate',
  currency: 'Currency',
  count: 'Count',
  duration: 'Duration',
  ratio: 'Ratio',
  score: 'Score',
};

export const GLYPH: Record<Family, string> = {
  rate: '%',
  currency: '$',
  count: '#',
  duration: '⏱\uFE0E',
  ratio: '×',
  score: '★',
};

const DURATION_UNITS = new Set(['days', 'hours', 'months', 'years', 'minutes', 'seconds', 'milliseconds']);

export function familyOf(unit: string): Family {
  if (DURATION_UNITS.has(unit)) return 'duration';
  return (FAMILIES as string[]).includes(unit) ? (unit as Family) : 'count';
}

export async function loadPortfolio(): Promise<Portfolio> {
  const res = await fetch(`${BASE}data/metrics.portfolio.json`);
  if (!res.ok) throw new Error(`metrics.portfolio.json: HTTP ${res.status}`);
  return (await res.json()) as Portfolio;
}

const formulaCache = new Map<string, Promise<DomainFormulas>>();

/** Fetched lazily, once per domain; failed loads are evicted so a retry can succeed. */
export function loadFormulas(domain: string): Promise<DomainFormulas> {
  let p = formulaCache.get(domain);
  if (!p) {
    p = fetch(`${BASE}data/formulas/${encodeURIComponent(domain)}.json`).then((res) => {
      if (!res.ok) throw new Error(`formulas/${domain}.json: HTTP ${res.status}`);
      return res.json() as Promise<DomainFormulas>;
    });
    p.catch(() => formulaCache.delete(domain));
    formulaCache.set(domain, p);
  }
  return p;
}

/** Index the metrics once so every lookup by id is O(1). */
export function indexMetrics(metrics: Metric[]): Map<string, Metric> {
  return new Map(metrics.map((m) => [m.metricId, m]));
}

export const reducedMotion = (): boolean => matchMedia('(prefers-reduced-motion: reduce)').matches;
export const canHover = (): boolean => matchMedia('(hover: hover) and (pointer: fine)').matches;
