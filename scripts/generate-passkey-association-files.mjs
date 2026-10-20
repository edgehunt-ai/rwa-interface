import { mkdtemp, mkdir, rm, writeFile } from 'node:fs/promises';
import { execFile } from 'node:child_process';
import { promisify } from 'node:util';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

// These files contain public application identifiers, never signing keys.
const execFileAsync = promisify(execFile);

async function androidFingerprintsFromKeystore(environment) {
  // Derive the public certificate identity from the existing Android signing
  // keystore; no separate fingerprint configuration is needed.
  const base64 = (environment.ANDROID_KEYSTORE_BASE64 || '').replace(/\s/g, '');
  const storePassword = environment.ANDROID_KEYSTORE_PASSWORD || '';
  const alias = environment.ANDROID_KEY_ALIAS || '';
  const keyPassword = environment.ANDROID_KEY_PASSWORD || '';
  if (!base64 && !storePassword && !alias && !keyPassword) return [];
  if (!base64 || !storePassword || !alias || !keyPassword) {
    throw new Error('Android keystore configuration is incomplete.');
  }

  const temporaryDirectory = await mkdtemp(resolve(process.env.RUNNER_TEMP || '/tmp', 'nobell-keystore-'));
  const keystorePath = resolve(temporaryDirectory, 'release.jks');
  try {
    await writeFile(keystorePath, Buffer.from(base64, 'base64'));
    const result = await execFileAsync('keytool', [
      '-list', '-v', '-keystore', keystorePath, '-alias', alias,
      '-storepass', storePassword, '-keypass', keyPassword,
    ], { maxBuffer: 1024 * 1024 });
    const output = result.stdout + '\\n' + result.stderr;
    return [...new Set([...output.matchAll(/SHA256:\s*(([0-9A-F]{2}:){31}[0-9A-F]{2})/gi)]
      .map((match) => match[1].toUpperCase()))];
  } finally {
    await rm(temporaryDirectory, { recursive: true, force: true });
  }
}

export async function generatePasskeyAssociationFiles({
  environment = process.env,
  outputDirectory = resolve(import.meta.dirname, '../private-key-export/public/.well-known'),
  androidCertificateFingerprints,
} = {}) {
  const exportUrl = new URL(environment.PRIVY_EXPORT_URL || '');
  if (exportUrl.protocol !== 'https:' || exportUrl.username || exportUrl.password) {
    throw new Error('PRIVY_EXPORT_URL must be an HTTPS URL without credentials.');
  }
  const appleTeamId = (environment.APPLE_TEAM_ID || '').trim();
  const iosBundleId = (environment.IOS_BUNDLE_ID || 'global.nobell.app').trim();
  const androidPackageName = (environment.ANDROID_PACKAGE_NAME || 'global.nobell.app').trim();
  const fingerprints = [...new Set(
    (androidCertificateFingerprints ?? await androidFingerprintsFromKeystore(environment))
      .map((value) => value.trim().toUpperCase())
      .filter(Boolean),
  )];

  if (appleTeamId && (!/^[A-Z0-9]{10}$/.test(appleTeamId) || !iosBundleId)) {
    throw new Error('APPLE_TEAM_ID must contain 10 letters/digits and IOS_BUNDLE_ID must be non-empty.');
  }
  if (fingerprints.length && (!androidPackageName ||
      fingerprints.some((value) => !/^(?:[0-9A-F]{2}:){31}[0-9A-F]{2}$/.test(value)))) {
    throw new Error('Android certificate fingerprints must use colon-separated SHA-256 values.');
  }

  const files = {};
  if (appleTeamId) {
    files['apple-app-site-association'] = {
      webcredentials: { apps: [appleTeamId + '.' + iosBundleId] },
    };
  }
  if (fingerprints.length) {
    // Keep both Android App Links and credential sharing associations as
    // required by the Android Credential Manager and Privy setup guides.
    files['assetlinks.json'] = [{
      relation: [
        'delegate_permission/common.handle_all_urls',
        'delegate_permission/common.get_login_creds',
      ],
      target: {
        namespace: 'android_app',
        package_name: androidPackageName,
        sha256_cert_fingerprints: fingerprints,
      },
    }];
  }

  await mkdir(outputDirectory, { recursive: true });
  for (const name of ['apple-app-site-association', 'assetlinks.json']) {
    const path = resolve(outputDirectory, name);
    if (files[name]) {
      await writeFile(path, JSON.stringify(files[name], null, 2) + String.fromCharCode(10));
    } else {
      // A previous local build must not leave another environment's identities.
      await rm(path, { force: true });
    }
  }
  return { origin: exportUrl.origin, files: Object.keys(files) };
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  const result = await generatePasskeyAssociationFiles();
  console.log('Passkey associations for ' + result.origin + ': ' +
    (result.files.join(', ') || 'no native application identifiers configured'));
}
