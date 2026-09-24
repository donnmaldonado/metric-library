import type { Store } from './state';
import type { Metric } from './types';

export function matchesQuery(m: Metric, q: string): boolean {
  const needle = q.trim().toLowerCase();
  if (!needle) return true;
  return (
    m.label.toLowerCase().includes(needle) ||
    m.shortLabel.toLowerCase().includes(needle) ||
    m.symbol.toLowerCase().includes(needle) ||
    m.metricId.toLowerCase().includes(needle)
  );
}

interface SearchDeps {
  store: Store;
  count: number;
  /** Search matches that also pass the filters, in layout order, in the shown domain. */
  matches(): string[];
  /** How many matches sit in the other domains. */
  elsewhere(): number;
  onSelect(id: string): void;
  /** The highlighted match changed (null = none). */
  onCursor(id: string | null): void;
}

/** Search box: `/` or ⌘K / Ctrl+K focus it; Enter selects; ArrowDown/Up cycle through matches. */
export class Search {
  readonly el: HTMLDivElement;
  readonly input: HTMLInputElement;
  private readonly status: HTMLSpanElement;
  private cursor = -1;

  constructor(private readonly d: SearchDeps) {
    this.el = document.createElement('div');
    this.el.className = 'search';
    this.el.setAttribute('role', 'search');
    const label = document.createElement('label');
    label.className = 'visually-hidden';
    label.htmlFor = 'search-input';
    label.textContent = 'Search metrics';
    this.input = document.createElement('input');
    this.input.id = 'search-input';
    this.input.type = 'search';
    this.input.autocomplete = 'off';
    this.input.spellcheck = false;
    this.input.placeholder = `Search ${d.count} metrics`;
    this.input.setAttribute('aria-describedby', 'search-status');
    this.input.setAttribute('aria-keyshortcuts', '/ Control+K Meta+K');
    const kbd = document.createElement('kbd');
    kbd.className = 'search-kbd';
    kbd.textContent = '/';
    kbd.setAttribute('aria-hidden', 'true');
    this.status = document.createElement('span');
    this.status.id = 'search-status';
    this.status.className = 'search-status';
    this.status.setAttribute('aria-live', 'polite');
    this.el.append(label, this.input, kbd, this.status);

    this.input.value = d.store.state.q;
    this.input.addEventListener('input', () => {
      this.cursor = -1;
      d.store.update({ q: this.input.value }, 'replace');
    });
    this.input.addEventListener('keydown', (e) => this.onKey(e));
    d.store.subscribe((s, prev) => {
      if (s.q !== this.input.value) this.input.value = s.q;
      if (s.q !== prev.q) this.cursor = -1;
      this.refresh();
    });
    this.refresh();
  }

  focus(): void {
    this.input.focus();
    this.input.select();
  }

  private onKey(e: KeyboardEvent): void {
    const list = this.d.matches();
    if (e.key === 'Enter') {
      e.preventDefault();
      const id = list[Math.max(0, this.cursor)];
      if (id) this.d.onSelect(id);
    } else if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
      if (!list.length) return;
      e.preventDefault();
      const step = e.key === 'ArrowDown' ? 1 : -1;
      this.cursor = this.cursor < 0 ? (step > 0 ? 0 : list.length - 1) : (this.cursor + step + list.length) % list.length;
      this.refresh();
    } else if (e.key === 'Escape' && this.input.value) {
      e.preventDefault();
      e.stopPropagation();
      this.d.store.update({ q: '' }, 'replace');
    }
  }

  private refresh(): void {
    const q = this.d.store.state.q.trim();
    const list = q ? this.d.matches() : [];
    if (this.cursor >= list.length) this.cursor = -1;
    const current = q && this.cursor >= 0 ? list[this.cursor] : null;
    this.d.onCursor(current ?? null);
    const other = q ? this.d.elsewhere() : 0;
    if (!q) this.status.textContent = '';
    else if (!list.length) this.status.textContent = other ? `None here · ${other} in other domains` : 'No matches';
    else
      this.status.textContent =
        this.cursor >= 0
          ? `${this.cursor + 1} of ${list.length}`
          : `${list.length} match${list.length === 1 ? '' : 'es'}`;
  }
}
