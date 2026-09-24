import { FAMILIES, FAMILY_LABEL, GLYPH, familyOf } from './data';
import type { State, Store } from './state';
import type { Family, Portfolio } from './types';

function toggled<T>(set: Set<T>, v: T): Set<T> {
  const next = new Set(set);
  if (next.has(v)) next.delete(v);
  else next.add(v);
  return next;
}

/** The legend doubles as the filter bar: unit families and data sources. */
export class Legend {
  readonly el: HTMLDivElement;
  private readonly unitBtns = new Map<Family, HTMLButtonElement>();
  private readonly sourceBoxes = new Map<string, HTMLInputElement>();
  private readonly details: HTMLDetailsElement;
  private readonly summaryCount: HTMLSpanElement;
  private readonly clear: HTMLButtonElement;

  constructor(
    p: Portfolio,
    private readonly store: Store,
  ) {
    this.el = document.createElement('div');
    this.el.className = 'legend';

    const famCount = new Map<Family, number>();
    for (const m of p.metrics) famCount.set(familyOf(m.unit), (famCount.get(familyOf(m.unit)) ?? 0) + 1);

    const units = this.group('Unit');
    for (const f of FAMILIES) {
      const b = this.button(`legend-unit fam-${f}`, `${FAMILY_LABEL[f]} (${famCount.get(f) ?? 0} metrics)`);
      const sw = document.createElement('span');
      sw.className = 'swatch';
      sw.setAttribute('aria-hidden', 'true');
      sw.textContent = GLYPH[f];
      b.append(sw, document.createTextNode(FAMILY_LABEL[f]));
      b.addEventListener('click', () => this.store.update({ u: toggled(this.store.state.u, f) }, 'replace'));
      this.unitBtns.set(f, b);
      units.append(b);
    }

    // Data sources: light only metrics whose sources are all among the chosen ones.
    this.details = document.createElement('details');
    this.details.className = 'sources';
    const summary = document.createElement('summary');
    summary.textContent = 'Data sources';
    this.summaryCount = document.createElement('span');
    this.summaryCount.className = 'count-badge';
    summary.append(this.summaryCount);
    const pop = document.createElement('div');
    pop.className = 'sources-pop';
    const hint = document.createElement('p');
    hint.className = 'sources-hint';
    hint.textContent = 'Light the metrics you can build with only these sources.';
    const fs = document.createElement('fieldset');
    const legend = document.createElement('legend');
    legend.className = 'visually-hidden';
    legend.textContent = 'Data sources';
    fs.append(legend);
    const ids = Object.keys(p.sources).sort((a, b) => p.sources[a].label.localeCompare(p.sources[b].label));
    for (const id of ids) {
      const label = document.createElement('label');
      label.title = p.sources[id].desc;
      const box = document.createElement('input');
      box.type = 'checkbox';
      box.value = id;
      box.addEventListener('change', () => {
        const s = new Set(this.store.state.s);
        if (box.checked) s.add(id);
        else s.delete(id);
        this.store.update({ s }, 'replace');
      });
      this.sourceBoxes.set(id, box);
      label.append(box, document.createTextNode(p.sources[id].label));
      fs.append(label);
    }
    const reset = this.button('link-btn', 'Clear data sources');
    reset.textContent = 'Clear';
    reset.addEventListener('click', () => this.store.update({ s: new Set() }, 'replace'));
    pop.append(hint, fs, reset);
    this.details.append(summary, pop);
    document.addEventListener('click', (e) => {
      if (this.details.open && !this.details.contains(e.target as Node)) this.details.open = false;
    });

    this.clear = this.button('link-btn clear-filters', 'Clear all filters');
    this.clear.textContent = 'Clear filters';
    this.clear.addEventListener('click', () =>
      this.store.update({ u: new Set(), t: new Set(), s: new Set(), q: '' }, 'replace'),
    );

    this.el.append(units, this.clear, this.details);
    this.sync(store.state);
    store.subscribe((s) => this.sync(s));
  }

  /** Closes the sources popover; returns true if it was open. */
  closePopover(): boolean {
    if (!this.details.open) return false;
    this.details.open = false;
    this.details.querySelector('summary')?.focus();
    return true;
  }

  /**
   * Spans the legend so the first unit swatch starts at page x `left` (never outdents)
   * and the data sources button ends at page x `right`.
   */
  alignTo(left: number, right: number): void {
    const swatch = this.el.querySelector('.swatch');
    if (!swatch) return;
    // Phones lay the legend out full width in CSS.
    if (matchMedia('(max-width: 767.98px)').matches) {
      this.el.style.paddingLeft = this.el.style.width = '';
      return;
    }
    const current = parseFloat(this.el.style.paddingLeft) || 0;
    const pad = Math.max(0, current + left - swatch.getBoundingClientRect().left);
    this.el.style.paddingLeft = `${Math.round(pad)}px`;
    this.el.style.width = `${Math.round(right - this.el.getBoundingClientRect().left)}px`;
  }

  private group(title: string): HTMLDivElement {
    const g = document.createElement('div');
    g.className = 'legend-group';
    g.setAttribute('role', 'group');
    g.setAttribute('aria-label', `Filter by ${title.toLowerCase()}`);
    const h = document.createElement('span');
    h.className = 'legend-h';
    h.textContent = title;
    h.setAttribute('aria-hidden', 'true');
    g.append(h);
    return g;
  }

  private button(cls: string, aria: string): HTMLButtonElement {
    const b = document.createElement('button');
    b.type = 'button';
    b.className = cls;
    b.setAttribute('aria-label', aria);
    return b;
  }

  private sync(s: State): void {
    for (const [f, b] of this.unitBtns) b.setAttribute('aria-pressed', String(s.u.has(f)));
    for (const [id, box] of this.sourceBoxes) box.checked = s.s.has(id);
    this.summaryCount.textContent = s.s.size ? String(s.s.size) : '';
    this.el.classList.toggle('any-unit', s.u.size > 0);
    this.clear.hidden = !(s.u.size || s.t.size || s.s.size || s.q);
  }
}
