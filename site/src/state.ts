import { FAMILIES, TIERS } from './data';
import type { Family, Tier } from './types';

/** Everything the page shows is a function of this state, and all of it lives in the URL. */
export interface State {
  /** Domain whose table is shown (`?d=`); omitted from the URL for the first domain. */
  d: string;
  /** Selected metricId (`?m=`). */
  m: string | null;
  /** Search query (`?q=`). */
  q: string;
  /** Active unit-family filter (`?u=`); empty = no filter. */
  u: Set<Family>;
  /** Active tier filter (`?t=`); empty = no filter. */
  t: Set<Tier>;
  /** Chosen data sources (`?s=`); empty = no filter. */
  s: Set<string>;
}

export type HistoryMode = 'push' | 'replace' | 'none';

interface Known {
  /** metricId → domain. */
  domainOf: Map<string, string>;
  /** Domain ids in tab order; the first is the default. */
  domains: string[];
  sources: Set<string>;
}

function list(params: URLSearchParams, key: string): string[] {
  return (params.get(key) ?? '')
    .split(',')
    .map((v) => v.trim())
    .filter(Boolean);
}

export function readUrl(known: Known, search = location.search): State {
  const p = new URLSearchParams(search);
  const m = p.get('m');
  const selected = m && known.domainOf.has(m) ? m : null;
  const d = p.get('d');
  return {
    // A selection always shows its own domain's table.
    d: selected ? known.domainOf.get(selected)! : d && known.domains.includes(d) ? d : known.domains[0],
    m: selected,
    q: p.get('q') ?? '',
    u: new Set(list(p, 'u').filter((v): v is Family => (FAMILIES as string[]).includes(v))),
    t: new Set(list(p, 't').filter((v): v is Tier => (TIERS as string[]).includes(v))),
    s: new Set(list(p, 's').filter((v) => known.sources.has(v))),
  };
}

/** Serialise in a fixed order so equal states give equal URLs. */
export function toSearch(state: State, defaultDomain: string): string {
  const p = new URLSearchParams();
  if (state.d !== defaultDomain) p.set('d', state.d);
  if (state.m) p.set('m', state.m);
  if (state.q) p.set('q', state.q);
  if (state.u.size) p.set('u', FAMILIES.filter((f) => state.u.has(f)).join(','));
  if (state.t.size) p.set('t', TIERS.filter((t) => state.t.has(t)).join(','));
  if (state.s.size) p.set('s', [...state.s].sort().join(','));
  // Keep commas readable in shared links.
  const s = p.toString().replace(/%2C/g, ',');
  return s ? `?${s}` : '';
}

export class Store {
  private listeners: Array<(s: State, prev: State, mode: HistoryMode) => void> = [];

  constructor(
    public state: State,
    private readonly known: Known,
  ) {
    window.addEventListener('popstate', () => {
      this.set(readUrl(this.known), 'none');
    });
  }

  /** `mode` is 'none' when the change came from back/forward (popstate). */
  subscribe(fn: (s: State, prev: State, mode: HistoryMode) => void): void {
    this.listeners.push(fn);
  }

  /** Merge a patch, mirror it to the URL and notify. Selection changes push history; filters replace. */
  update(patch: Partial<State>, mode: HistoryMode): void {
    this.set({ ...this.state, ...patch }, mode);
  }

  private set(next: State, mode: HistoryMode): void {
    const prev = this.state;
    this.state = next;
    if (mode !== 'none') {
      const url = `${location.pathname}${toSearch(next, this.known.domains[0])}${location.hash}`;
      if (url !== `${location.pathname}${location.search}${location.hash}`) {
        if (mode === 'push') history.pushState(null, '', url);
        else history.replaceState(null, '', url);
      }
    }
    for (const fn of this.listeners) fn(next, prev, mode);
  }
}
