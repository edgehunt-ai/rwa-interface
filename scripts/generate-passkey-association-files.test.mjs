import assert from 'node:assert/strict';
import { mkdtemp, readFile, readdir, rm } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import test from 'node:test';
import { generatePasskeyAssociationFiles } from './generate-passkey-association-files.mjs';

const fingerprint = Array(32).fill('AB').join(':');

async function fixture(t) {
  const outputDirectory = await mkdtemp(join(tmpdir(), 'passkey-associations-'));
  t.after(() => rm(outputDirectory, { recursive: true, force: true }));
  return outputDirectory;
}

test('generates native associations with independent iOS and Android identities', async (t) => {
  const outputDirectory = await fixture(t);
  const result = await generatePasskeyAssociationFiles({
    outputDirectory,
    environment: {
      PRIVY_EXPORT_URL: 'https://keys.example.test/export?flow=verify#ready',
      APPLE_TEAM_ID: 'ABCDE12345',
      IOS_BUNDLE_ID: 'test.ios.app',
      ANDROID_PACKAGE_NAME: 'test.android.app',
    },
    androidCertificateFingerprints: [fingerprint.toLowerCase(), fingerprint],
  });
  assert.equal(result.origin, 'https://keys.example.test');
  const apple = JSON.parse(await readFile(join(outputDirectory, 'apple-app-site-association'), 'utf8'));
  assert.deepEqual(apple, {
    webcredentials: { apps: ['ABCDE12345.test.ios.app'] },
    applinks: { details: [{
      appIDs: ['ABCDE12345.test.ios.app'],
      components: [{ '/': '/trade' }, { '/': '/markets' }, { '/': '/activity/*' }],
    }] },
  });
  const android = JSON.parse(await readFile(join(outputDirectory, 'assetlinks.json'), 'utf8'));
  assert.deepEqual(android, [{
    relation: ['delegate_permission/common.get_login_creds', 'delegate_permission/common.handle_all_urls'],
    target: {
      namespace: 'android_app',
      package_name: 'test.android.app',
      sha256_cert_fingerprints: [fingerprint],
    },
  }]);
});

test('supports one configured platform and removes stale associations on rebuild', async (t) => {
  const outputDirectory = await fixture(t);
  const environment = {
    PRIVY_EXPORT_URL: 'https://other.example.test',
  };
  await generatePasskeyAssociationFiles({ outputDirectory, environment,
    androidCertificateFingerprints: [fingerprint], });
  assert.deepEqual(await readdir(outputDirectory), ['assetlinks.json']);
  const appleOnly = await generatePasskeyAssociationFiles({
    outputDirectory,
    environment: { PRIVY_EXPORT_URL: environment.PRIVY_EXPORT_URL, APPLE_TEAM_ID: 'ABCDE12345' },
  });
  assert.deepEqual(appleOnly.files, ['apple-app-site-association']);
  assert.deepEqual(await readdir(outputDirectory), ['apple-app-site-association']);
  const noNativeIdentifiers = await generatePasskeyAssociationFiles({
    outputDirectory,
    environment: { PRIVY_EXPORT_URL: environment.PRIVY_EXPORT_URL },
  });
  assert.deepEqual(noNativeIdentifiers.files, []);
  assert.deepEqual(await readdir(outputDirectory), []);
});

test('rejects invalid origins and identities before writing association files', async (t) => {
  const outputDirectory = await fixture(t);
  for (const environment of [
    {},
    { PRIVY_EXPORT_URL: '/export' },
    { PRIVY_EXPORT_URL: 'http://keys.example.test' },
    { PRIVY_EXPORT_URL: 'https://user:password@keys.example.test' },
    { PRIVY_EXPORT_URL: 'https://keys.example.test', APPLE_TEAM_ID: 'placeholder' },
  ]) {
    await assert.rejects(generatePasskeyAssociationFiles({ outputDirectory, environment }));
  }
  await assert.rejects(generatePasskeyAssociationFiles({
    outputDirectory,
    environment: { PRIVY_EXPORT_URL: 'https://keys.example.test' },
    androidCertificateFingerprints: ['AA:BB'],
  }));
  assert.deepEqual(await readdir(outputDirectory), []);
});
