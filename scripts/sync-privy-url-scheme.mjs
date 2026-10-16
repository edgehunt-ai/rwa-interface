import { readFileSync, writeFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { parseEnv } from 'node:util';

const repositoryRoot = resolve(import.meta.dirname, '..');

export function syncPrivyConfiguration(envFile = '.env', rootDirectory = repositoryRoot) {
  const environment = parseEnv(readFileSync(resolve(rootDirectory, envFile), 'utf8'));
  const scheme = environment.PRIVY_APP_URL_SCHEME?.trim();
  if (!scheme || !/^[a-z][a-z0-9+.-]*$/i.test(scheme)) {
    throw new Error('PRIVY_APP_URL_SCHEME must be a valid URI scheme.');
  }
  let exportUrl;
  try {
    exportUrl = new URL(environment.PRIVY_EXPORT_URL || '');
    if (exportUrl.protocol !== 'https:' || exportUrl.username || exportUrl.password) throw new Error();
  } catch {
    throw new Error('PRIVY_EXPORT_URL must be an HTTPS URL without credentials.');
  }

  writeFileSync(
    resolve(rootDirectory, 'android/app/src/main/res/values/privy_url_scheme.xml'),
    [
      '<?xml version="1.0" encoding="utf-8"?>',
      '<resources>',
      '    <string name="privy_app_url_scheme" translatable="false">' + scheme + '</string>',
      '    <string name="app_link_host" translatable="false">' + exportUrl.hostname + '</string>',
      '    <string name="app_link_url_scheme" translatable="false">' + scheme + '-app</string>',
      '</resources>',
      '',
    ].join(String.fromCharCode(10)),
  );
  writeFileSync(
    resolve(rootDirectory, 'ios/Flutter/PrivyUrlScheme.xcconfig'),
    [
      '// Generated from ' + envFile + '; do not edit manually.',
      'PRIVY_APP_URL_SCHEME = ' + scheme,
      'APP_LINK_URL_SCHEME = ' + scheme + '-app',
      '',
    ].join(String.fromCharCode(10)),
  );
  writeFileSync(
    resolve(rootDirectory, 'ios/Flutter/PrivyPasskey.xcconfig'),
    [
      '// Generated from PRIVY_EXPORT_URL; do not edit manually.',
      'PRIVY_RELYING_PARTY_HOST = ' + exportUrl.hostname,
      '',
    ].join(String.fromCharCode(10)),
  );
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  syncPrivyConfiguration(process.argv[2]);
}
