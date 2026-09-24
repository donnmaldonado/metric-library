import { FAMILY_LABEL, GLYPH, familyOf, loadFormulas } from './data';
import { createBigTile, createMiniTile } from './tile';
import type { LabelDesc, Metric, Portfolio } from './types';

type Tab = 'yaml' | 'sql';

function el<K extends keyof HTMLElementTagNameMap>(tag: K, cls?: string, text?: string): HTMLElementTagNameMap[K] {
  const node = document.createElement(tag);
  if (cls) node.className = cls;
  if (text !== undefined) node.textContent = text;
  return node;
}

function section(title: string): HTMLElement {
  const s = el('section', 'panel-section');
  s.append(el('h3', 'panel-h', title));
  return s;
}

/** The metric's full definition: side panel (≥ 768 px) or bottom sheet (< 768 px). */
export class DetailPanel {
  readonly el: HTMLElement;
  private readonly body: HTMLDivElement;
  private readonly heading: HTMLHeadingElement;
  private current: Metric | null = null;
  private tab: Tab = 'yaml';

  constructor(
    private readonly p: Portfolio,
    private readonly byId: Map<string, Metric>,
    private readonly onSelect: (id: string) => void,
    private readonly onClose: () => void,
  ) {
    this.el = el('aside', 'panel');
    this.el.id = 'detail';
    this.el.setAttribute('aria-labelledby', 'panel-title');
    this.el.hidden = true;

    const bar = el('div', 'panel-bar');
    const grip = el('span', 'panel-grip');
    grip.setAttribute('aria-hidden', 'true');
    const close = el('button', 'icon-btn panel-close');
    close.type = 'button';
    close.setAttribute('aria-label', 'Close details (Esc)');
    close.title = 'Close (Esc)';
    close.textContent = '✕';
    close.addEventListener('click', () => this.onClose());
    bar.append(grip, close);

    this.heading = el('h2', 'panel-title');
    this.heading.id = 'panel-title';
    this.heading.tabIndex = -1;
    this.body = el('div', 'panel-body');
    this.el.append(bar, this.body);
  }

  get openId(): string | null {
    return this.current?.metricId ?? null;
  }

  close(): void {
    this.current = null;
    this.el.hidden = true;
  }

  focusHeading(): void {
    this.heading.focus({ preventScroll: true });
  }

  open(m: Metric): void {
    if (this.current?.metricId === m.metricId && !this.el.hidden) return;
    this.current = m;
    this.el.hidden = false;
    this.body.replaceChildren(
      this.header(m),
      this.description(m),
      ...this.fraction(m),
      this.formula(m),
      this.labels(m),
      this.relationships(m),
      this.treeLink(m),
    );
    this.body.scrollTop = 0;
    this.el.scrollTop = 0;
  }

  // 1. symbol tile, label, chips
  private header(m: Metric): HTMLElement {
    const head = el('header', 'panel-head');
    this.heading.textContent = m.label;
    const chips = el('div', 'chips');
    const fam = familyOf(m.unit);
    chips.append(
      el('span', `chip chip-tier tier-${m.tier}`, this.p.tierLabels[m.tier]),
      el('span', 'chip', this.p.domainLabels[m.domain] ?? m.domain),
      el('span', 'chip', this.p.industryLabels[m.industry] ?? m.industry),
      el('span', `chip chip-unit fam-${fam}`, `${GLYPH[fam]} ${m.unit === fam ? FAMILY_LABEL[fam] : m.unit}`),
    );
    const text = el('div', 'panel-head-text');
    const id = el('p', 'panel-id');
    id.append(el('code', undefined, m.metricId), document.createTextNode(` · #${m.number} · ${m.shortLabel}`));
    text.append(this.heading, id, chips);
    head.append(createBigTile(m), text);
    return head;
  }

  // 2. description
  private description(m: Metric): HTMLElement {
    return el('p', 'panel-desc', m.shortDescription);
  }

  // 3. numerator over denominator
  private fraction(m: Metric): HTMLElement[] {
    if (!m.numerator && !m.denominator) return [];
    const s = section('Definition');
    if (m.numerator && m.denominator) {
      const frac = el('div', 'fraction');
      frac.setAttribute('role', 'math');
      frac.setAttribute('aria-label', `${m.numerator} divided by ${m.denominator}`);
      frac.append(el('span', 'frac-num', m.numerator), el('span', 'frac-den', m.denominator));
      s.append(frac);
    } else {
      s.append(el('p', 'frac-single', m.numerator || m.denominator));
    }
    return [s];
  }

  // 4. formula tabs + copy
  private formula(m: Metric): HTMLElement {
    const s = section('Formula');
    const box = el('div', 'formula');
    const bar = el('div', 'formula-bar');
    const tabs = el('div', 'tabs');
    tabs.setAttribute('role', 'tablist');
    tabs.setAttribute('aria-label', 'Formula format');
    const mk = (key: Tab, label: string): HTMLButtonElement => {
      const b = el('button', 'tab', label);
      b.type = 'button';
      b.id = `tab-${key}`;
      b.setAttribute('role', 'tab');
      b.setAttribute('aria-controls', 'formula-code');
      b.dataset.tab = key;
      return b;
    };
    const tYaml = mk('yaml', 'MetricFlow');
    const tSql = mk('sql', 'SQL');
    tabs.append(tYaml, tSql);
    const copy = el('button', 'copy-btn', 'Copy');
    copy.type = 'button';
    copy.disabled = true;
    const status = el('span', 'visually-hidden');
    status.setAttribute('aria-live', 'polite');
    bar.append(tabs, copy, status);

    const code = el('div', 'formula-code');
    code.id = 'formula-code';
    code.setAttribute('role', 'tabpanel');
    code.tabIndex = 0;
    code.append(el('p', 'formula-loading', 'Loading formula…'));
    box.append(bar, code);
    s.append(box);

    let html: { yaml: string; sql: string } | null = null;
    const show = (key: Tab, focus = false): void => {
      this.tab = key;
      for (const t of [tYaml, tSql]) {
        const on = t.dataset.tab === key;
        t.setAttribute('aria-selected', String(on));
        t.tabIndex = on ? 0 : -1;
        if (on && focus) t.focus();
      }
      code.setAttribute('aria-labelledby', `tab-${key}`);
      if (html) code.innerHTML = html[key] || '<p class="formula-loading">No formula.</p>';
    };
    tabs.addEventListener('click', (e) => {
      const t = (e.target as Element).closest<HTMLButtonElement>('[role=tab]');
      if (t) show(t.dataset.tab as Tab);
    });
    tabs.addEventListener('keydown', (e) => {
      if (e.key === 'ArrowLeft' || e.key === 'ArrowRight' || e.key === 'Home' || e.key === 'End') {
        e.preventDefault();
        show(this.tab === 'yaml' ? 'sql' : 'yaml', true);
      }
    });
    copy.addEventListener('click', async () => {
      const text = code.querySelector('pre')?.textContent ?? '';
      let ok = true;
      try {
        await navigator.clipboard.writeText(text);
      } catch {
        ok = false;
      }
      copy.textContent = ok ? 'Copied' : 'Copy failed';
      status.textContent = ok ? 'Formula copied to clipboard' : 'Could not copy';
      window.setTimeout(() => {
        copy.textContent = 'Copy';
        status.textContent = '';
      }, 1500);
    });
    show(this.tab);

    const id = m.metricId;
    loadFormulas(m.domain).then(
      (all) => {
        if (this.current?.metricId !== id) return;
        html = all[id] ?? { yaml: '', sql: '' };
        copy.disabled = false;
        show(this.tab);
      },
      () => {
        if (this.current?.metricId !== id) return;
        code.replaceChildren(el('p', 'formula-loading', 'Could not load the formula. Try again later.'));
      },
    );
    return s;
  }

  // 5. dimensions and sources
  private labels(m: Metric): HTMLElement {
    const s = el('section', 'panel-section panel-labels');
    const group = (title: string, ids: string[], dict: Record<string, LabelDesc>): HTMLElement => {
      const g = el('div', 'label-group');
      g.append(el('h3', 'panel-h', title));
      const chips = el('ul', 'chips');
      for (const id of ids) {
        const info = dict[id];
        const li = el('li', 'chip chip-tip', info?.label ?? id);
        if (info?.desc) {
          li.dataset.tip = info.desc;
          li.tabIndex = 0;
          li.setAttribute('aria-label', `${info.label}: ${info.desc}`);
        }
        chips.append(li);
      }
      if (!ids.length) chips.append(el('li', 'muted', 'None'));
      g.append(chips);
      return g;
    };
    s.append(group('Dimensions', m.dimensions, this.p.dimensions), group('Data sources', m.dataSources, this.p.sources));
    return s;
  }

  // 6. relationships
  private relationships(m: Metric): HTMLElement {
    const s = section('Relationships');
    const rows: Array<[string, string, string[]]> = [
      ['Driven by', 'children', m.childMetrics],
      ['Drives', 'parents', m.parentMetrics],
      ['Computed from', 'formula inputs', m.formulaInputs],
      ['Moves with', 'correlated', m.correlatedMetrics],
    ];
    const dl = el('dl', 'rels');
    for (const [title, hint, ids] of rows) {
      const metrics = ids.map((id) => this.byId.get(id)).filter((x): x is Metric => !!x);
      if (!metrics.length) continue;
      const dt = el('dt', undefined, title);
      dt.title = hint;
      const dd = el('dd', 'mini-row');
      for (const x of metrics) dd.append(createMiniTile(x, this.p, this.onSelect));
      dl.append(dt, dd);
    }
    if (!dl.childElementCount) s.append(el('p', 'muted', 'No relationships.'));
    else s.append(dl);
    return s;
  }

  // 7. driver-tree link: hidden until that view ships
  private treeLink(m: Metric): HTMLElement {
    const a = el('a', 'tree-link', 'Open in driver tree');
    a.href = `tree/?m=${encodeURIComponent(m.metricId)}`;
    a.hidden = true;
    return a;
  }
}
