import { resolve } from 'node:path';
import react from '@vitejs/plugin-react';
import { defineConfig, loadEnv } from 'vite';
import { generatePasskeyAssociationFiles } from '../../scripts/generate-passkey-association-files.mjs';

export default defineConfig(async ({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');
  const exportBuild = mode === 'export';
  if (exportBuild) {
    const result = await generatePasskeyAssociationFiles({ environment: env });
    console.log('Passkey associations for ' + result.origin + ': ' +
      (result.files.join(', ') || 'no native application identifiers configured'));
  }
  return {
    root: exportBuild
      ? resolve(import.meta.dirname, '../../private-key-export')
      : process.cwd(),
    publicDir: exportBuild
      ? resolve(import.meta.dirname, '../../private-key-export/public')
      : false,
    server: exportBuild ? { strictPort: true } : undefined,
    plugins: [react()],
    // Privy's browser bundle contains optional dependencies that read
    // process.env. Vite does not polyfill Node globals for browser builds.
    define: {
      process: JSON.stringify({ env: { NODE_ENV: 'production' } }),
      __PRIVY_EXPORT_APP_ID__: JSON.stringify(env.PRIVY_APP_ID || ''),
      __PRIVY_EXPORT_DEV__: JSON.stringify(exportBuild && mode === 'export'),
    },
    build: {
      lib: {
        entry: resolve(import.meta.dirname, 'src/main.jsx'),
        formats: ['iife'],
        name: exportBuild ? 'RwaPrivyExport' : 'RwaPrivyAuth',
        fileName: () => exportBuild ? 'private-key-export.js' : 'privy-auth.js',
      },
      outDir: exportBuild
        ? resolve(import.meta.dirname, '../../private-key-export/dist')
        : resolve(import.meta.dirname, '../../web/privy-auth/dist'),
      emptyOutDir: true,
      sourcemap: false,
      minify: 'esbuild',
    },
  };
});
