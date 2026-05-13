// @ts-check
import { defineConfig, passthroughImageService } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import alpinejs from '@astrojs/alpinejs';
import cloudflare from '@astrojs/cloudflare';

import sitemap from '@astrojs/sitemap';

// Strip any leading dots from generated Rollup chunk filenames. lucide-astro
// ships an internal template file at dist/.Layout.astro (leading dot, chosen
// to avoid colliding with its `Layout` icon). When Rollup splits it into its
// own chunk, the dot is preserved and the file is emitted as a hidden .mjs,
// which the @astrojs/cloudflare prerender worker (miniflare/workerd) cannot
// resolve, failing the build with "No such module ... .Layout_*.mjs".
const stripLeadingDot = (chunkInfo) => {
  const name = (chunkInfo.name ?? 'chunk').replace(/^\.+/, '_');
  return `chunks/${name}_[hash].mjs`;
};

// https://astro.build/config
export default defineConfig({
  site: 'https://eis-le.de',
  trailingSlash: 'never',
  output: 'static',
  adapter: cloudflare(),
  vite: {
    plugins: [tailwindcss()],
    build: {
      rollupOptions: {
        output: {
          chunkFileNames: stripLeadingDot,
        },
      },
    },
  },
  integrations: [alpinejs(), sitemap({ lastmod: new Date() })],
  image: {
    // Passthrough emits the original src URL directly — no /_image proxy needed.
    // Required for remote images (Supabase Storage) in a static Cloudflare Pages deploy.
    service: passthroughImageService(),
  },
});