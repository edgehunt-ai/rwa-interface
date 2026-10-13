import { spawnSync } from 'node:child_process';
import { mkdir, readFile, writeFile } from 'node:fs/promises';

function capture(command, args) {
  const result = spawnSync(command, args, { encoding: 'utf8' });
  if (result.error || result.status !== 0) {
    throw new Error(`${command} failed: ${result.error?.message ?? result.stderr}`);
  }
  return result.stdout.trim();
}

const args = process.argv.slice(2);
if (args.length && (args.length !== 2 || args[0] !== '--device')) {
  throw new Error('Usage: node scripts/run-performance.mjs [--device <Android/iOS device ID>]');
}
const devices = JSON.parse(capture('flutter', ['devices', '--machine']));
const nativeDevices = devices.filter((d) => /^(android|ios)(-|$)/.test(d.targetPlatform));
const requested = args[1] ?? process.env.PERF_DEVICE;
const device = requested
  ? nativeDevices.find((d) => d.id === requested)
  : nativeDevices.length === 1 ? nativeDevices[0] : undefined;
if (!device) throw new Error('Select one connected Android/iOS device with --device. Web is unsupported.');
if (device.targetPlatform.startsWith('ios') && device.emulator) {
  throw new Error('iOS profile performance requires a physical device, not an iOS simulator.');
}
const flutter = JSON.parse(capture('flutter', ['--version', '--machine']));
const samples = Number(process.env.PERF_SAMPLES ?? 10);
const warmups = Number(process.env.PERF_WARMUPS ?? 2);
if (!Number.isInteger(samples) || samples < 5 || !Number.isInteger(warmups) || warmups < 1) {
  throw new Error('PERF_SAMPLES must be >= 5 and PERF_WARMUPS must be >= 1');
}
const android = device.targetPlatform.startsWith('android');
const property = (key) => capture('adb', ['-s', device.id, 'shell', 'getprop', key]);
const environment = {
  flutter_version: flutter.frameworkVersion,
  flutter_revision: flutter.frameworkRevision,
  target: device.targetPlatform,
  device_model: android ? property('ro.product.model') : device.name,
  os_version: device.sdk,
  physical_device: !device.emulator,
  runner: process.env.PERF_RUNNER_LABEL ?? `local-${process.platform}-${process.arch}`,
  ...(android ? { android_api: property('ro.build.version.sdk'), abi: property('ro.product.cpu.abi') } : {}),
};
// Remove only the previous raw result so a failed run cannot reuse stale data.
// The final report/artifacts are left intact until successfully regenerated.
await mkdir('build/performance', { recursive: true });
const { rm } = await import('node:fs/promises');
await rm('build/performance/raw.json', { force: true });
const result = spawnSync('flutter', [
  'drive', '--profile', '--no-pub', '-d', device.id,
  '--driver=test_driver/performance_driver.dart',
  '--target=integration_test/performance_test.dart',
  `--dart-define=PERF_SAMPLES=${samples}`,
  `--dart-define=PERF_WARMUPS=${warmups}`,
  '--timeout=900',
], { stdio: 'inherit' });
if (result.error || result.status !== 0) process.exit(result.status || 1);
const raw = JSON.parse(await readFile('build/performance/raw.json', 'utf8'));
raw.environment = environment;
raw.commit = process.env.PERF_COMMIT ?? process.env.GITHUB_SHA ?? capture('git', ['rev-parse', 'HEAD']);
raw.generated_at = new Date().toISOString();
await writeFile('build/performance/raw.json', `${JSON.stringify(raw, null, 2)}\n`);
console.log('Native performance data: build/performance/raw.json');
