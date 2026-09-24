import { reducedMotion } from './data';
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

interface Band {
  domain: string;
  row: HTMLDivElement;
  cells: HTMLDivElement[];
  toggle: HTMLButtonElement;
  more: HTMLSpanElement;
  expanded: boolean;
}

const mobileQuery = matchMedia('(max-width: 767px)');

export class Grid {
  readonly root: HTMLDivElement;
  private readonly buttons = new Map<string, HTMLButtonElement>();
  private readonly order: HTMLButtonElement[] = [];
  private readonly bands: Band[] = [];
  private active: HTMLButtonElement | null = null;
  private hovered: HTMLButtonElement | null = null;

  constructor(
    private readonly p: Portfolio,
    private readonly cb: GridCallbacks,
  ) {
    this.root = document.createElement('div');
    this.root.className = 'grid';
    this.root.setAttribute('role', 'grid');
    this.root.setAttribute('aria-label', `Metric periodic table, ${p.meta.count} metrics in ${p.meta.domains.length} domain bands`);
    this.root.setAttribute('aria-readonly', 'true');
    this.build();
    this.bind();
  }

  private build(): void {
    const byDomain = new Map<string, Metric[]>();
    for (const m of this.p.metrics) {
      const list = byDomain.get(m.domain) ?? [];
      list.push(m);
      byDomain.set(m.domain, list);
    }
    const domains = this.p.meta.domains.filter((d) => byDomain.has(d.id));
    for (const d of domains) {
      const metrics = byDomain.get(d.id)!;
      const row = document.createElement('div');
      row.className = 'band';
      row.setAttribute('role', 'row');
      row.dataset.domain = d.id;

      const header = document.createElement('div');
      header.className = 'band-label';
      header.setAttribute('role', 'rowheader');
      const title = document.createElement('span');
      title.className = 'band-title';
      title.textContent = `${d.label} · ${d.count}`;
      const tilesId = `band-${d.id}`;
      const toggle = document.createElement('button');
      toggle.type = 'button';
      toggle.className = 'band-toggle';
      toggle.setAttribute('aria-controls', tilesId);
      toggle.setAttribute('aria-expanded', 'false');
      const tName = document.createElement('span');
      tName.textContent = `${d.label} · ${d.count}`;
      const more = document.createElement('span');
      more.className = 'band-more';
      toggle.append(tName, more);
      header.append(title, toggle);

      const tiles = document.createElement('div');
      tiles.className = 'band-tiles';
      tiles.id = tilesId;
      tiles.setAttribute('role', 'none');

      const band: Band = { domain: d.id, row, cells: [], toggle, more, expanded: false };
      let prevTier: string | null = null;
      for (const m of metrics) {
        if (prevTier !== null && m.tier !== prevTier) {
          const gap = document.createElement('div');
          gap.className = 'cell cell-gap';
          gap.setAttribute('aria-hidden', 'true');
          tiles.append(gap);
          band.cells.push(gap);
        }
        prevTier = m.tier;
        const { cell, button } = createTile(m, this.p);
        tiles.append(cell);
        band.cells.push(cell);
        this.buttons.set(m.metricId, button);
        this.order.push(button);
      }
      toggle.addEventListener('click', () => {
        band.expanded = !band.expanded;
        this.layoutCollapse();
      });
      row.append(header, tiles);
      this.root.append(row);
      this.bands.push(band);
    }
    this.active = this.order[0] ?? null;
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
    mobileQuery.addEventListener('change', () => this.layoutCollapse());
    let raf = 0;
    new ResizeObserver(() => {
      cancelAnimationFrame(raf);
      raf = requestAnimationFrame(() => this.layoutCollapse());
    }).observe(this.root);
  }

  // ---- collapsed bands (< 768 px) -------------------------------------------------

  /** Below 768 px a collapsed band shows only its first line; measured from the DOM so it follows wrapping. */
  layoutCollapse(): void {
    const mobile = mobileQuery.matches;
    for (const band of this.bands) {
      for (const c of band.cells) c.hidden = false;
      const collapsed = mobile && !band.expanded;
      band.row.classList.toggle('is-collapsed', collapsed);
      band.toggle.setAttribute('aria-expanded', String(!collapsed));
      if (!mobile) continue;
      if (!collapsed) {
        band.more.textContent = 'Show fewer';
        continue;
      }
      const first = band.cells[0];
      const top = first ? first.offsetTop : 0;
      let hidden = 0;
      for (const c of band.cells) {
        if (c.offsetTop > top + 2) {
          c.hidden = true;
          if (!c.classList.contains('cell-gap')) hidden++;
        }
      }
      band.more.textContent = hidden ? `+${hidden} more` : '';
    }
    if (this.active && this.isHidden(this.active)) {
      this.active.tabIndex = -1;
      this.active = this.visible()[0] ?? null;
      if (this.active) this.active.tabIndex = 0;
    }
  }

  private isHidden(b: HTMLButtonElement): boolean {
    return (b.parentElement as HTMLElement).hidden === true;
  }

  private visible(): HTMLButtonElement[] {
    return this.order.filter((b) => !this.isHidden(b));
  }

  /** Expand the band holding this metric if it is clipped. */
  private reveal(id: string): HTMLButtonElement | undefined {
    const b = this.buttons.get(id);
    if (b && this.isHidden(b)) {
      const band = this.bands.find((x) => x.row.contains(b));
      if (band) {
        band.expanded = true;
        this.layoutCollapse();
      }
    }
    return b;
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
    const list = this.visible();
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
    const b = this.reveal(id);
    if (!b) return;
    b.scrollIntoView({ block: 'center', inline: 'nearest', behavior: smooth && !reducedMotion() ? 'smooth' : 'instant' });
  }

  focusTile(id: string): void {
    const b = this.reveal(id);
    if (b) this.setActive(b, true);
  }

  tile(id: string): HTMLButtonElement | undefined {
    return this.buttons.get(id);
  }
}
