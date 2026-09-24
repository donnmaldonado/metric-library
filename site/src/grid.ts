import { TIERS, reducedMotion } from './data';
import { createTile } from './tile';
import type { Metric, Portfolio } from './types';

export interface GridView {
  selected: string | null;
  /** Parents and children of the selection: solid ring. */
  direct: Set<string>;
  /** Correlated with the selection: dashed ring. */
  corr: Set<string>;
  /** Ids passing every filter and the search; null when nothing narrows the table. */
  lit: Set<string> | null;
  /** The search cursor (ArrowUp/Down in the search box). */
  current: string | null;
}

export interface GridCallbacks {
  onSelect(id: string): void;
  /** Pointer or keyboard focus entered (id) or left (null) a tile. */
  onHover(id: string | null, anchor?: HTMLElement): void;
}

interface Table {
  domain: string;
  el: HTMLDivElement;
  buttons: HTMLButtonElement[];
}

export class Grid {
  readonly root: HTMLDivElement;
  private readonly buttons = new Map<string, HTMLButtonElement>();
  private readonly tables = new Map<string, Table>();
  private shown: Table | null = null;
  private active: HTMLButtonElement | null = null;
  private hovered: HTMLButtonElement | null = null;

  constructor(
    private readonly p: Portfolio,
    private readonly cb: GridCallbacks,
  ) {
    this.root = document.createElement('div');
    this.root.className = 'grid';
    this.root.setAttribute('role', 'grid');
    this.root.setAttribute('aria-readonly', 'true');
    this.build();
    this.bind();
  }

  /** One table per domain, one row per tier; all are built up front and only the shown one is visible. */
  private build(): void {
    const byDomain = new Map<string, Metric[]>();
    for (const m of this.p.metrics) {
      const list = byDomain.get(m.domain) ?? [];
      list.push(m);
      byDomain.set(m.domain, list);
    }
    for (const d of this.p.meta.domains) {
      const metrics = byDomain.get(d.id);
      if (!metrics) continue;
      const el = document.createElement('div');
      el.className = 'domain-table';
      el.setAttribute('role', 'rowgroup');
      el.dataset.domain = d.id;
      el.hidden = true;
      const table: Table = { domain: d.id, el, buttons: [] };

      for (const tier of TIERS) {
        const inTier = metrics.filter((m) => m.tier === tier);
        if (!inTier.length) continue;
        const row = document.createElement('div');
        row.className = `band band-${tier}`;
        row.setAttribute('role', 'row');
        const header = document.createElement('div');
        header.className = 'band-label';
        header.setAttribute('role', 'rowheader');
        header.textContent = `${this.p.tierLabels[tier]} · ${inTier.length}`;
        const tiles = document.createElement('div');
        tiles.className = 'band-tiles';
        tiles.setAttribute('role', 'none');
        for (const m of inTier) {
          const { cell, button } = createTile(m, this.p);
          tiles.append(cell);
          this.buttons.set(m.metricId, button);
          table.buttons.push(button);
        }
        row.append(header, tiles);
        el.append(row);
      }
      this.root.append(el);
      this.tables.set(d.id, table);
    }
  }

  /** Show one domain's table; the first tile becomes the tab stop. */
  showDomain(domain: string): void {
    const next = this.tables.get(domain);
    if (!next || next === this.shown) return;
    if (this.shown) this.shown.el.hidden = true;
    next.el.hidden = false;
    this.shown = next;
    const label = this.p.domainLabels[domain] ?? domain;
    this.root.setAttribute('aria-label', `${label} metric table, ${next.buttons.length} metrics`);
    if (this.active) this.active.tabIndex = -1;
    this.active = next.buttons[0] ?? null;
    if (this.active) this.active.tabIndex = 0;
  }

  private bind(): void {
    this.root.addEventListener('click', (e) => {
      const b = (e.target as Element).closest<HTMLButtonElement>('button.tile');
      if (!b?.dataset.id) return;
      this.setActive(b, false);
      this.cb.onSelect(b.dataset.id);
    });
    this.root.addEventListener('keydown', (e) => this.onKey(e));
    this.root.addEventListener('pointerover', (e) => {
      if (e.pointerType !== 'mouse') return;
      const b = (e.target as Element).closest<HTMLButtonElement>('button.tile');
      if (!b || b === this.hovered) return;
      this.hovered = b;
      this.cb.onHover(b.dataset.id!, b);
    });
    this.root.addEventListener('pointerout', (e) => {
      if (e.pointerType !== 'mouse' || !this.hovered) return;
      const to = e.relatedTarget as Node | null;
      if (to && this.hovered.contains(to)) return;
      this.hovered = null;
      this.cb.onHover(null);
    });
    this.root.addEventListener('focusin', (e) => {
      const b = (e.target as Element).closest<HTMLButtonElement>('button.tile');
      if (b && b.matches(':focus-visible')) this.cb.onHover(b.dataset.id!, b);
    });
    this.root.addEventListener('focusout', () => {
      if (!this.hovered) this.cb.onHover(null);
    });
  }

  // ---- keyboard: roving tabindex --------------------------------------------------

  private setActive(b: HTMLButtonElement, focus: boolean): void {
    if (this.active && this.active !== b) this.active.tabIndex = -1;
    this.active = b;
    b.tabIndex = 0;
    if (focus) b.focus();
  }

  private onKey(e: KeyboardEvent): void {
    const cur = (e.target as Element).closest<HTMLButtonElement>('button.tile');
    if (!cur || e.altKey || e.metaKey) return;
    const list = this.shown?.buttons ?? [];
    const i = list.indexOf(cur);
    if (i < 0) return;
    let next: HTMLButtonElement | undefined;
    switch (e.key) {
      case 'ArrowRight':
        next = list[i + 1];
        break;
      case 'ArrowLeft':
        next = list[i - 1];
        break;
      case 'ArrowDown':
      case 'ArrowUp':
        next = this.vertical(list, cur, e.key === 'ArrowDown' ? 1 : -1);
        break;
      case 'Home':
        next = e.ctrlKey ? list[0] : this.lineOf(list, cur)[0];
        break;
      case 'End': {
        const line = e.ctrlKey ? list : this.lineOf(list, cur);
        next = line[line.length - 1];
        break;
      }
      default:
        return;
    }
    e.preventDefault();
    if (next) this.setActive(next, true);
  }

  /** Tiles on the same visual line as `cur`, from their rendered positions. */
  private lineOf(list: HTMLButtonElement[], cur: HTMLButtonElement): HTMLButtonElement[] {
    const top = cur.getBoundingClientRect().top;
    return list.filter((b) => Math.abs(b.getBoundingClientRect().top - top) < 3);
  }

  /** The tile on the next/previous visual line whose centre is closest horizontally. */
  private vertical(list: HTMLButtonElement[], cur: HTMLButtonElement, dir: 1 | -1): HTMLButtonElement | undefined {
    const rects = list.map((b) => b.getBoundingClientRect());
    const cr = cur.getBoundingClientRect();
    const cx = cr.left + cr.width / 2;
    let lineTop: number | null = null;
    for (const r of rects) {
      const d = (r.top - cr.top) * dir;
      if (d > 3 && (lineTop === null || (r.top - lineTop) * dir < 0)) lineTop = r.top;
    }
    if (lineTop === null) return undefined;
    let best: HTMLButtonElement | undefined;
    let bestDist = Infinity;
    rects.forEach((r, j) => {
      if (Math.abs(r.top - lineTop!) >= 3) return;
      const dist = Math.abs(r.left + r.width / 2 - cx);
      if (dist < bestDist) {
        bestDist = dist;
        best = list[j];
      }
    });
    return best;
  }

  // ---- view -----------------------------------------------------------------------

  apply(v: GridView): void {
    this.root.classList.toggle('has-selection', !!v.selected);
    for (const [id, b] of this.buttons) {
      const selected = id === v.selected;
      const direct = !selected && v.direct.has(id);
      const corr = !selected && !direct && v.corr.has(id);
      const dim = !!v.selected && !selected && !direct && !corr;
      const filtered = !selected && v.lit !== null && !v.lit.has(id);
      b.classList.toggle('is-selected', selected);
      b.classList.toggle('rel-direct', direct);
      b.classList.toggle('rel-corr', corr);
      b.classList.toggle('is-dim', dim && !filtered);
      b.classList.toggle('is-filtered', filtered);
      b.classList.toggle('is-current', id === v.current);
      if (dim || filtered) b.setAttribute('aria-disabled', 'true');
      else b.removeAttribute('aria-disabled');
      (b.parentElement as HTMLElement).setAttribute('aria-selected', String(selected));
      if (selected) b.setAttribute('aria-current', 'true');
      else b.removeAttribute('aria-current');
    }
    if (v.selected) {
      const b = this.buttons.get(v.selected);
      if (b) this.setActive(b, false);
    }
  }

  /** Rings on the hovered tile's parents and children (null clears). */
  setHoverRing(ids: Set<string> | null): void {
    for (const [id, b] of this.buttons) b.classList.toggle('rel-hover', !!ids?.has(id));
  }

  scrollTo(id: string, smooth = true): void {
    const b = this.buttons.get(id);
    if (!b) return;
    b.scrollIntoView({ block: 'center', inline: 'nearest', behavior: smooth && !reducedMotion() ? 'smooth' : 'instant' });
  }

  focusTile(id: string): void {
    const b = this.buttons.get(id);
    if (b) this.setActive(b, true);
  }

  tile(id: string): HTMLButtonElement | undefined {
    return this.buttons.get(id);
  }
}
