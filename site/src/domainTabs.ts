import type { Portfolio } from './types';

/**
 * The domain switcher: one tab per domain, and a native dropdown that stands in for the tabs on
 * phones (CSS shows one or the other). Arrow keys, Home and End move between tabs.
 */
export class DomainTabs {
  readonly el: HTMLDivElement;
  private readonly list: HTMLDivElement;
  private readonly select: HTMLSelectElement;
  private readonly tabs = new Map<string, HTMLButtonElement>();
  private readonly badges = new Map<string, HTMLSpanElement>();
  private readonly options = new Map<string, HTMLOptionElement>();
  private readonly labels = new Map<string, string>();

  constructor(
    p: Portfolio,
    panelId: string,
    private readonly onPick: (domain: string) => void,
  ) {
    this.el = document.createElement('div');
    this.el.className = 'domain-nav';
    this.list = document.createElement('div');
    this.list.className = 'domain-tabs';
    this.list.setAttribute('role', 'tablist');
    this.list.setAttribute('aria-label', 'Domain');
    this.select = document.createElement('select');
    this.select.className = 'domain-select';
    this.select.setAttribute('aria-label', 'Domain');
    this.select.setAttribute('aria-controls', panelId);
    this.select.addEventListener('change', () => this.onPick(this.select.value));
    for (const d of p.meta.domains) {
      const b = document.createElement('button');
      b.type = 'button';
      b.className = 'domain-tab';
      b.id = `tab-${d.id}`;
      b.setAttribute('role', 'tab');
      b.setAttribute('aria-controls', panelId);
      const name = document.createElement('span');
      name.textContent = d.label;
      const badge = document.createElement('span');
      badge.className = 'tab-count';
      badge.textContent = String(d.count);
      b.append(name, badge);
      b.addEventListener('click', () => this.onPick(d.id));
      this.tabs.set(d.id, b);
      this.badges.set(d.id, badge);
      this.list.append(b);
      const o = document.createElement('option');
      o.value = d.id;
      this.options.set(d.id, o);
      this.labels.set(d.id, d.label);
      this.select.append(o);
    }
    this.list.addEventListener('keydown', (e) => this.onKey(e));
    this.el.append(this.list, this.select);
  }

  /** Mark the shown domain; `counts` are the lit metrics per domain, or null when nothing narrows the table. */
  sync(domain: string, counts: Map<string, number> | null, totals: Map<string, number>): void {
    for (const [id, b] of this.tabs) {
      const on = id === domain;
      b.setAttribute('aria-selected', String(on));
      b.tabIndex = on ? 0 : -1;
      const n = counts ? (counts.get(id) ?? 0) : totals.get(id)!;
      this.badges.get(id)!.textContent = String(n);
      b.classList.toggle('is-empty', !!counts && n === 0);
      this.options.get(id)!.textContent = `${this.labels.get(id)} (${n})`;
    }
    this.select.value = domain;
  }

  private onKey(e: KeyboardEvent): void {
    const list = [...this.tabs.values()];
    const i = list.indexOf(e.target as HTMLButtonElement);
    if (i < 0) return;
    let j: number;
    if (e.key === 'ArrowRight') j = (i + 1) % list.length;
    else if (e.key === 'ArrowLeft') j = (i - 1 + list.length) % list.length;
    else if (e.key === 'Home') j = 0;
    else if (e.key === 'End') j = list.length - 1;
    else return;
    e.preventDefault();
    list[j].focus();
    this.onPick(list[j].id.slice('tab-'.length));
  }
}
