import { GLYPH, familyOf } from './data';
import type { Metric, Portfolio } from './types';

type Labels = Pick<Portfolio, 'tierLabels' | 'domainLabels' | 'industryLabels'>;

function el<K extends keyof HTMLElementTagNameMap>(tag: K, cls: string, text?: string): HTMLElementTagNameMap[K] {
  const node = document.createElement(tag);
  node.className = cls;
  if (text !== undefined) node.textContent = text;
  return node;
}

/** "Net Revenue Retention, rate, KPI, SaaS, element 12." (label, unit, tier, domain, number). */
export function ariaLabel(m: Metric, labels: Labels): string {
  const domain = labels.domainLabels[m.domain] ?? m.domain;
  return `${m.label}, ${m.unit}, ${labels.tierLabels[m.tier]}, ${domain}, element ${m.number}.`;
}

/** The shared face of every tile: number, glyph, symbol and (optionally) the short label. */
function face(button: HTMLElement, m: Metric, withShort: boolean): void {
  const fam = familyOf(m.unit);
  button.classList.add(`fam-${fam}`, `tier-${m.tier}`);
  button.append(
    el('span', 'tile-num', String(m.number)),
    el('span', 'tile-glyph', GLYPH[fam]),
    el('span', 'tile-sym', m.symbol),
  );
  if (withShort) button.append(el('span', 'tile-short', m.shortLabel));
}

/** A grid tile: a gridcell wrapping a button. North Stars span two columns. */
export function createTile(m: Metric, labels: Labels): { cell: HTMLDivElement; button: HTMLButtonElement } {
  const cell = el('div', `cell cell-${m.tier}`);
  cell.setAttribute('role', 'gridcell');
  const button = el('button', 'tile');
  button.type = 'button';
  button.tabIndex = -1;
  button.dataset.id = m.metricId;
  button.setAttribute('aria-label', ariaLabel(m, labels));
  face(button, m, true);
  cell.append(button);
  return { cell, button };
}

/** Large, non-interactive tile at the top of the detail panel. */
export function createBigTile(m: Metric): HTMLDivElement {
  const div = el('div', 'tile tile-big');
  div.setAttribute('aria-hidden', 'true');
  face(div, m, false);
  return div;
}

/** Small clickable symbol tile used for relationships in the panel. */
export function createMiniTile(m: Metric, labels: Labels, onSelect: (id: string) => void): HTMLButtonElement {
  const b = el('button', 'tile tile-mini');
  b.type = 'button';
  const fam = familyOf(m.unit);
  b.classList.add(`fam-${fam}`, `tier-${m.tier}`);
  b.append(el('span', 'tile-sym', m.symbol), el('span', 'mini-label', m.shortLabel));
  b.title = `${m.label} (${labels.tierLabels[m.tier]})`;
  b.setAttribute('aria-label', `${m.label}, ${m.unit}, ${labels.tierLabels[m.tier]}. Select.`);
  b.addEventListener('click', () => onSelect(m.metricId));
  return b;
}
