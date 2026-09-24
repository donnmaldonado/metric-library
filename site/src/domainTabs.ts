import type { Portfolio } from './types';

/** The domain switcher: one tab per domain. Arrow keys, Home and End move between tabs. */
export class DomainTabs {
  readonly el: HTMLDivElement;
  private readonly tabs = new Map<string, HTMLButtonElement>();
  private readonly badges = new Map<string, HTMLSpanElement>();

  constructor(
    p: Portfolio,
    panelId: string,
    private readonly onPick: (domain: string) => void,
  ) {
    this.el = document.createElement('div');
    this.el.className = 'domain-tabs';
    this.el.setAttribute('role', 'tablist');
    this.el.setAttribute('aria-label', 'Domain');
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
      this.el.append(b);
    }
    this.el.addEventListener('keydown', (e) => this.onKey(e));
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
    }
    const cur = this.tabs.get(domain);
    // Keep the shown tab in view when the bar scrolls sideways on narrow screens.
    // Scrolls the bar only, never the page.
    if (cur) {
      const left = cur.offsetLeft; // the bar is position: relative, so it is the offsetParent
      const right = left + cur.offsetWidth;
      if (left < this.el.scrollLeft) this.el.scrollLeft = left;
      else if (right > this.el.scrollLeft + this.el.clientWidth) this.el.scrollLeft = right - this.el.clientWidth;
    }
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
