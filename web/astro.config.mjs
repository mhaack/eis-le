// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import alpinejs from '@astrojs/alpinejs';
import cloudflare from '@astrojs/cloudflare';

import sitemap from '@astrojs/sitemap';

// https://astro.build/config
export default defineConfig({
  site: 'https://eis-le.de',
  trailingSlash: 'never',
  output: 'static',
  adapter: cloudflare(),
  vite: {
    plugins: [tailwindcss()],
  },
  integrations: [alpinejs(), sitemap()],
});