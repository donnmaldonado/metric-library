import { FAMILY_LABEL, GLYPH, familyOf } from './data';
import type { Metric, Portfolio } from './types';

const DELAY = 150;

/**
 * A card that appears 150 ms after a tile is hovered (mouse) or keyboard-focused.
 * Touch devices never see it: pointer events from touch are ignored upstream, and a tap selects.
 */
export class HoverCard {
  readonly el: HTMLDivElement;
  private timer = 0;
  private shownFor: string | null = null;

  constructor(
    private readonly p: Portfolio,
    private readonly byId: Map<string, Metric>,
    /** Called with the related ids when the card shows, and null when it hides. */
    private readonly onRing: (ids: Set<string> | null) => void,
  ) {
    this.el = document.createElement('div');
    this.el.className = 'hovercard';
    this.el.id = 'hovercard';
    this.el.setAttribute('role', 'tooltip');
    this.el.hidden = true;
    document.body.append(this.el);
  }

  schedule(id: string | null, anchor?: HTMLElement): void {
    clearTimeout(this.timer);
    if (!id || !anchor) {
      this.hide();
      return;
    }
    if (this.shownFor) this.hide();
    this.timer = window.setTimeout(() => this.show(id, anchor), DELAY);
  }

  hide(): void {
    clearTimeout(this.timer);
    if (this.shownFor === null) return;
    this.shownFor = null;
    this.el.hidden = true;
    this.onRing(null);
  }

  get visible(): boolean {
    return this.shownFor !== null;
  }

  private show(id: string, anchor: HTMLElement): void {
    const m = this.byId.get(id);
    if (!m || !anchor.isConnected) return;
    const fam = familyOf(m.unit);
    this.el.replaceChildren();
    const title = document.createElement('p');
    title.className = 'hc-title';
    title.textContent = m.label;
    const desc = document.createElement('p');
    desc.className = 'hc-desc';
    desc.textContent = m.shortDescription;
    const facts = document.createElement('p');
    facts.className = 'hc-facts';
    const unit = m.unit === fam ? FAMILY_LABEL[fam] : `${FAMILY_LABEL[fam]} (${m.unit})`;
    facts.textContent = `${GLYPH[fam]} ${unit} · ${this.p.tierLabels[m.tier]} · ${this.p.domainLabels[m.domain] ?? m.domain}`;
    this.el.append(title, desc, facts);
    this.el.hidden = false;
    this.shownFor = id;
    this.place(anchor);
    this.onRing(new Set([...m.parentMetrics, ...m.childMetrics]));
  }

  private place(anchor: HTMLElement): void {
    const r = anchor.getBoundingClientRect();
    const card = this.el.getBoundingClientRect();
    const vw = document.documentElement.clientWidth;
    const gap = 8;
    let left = r.left + r.width / 2 - card.width / 2;
    left = Math.max(8, Math.min(left, vw - card.width - 8));
    // Above the tile by default; below when there is no room.
    let top = r.top - card.height - gap;
    if (top < 8) top = r.bottom + gap;
    this.el.style.left = `${Math.round(left)}px`;
    this.el.style.top = `${Math.round(top)}px`;
  }
}
