import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import test from 'node:test';

test('统一质量命令串联契约、二次生成、格式、分析和测试并传播失败', async () => {
  const pkg = JSON.parse(await readFile(new URL('../package.json', import.meta.url)));
  const command = pkg.scripts['quality:check'];
  for (const required of ['contract:check', 'client:prepare', 'dart format', 'dart analyze --fatal-infos', 'flutter test']) {
    assert.match(command, new RegExp(required.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')));
  }
  assert.ok(command.includes('&&'), 'must stop on the first failed stage');
  assert.equal(pkg.scripts['release:verify'], 'npm run quality:check');
});

test('client:regenerate 保留现有命令并串联正式生成、辅助生成和完整验证', async () => {
  const pkg = JSON.parse(await readFile(new URL('../package.json', import.meta.url)));
  assert.equal(
    pkg.scripts['client:regenerate'],
    'npm run client:generate && npm run client:prepare && npm run quality:check',
  );
  for (const name of ['client:generate', 'client:prepare', 'quality:check', 'client:check']) {
    assert.ok(pkg.scripts[name], `existing script ${name} must remain available`);
  }
});
