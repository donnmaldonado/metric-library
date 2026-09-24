import './styles.css';
import { familyOf, indexMetrics, loadPortfolio, reducedMotion } from './data';
import { DetailPanel } from './detailPanel';
import { DomainTabs } from './domainTabs';
import { Grid, type GridView } from './grid';
import { HoverCard } from './hoverCard';
import { Legend } from './legend';
import { Search, matchesQuery } from './search';
import { type State, Store, readUrl } from './state';
import type { Metric, Portfolio } from './types';

const REPO = 'https://github.com/donnmaldonado/metric-library';
const PORTFOLIO = 'https://donnmaldonado.github.io/';

// ---- header / footer ------------------------------------------------------------------

function fillChrome(p: Portfolio): void {
  const lead = document.getElementById('lead')!;
  lead.textContent = `${p.meta.count} business metrics across ${p.meta.domains.length} domains, each defined, tiered and wired into a driver tree`;
  document.title = `Metric Periodic Table · ${p.meta.count} business metrics`;

  const build = document.getElementById('build')!;
  build.replaceChildren();
  const date = p.meta.builtAt ? new Date(p.meta.builtAt) : null;
  const when =
    date && !Number.isNaN(date.valueOf())
      ? date.toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric', timeZone: 'UTC' })
      : '';
  if (p.meta.commit) {
    build.append('Built from ');
    const a = document.createElement('a');
    a.href = `${REPO}/commit/${p.meta.commit}`;
    const code = document.createElement('code');
    code.textContent = p.meta.commit;
    a.append(code);
    build.append(a);
    if (when) build.append(` on ${when}`);
  } else if (when) {
    build.append(`Built on ${when}`);
  }
  (document.getElementById('repo-link') as HTMLAnchorElement).href = REPO;
  (document.getElementById('portfolio-link') as HTMLAnchorElement).href = PORTFOLIO;
}

// ---- app ------------------------------------------------------------------------------

function start(p: Portfolio): void {
  const byId = indexMetrics(p.metrics);
  const known = {
    domainOf: new Map(p.metrics.map((m) => [m.metricId, m.domain])),
    domains: p.meta.domains.map((d) => d.id),
    sources: new Set(Object.keys(p.sources)),
  };
  const store = new Store(readUrl(known), known);
  const totals = new Map(p.meta.domains.map((d) => [d.id, d.count]));
  fillChrome(p);

  /** Ids passing every filter and the search, or null when nothing narrows the table. */
  const litFor = (s: State): Set<string> | null => {
    const q = s.q.trim();
    if (!q && !s.u.size && !s.t.size && !s.s.size) return null;
    const lit = new Set<string>();
    for (const m of p.metrics) if (passes(m, s, q)) lit.add(m.metricId);
    return lit;
  };
  const passes = (m: Metric, s: State, q: string): boolean =>
    (!s.u.size || s.u.has(familyOf(m.unit))) &&
    (!s.t.size || s.t.has(m.tier)) &&
    (!s.s.size || m.dataSources.every((src) => s.s.has(src))) &&
    matchesQuery(m, q);

  let cursor: string | null = null;
  let lit = litFor(store.state);

  /** Selecting a metric from another domain (a panel relationship) switches to its table. */
  const select = (id: string, opts: { scroll?: boolean; fromPanel?: boolean } = {}): void => {
    if (store.state.m !== id) store.update({ m: id, d: byId.get(id)!.domain }, 'push');
    if (opts.scroll) grid.scrollTo(id);
    if (opts.fromPanel) panel.focusHeading();
  };
  const closePanel = (): void => {
    if (store.state.m) store.update({ m: null }, 'push');
  };

  const wrap = document.getElementById('table')!;
  const hover = new HoverCard(p, byId, (ids) => grid.setHoverRing(ids));
  const grid = new Grid(p, {
    onSelect: (id) => {
      hover.hide();
      select(id);
    },
    onHover: (id, anchor) => hover.schedule(id, anchor),
  });
  const panel = new DetailPanel(
    p,
    byId,
    (id) => select(id, { scroll: true, fromPanel: true }),
    () => {
      const was = store.state.m;
      closePanel();
      if (was) grid.focusTile(was);
    },
  );
  const tabs = new DomainTabs(p, 'table', (d) => {
    if (d === store.state.d) return;
    hover.hide();
    const m = store.state.m;
    // A selection belongs to its own domain: leaving that domain drops it.
    store.update({ d, m: m && byId.get(m)!.domain === d ? m : null }, 'push');
  });
  const legend = new Legend(p, store);
  const search = new Search({
    store,
    count: p.meta.count,
    // Only the shown domain's matches; the tab badges count the rest.
    matches: () =>
      store.state.q.trim() && lit
        ? p.metrics.filter((m) => m.domain === store.state.d && lit!.has(m.metricId)).map((m) => m.metricId)
        : [],
    elsewhere: () =>
      store.state.q.trim() && lit ? [...lit].filter((id) => byId.get(id)!.domain !== store.state.d).length : 0,
    onSelect: (id) => select(id, { scroll: true }),
    onCursor: (id) => {
      if (id === cursor) return;
      cursor = id;
      render();
      if (id) grid.tile(id)?.scrollIntoView({ block: 'nearest', behavior: reducedMotion() ? 'instant' : 'smooth' });
    },
  });

  document.getElementById('tabs-slot')!.replaceWith(tabs.el);
  document.getElementById('search-slot')!.replaceWith(search.el);
  document.getElementById('legend-slot')!.replaceWith(legend.el);
  wrap.replaceChildren(grid.root);
  wrap.removeAttribute('aria-busy');
  wrap.setAttribute('role', 'tabpanel');
  document.getElementById('layout')!.append(panel.el);
  const scrim = document.getElementById('scrim')!;
  scrim.addEventListener('click', closePanel);

  const view = (): GridView => {
    const s = store.state;
    const m = s.m ? byId.get(s.m) : undefined;
    return {
      selected: m?.metricId ?? null,
      direct: new Set(m ? [...m.parentMetrics, ...m.childMetrics] : []),
      corr: new Set(m?.correlatedMetrics ?? []),
      lit,
      current: cursor,
    };
  };

  function render(): void {
    const s = store.state;
    grid.showDomain(s.d);
    wrap.setAttribute('aria-labelledby', `tab-${s.d}`);
    let counts: Map<string, number> | null = null;
    if (lit) {
      counts = new Map();
      for (const id of lit) {
        const d = byId.get(id)!.domain;
        counts.set(d, (counts.get(d) ?? 0) + 1);
      }
    }
    tabs.sync(s.d, counts, totals);
    grid.apply(view());
    alignLegend();
  }

  // The legend spans the full column grid (not just the tiles a domain happens to have),
  // so it sits the same in every domain: rate swatch at the first column, data sources at the last.
  function alignLegend(): void {
    const tiles = grid.root.querySelector('.domain-table:not([hidden]) .band-tiles');
    if (!tiles) return;
    const r = tiles.getBoundingClientRect();
    legend.alignTo(r.left, r.right);
  }
  new ResizeObserver(alignLegend).observe(wrap);

  store.subscribe((s, prev, mode) => {
    if (s.q !== prev.q || s.u !== prev.u || s.t !== prev.t || s.s !== prev.s) lit = litFor(s);
    const m = s.m ? byId.get(s.m) : undefined;
    if (m) panel.open(m);
    else panel.close();
    document.body.classList.toggle('panel-open', !!m);
    render();
    // Back/forward: bring the restored selection into view.
    if (m && mode === 'none' && m.metricId !== prev.m) {
      const b = grid.tile(m.metricId);
      if (b) {
        const r = b.getBoundingClientRect();
        if (r.bottom < 0 || r.top > innerHeight) grid.scrollTo(m.metricId);
      }
    }
  });

  // Initial state from the URL.
  const init = store.state;
  const m0 = init.m ? byId.get(init.m) : undefined;
  if (m0) {
    panel.open(m0);
    document.body.classList.add('panel-open');
  }
  render();
  if (m0) requestAnimationFrame(() => grid.scrollTo(m0.metricId, false));

  // Global keys: `/` and ⌘K/Ctrl+K focus search; Esc closes the panel.
  document.addEventListener('keydown', (e) => {
    const target = e.target as HTMLElement;
    const typing = target.closest('input, textarea, select, [contenteditable="true"]');
    if ((e.key === 'k' || e.key === 'K') && (e.metaKey || e.ctrlKey) && !e.altKey) {
      e.preventDefault();
      search.focus();
    } else if (e.key === '/' && !typing && !e.metaKey && !e.ctrlKey && !e.altKey) {
      e.preventDefault();
      search.focus();
    } else if (e.key === 'Escape') {
      if (legend.closePopover()) return;
      if (hover.visible) hover.hide();
      if (store.state.m) {
        const was = store.state.m;
        const inPanel = !!target.closest('.panel');
        closePanel();
        if (inPanel) grid.focusTile(was);
      }
    }
  });
  window.addEventListener('scroll', () => hover.hide(), { passive: true });
  wrap.addEventListener('scroll', () => hover.hide(), { passive: true });
}

// ---- boot -----------------------------------------------------------------------------

loadPortfolio().then(start, (err: unknown) => {
  const wrap = document.getElementById('table')!;
  wrap.removeAttribute('aria-busy');
  const msg = document.createElement('p');
  msg.className = 'load-error';
  msg.textContent = `Could not load the metrics (${err instanceof Error ? err.message : String(err)}).`;
  wrap.replaceChildren(msg);
});
