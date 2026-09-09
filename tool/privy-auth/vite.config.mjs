import { resolve } from 'node:path';
import react from '@vitejs/plugin-react';
import { defineConfig } from 'vite';

export default defineConfig({
  plugins: [react()],
  // Privy's browser bundle contains optional dependencies that read
  // process.env. Vite does not polyfill Node globals for browser builds.
  define: {
    process: JSON.stringify({ env: { NODE_ENV: 'production' } }),
  },
  build: {
    lib: {
      entry: resolve(import.meta.dirname, 'src/main.jsx'),
      formats: ['iife'],
      name: 'RwaPrivyAuth',
      fileName: () => 'privy-auth.js',
    },
    outDir: resolve(import.meta.dirname, '../../web/privy-auth/dist'),
    emptyOutDir: true,
    sourcemap: false,
    minify: 'esbuild',
  },
});
