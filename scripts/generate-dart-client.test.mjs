import assert from 'node:assert/strict';
import { mkdtempSync, mkdirSync, symlinkSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import test from 'node:test';

import { resolveSafeOutput } from './generate-dart-client.mjs';

test('仅允许 generated package 与 contract cache 子目录', () => {
  const root = mkdtempSync(join(tmpdir(), 'rwa-generator-'));
  assert.equal(resolveSafeOutput(root).relativeOutput, 'packages/rwa_api_client');
  assert.equal(resolveSafeOutput(root, '.contract-cache/check').relativeOutput, '.contract-cache/check');
  for (const target of ['.', '..', 'lib', '.contract-cache']) {
    assert.throws(() => resolveSafeOutput(root, target), /must be the generated package/);
  }
});

test('拒绝通过 symlink 逃逸到仓库外', () => {
  const root = mkdtempSync(join(tmpdir(), 'rwa-generator-'));
  const outside = mkdtempSync(join(tmpdir(), 'rwa-outside-'));
  mkdirSync(join(root, '.contract-cache'));
  symlinkSync(outside, join(root, '.contract-cache', 'escape'));
  assert.throws(() => resolveSafeOutput(root, '.contract-cache/escape'), /symbolic link/);
});
