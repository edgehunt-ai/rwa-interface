import { mkdirSync, readFileSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { spawnSync } from 'node:child_process';

// Requires ImageMagick with SVG and WebP support.
const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const firstFrame = readFileSync(
  resolve(root, 'assets/launch/surface/first-frame.svg'),
  'utf8',
);

function render(path, width, height, viewBox, color) {
  const svg = firstFrame
    .replace('viewBox="0 0 390 844"', `width="${width}" height="${height}" viewBox="${viewBox}"`)
    .replaceAll('currentColor', '#FFFFFF');
  const output = resolve(root, path);
  mkdirSync(dirname(output), { recursive: true });
  const result = spawnSync(
    'magick',
    [
      '-background', 'none', 'rsvg:-',
      '-channel', 'RGB', '-fill', color, '-colorize', '100', '+channel',
      '-depth', '8', '-define', 'webp:lossless=true', output,
    ],
    { input: svg, encoding: 'utf8' },
  );
  if (result.error) throw result.error;
  if (result.status !== 0) throw new Error(result.stderr);
}

for (const [appearance, color] of [['light', '#FF7BE5'], ['dark', '#FFFFFF']]) {
  for (const [density, scale] of [
    ['mdpi', 1], ['hdpi', 1.5], ['xhdpi', 2], ['xxhdpi', 3], ['xxxhdpi', 4],
  ]) {
    const qualifier = appearance === 'dark' ? 'night-' : '';
    // Android 12 uses a 288dp icon canvas. Center the same 144dp mark as iOS
    // without baking the light canvas into the transparent artwork.
    render(
      `android/app/src/main/res/drawable-${qualifier}${density}/launch_first_frame.webp`,
      288 * scale, 288 * scale, '51 278 288 288', color,
    );
  }
  for (const scale of [1, 2, 3]) {
    const suffix = scale === 1 ? '' : `@${scale}x`;
    const name = appearance === 'dark' ? 'LaunchImage-dark' : 'LaunchImage';
    render(
      `ios/Runner/Assets.xcassets/LaunchImage.imageset/${name}${suffix}.png`,
      390 * scale, 844 * scale, '0 0 390 844', color,
    );
  }
}
