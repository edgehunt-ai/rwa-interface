import { readFileSync, writeFileSync } from 'node:fs';
import { resolve } from 'node:path';

const root = resolve(import.meta.dirname, '..');
const envPath = resolve(root, process.argv[2] ?? '.env');
const environment = Object.fromEntries(
  readFileSync(envPath, 'utf8')
    .split(/\r?\n/)
    .map((line) => line.trim())
    .filter((line) => line && !line.startsWith('#'))
    .map((line) => {
      const separator = line.indexOf('=');
      return separator < 0
        ? [line, '']
        : [line.slice(0, separator), line.slice(separator + 1)];
    }),
);
const scheme = environment.PRIVY_APP_URL_SCHEME?.trim();

if (!scheme || !/^[a-z][a-z0-9+.-]*$/i.test(scheme)) {
  throw new Error(
    'PRIVY_APP_URL_SCHEME must be a URI scheme containing letters, digits, +, -, or .',
  );
}

writeFileSync(
  resolve(root, 'android/app/src/main/res/values/privy_url_scheme.xml'),
  `<?xml version="1.0" encoding="utf-8"?>\n<resources>\n    <string name="privy_app_url_scheme" translatable="false">${scheme}</string>\n</resources>\n`,
);
writeFileSync(
  resolve(root, 'ios/Flutter/PrivyUrlScheme.xcconfig'),
  `// Generated from ${process.argv[2] ?? '.env'}; do not edit manually.\nPRIVY_APP_URL_SCHEME = ${scheme}\n`,
);
