import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import test from 'node:test';
import { parse } from 'yaml';
import { validateGeneratorFixture } from './check-openapi-generator-fixture.mjs';

test('生成器 fixture 覆盖高风险 construct', async () => {
  const source = await readFile(new URL('fixtures/openapi-generator/main.yaml', import.meta.url), 'utf8');
  assert.deepEqual(validateGeneratorFixture(parse(source)), []);
});

test('fixture 破坏时返回可诊断错误', () => {
  assert.ok(validateGeneratorFixture({}).length >= 7);
});
