import assert from 'node:assert/strict';
import { mkdir, mkdtemp, readFile, readdir, rm, writeFile } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import test from 'node:test';
import { syncPrivyConfiguration } from './sync-privy-url-scheme.mjs';

async function fixture(t) {
  const root = await mkdtemp(join(tmpdir(), 'privy-native-config-'));
  t.after(() => rm(root, { recursive: true, force: true }));
  await mkdir(join(root, 'ios/Flutter'), { recursive: true });
  await mkdir(join(root, 'android/app/src/main/res/values'), { recursive: true });
  return root;
}

test('syncs native OAuth and Passkey configuration from one environment file', async (t) => {
  const root = await fixture(t);
  await writeFile(join(root, '.env.test'), [
    'PRIVY_APP_URL_SCHEME=nobell-test',
    'PRIVY_EXPORT_URL="https://keys.example.test:8443/export?flow=verify#ready"',
  ].join(String.fromCharCode(10)));
  syncPrivyConfiguration('.env.test', root);
  assert.match(await readFile(join(root, 'android/app/src/main/res/values/privy_url_scheme.xml'), 'utf8'), />nobell-test</);
  assert.match(await readFile(join(root, 'ios/Flutter/PrivyUrlScheme.xcconfig'), 'utf8'), /PRIVY_APP_URL_SCHEME = nobell-test/);
  assert.match(await readFile(join(root, 'ios/Flutter/PrivyUrlScheme.xcconfig'), 'utf8'), /APP_LINK_URL_SCHEME = nobell-test-app/);
  assert.match(await readFile(join(root, 'android/app/src/main/res/values/privy_url_scheme.xml'), 'utf8'), /name="app_link_url_scheme"[^>]*>nobell-test-app</);
  assert.equal(
    await readFile(join(root, 'ios/Flutter/PrivyPasskey.xcconfig'), 'utf8'),
    '// Generated from PRIVY_EXPORT_URL; do not edit manually.' + String.fromCharCode(10) +
      'PRIVY_RELYING_PARTY_HOST = keys.example.test' + String.fromCharCode(10),
  );
  await writeFile(join(root, '.env.test'), 'PRIVY_APP_URL_SCHEME=nobell\nPRIVY_EXPORT_URL=https://another.example.test');
  syncPrivyConfiguration('.env.test', root);
  const updated = await readFile(join(root, 'ios/Flutter/PrivyPasskey.xcconfig'), 'utf8');
  assert.match(updated, /PRIVY_RELYING_PARTY_HOST = another\.example\.test/);
  assert.doesNotMatch(updated, /keys\.example\.test/);
  const android = await readFile(join(root, 'android/app/src/main/res/values/privy_url_scheme.xml'), 'utf8');
  assert.match(android, />nobell-app</);
  assert.doesNotMatch(android, /another\.example\.test|keys\.example\.test/);
});

test('invalid export configuration cannot overwrite native configuration', async (t) => {
  const root = await fixture(t);
  for (const url of ['', 'http://keys.example.test', 'https://user:password@keys.example.test']) {
    await writeFile(join(root, '.env.test'), 'PRIVY_APP_URL_SCHEME=nobell\nPRIVY_EXPORT_URL=' + url);
    assert.throws(() => syncPrivyConfiguration('.env.test', root), /PRIVY_EXPORT_URL/);
  }
  assert.deepEqual(await readdir(join(root, 'ios/Flutter')), []);
  assert.deepEqual(await readdir(join(root, 'android/app/src/main/res/values')), []);
});
