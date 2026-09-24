// Prebuild step: rewrite public/data/formulas/*.json in place, replacing each raw
// `yaml` / `sql` string with Shiki HTML (dual light/dark theme via CSS variables,
// switched in styles.css). Idempotent: files already holding `<pre` HTML are skipped.
//
// Measured on the finance domain (83 metrics): ~24 KB gzipped with dual inline
// styles, so the simpler inline scheme is used rather than class-per-colour tokens.
import { readdirSync, readFileSync, writeFileSync, existsSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { gzipSync } from 'node:zlib';
import { createHighlighter } from 'shiki';

const BUDGET = 40 * 1024;
const here = dirname(fileURLToPath(import.meta.url));
const dir = join(here, '..', 'public', 'data', 'formulas');

if (!existsSync(dir)) {
  console.warn(`highlight: ${dir} not found; run scripts/export_portfolio.py first. Skipping.`);
  process.exit(0);
}

const files = readdirSync(dir).filter((f) => f.endsWith('.json')).sort();
const themes = { light: 'github-light', dark: 'github-dark' };
const highlighter = await createHighlighter({ themes: Object.values(themes), langs: ['yaml', 'sql'] });

const isHtml = (s) => typeof s === 'string' && s.startsWith('<pre');
const render = (code, lang) =>
  highlighter
    .codeToHtml(code ?? '', { lang, themes, defaultColor: false })
    // The site styles the block itself; drop Shiki's tabindex (the panel's pre gets its own).
    .replace(' tabindex="0"', '');

let over = 0;
for (const file of files) {
  const path = join(dir, file);
  const data = JSON.parse(readFileSync(path, 'utf8'));
  const entries = Object.values(data);
  const done = entries.length > 0 && entries.every((e) => isHtml(e.yaml) && isHtml(e.sql));
  if (!done) {
    for (const entry of entries) {
      if (!isHtml(entry.yaml)) entry.yaml = render(entry.yaml, 'yaml');
      if (!isHtml(entry.sql)) entry.sql = render(entry.sql, 'sql');
    }
    writeFileSync(path, JSON.stringify(data));
  }
  const text = readFileSync(path);
  const gz = gzipSync(text).length;
  const flag = gz > BUDGET ? '  WARNING: over 40 KB gzipped budget' : '';
  if (gz > BUDGET) over++;
  console.log(
    `highlight: ${file.padEnd(18)} ${String(entries.length).padStart(3)} metrics  ` +
      `${(text.length / 1024).toFixed(1).padStart(7)} KB raw  ${(gz / 1024).toFixed(1).padStart(5)} KB gzip` +
      `${done ? '  (already highlighted)' : ''}${flag}`,
  );
}
highlighter.dispose();
if (over) console.warn(`highlight: ${over} file(s) over budget`);
