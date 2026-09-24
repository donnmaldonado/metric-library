import { copyFileSync, existsSync } from 'node:fs';
import { resolve } from 'node:path';
import { defineConfig, type Plugin } from 'vite';

// GitHub Pages serves 404.html for unknown paths; a copy of index.html keeps
// deep links (…/metric-library/?m=arr and friends) working after a refresh.
function spaFallback(): Plugin {
  let outDir = 'dist';
  return {
    name: 'spa-404-fallback',
    apply: 'build',
    configResolved(config) {
      outDir = resolve(config.root, config.build.outDir);
    },
    closeBundle() {
      const index = resolve(outDir, 'index.html');
      if (existsSync(index)) copyFileSync(index, resolve(outDir, '404.html'));
    },
  };
}

export default defineConfig({
  base: process.env.BASE_PATH || '/metric-library/',
  plugins: [spaFallback()],
  build: { target: 'es2022' },
});
