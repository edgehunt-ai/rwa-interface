import assert from 'node:assert/strict';
import { readFile } from 'node:fs/promises';
import test from 'node:test';

const read = (name) => readFile(new URL(`../.github/workflows/${name}`, import.meta.url), 'utf8');

test('CI 使用共享门禁、PR concurrency 和版本/lockfile cache', async () => {
  const ci = await read('ci.yml');
  assert.match(ci, /concurrency:[\s\S]*pull_request\.number/);
  assert.match(ci, /npm run quality:check/);
  assert.match(ci, /cache: npm/);
  assert.match(ci, /cache: true/);
  assert.match(ci, /actions\/checkout@v4/);
});

test('Release 同 SHA 自验且不取消，并报告非门禁 size', async () => {
  const release = await read('release.yml');
  assert.match(release, /cancel-in-progress: false/);
  assert.match(release, /npm run release:verify/);
  assert.match(release, /GITHUB_STEP_SUMMARY/);
  assert.match(release, /--dart-define-from-file=\.env\.ci/);
  assert.match(release, /PRIVY_APP_ID/);
  assert.doesNotMatch(release, /sha256sum|SHA256SUMS/);
  assert.doesNotMatch(release, /max[-_ ]size|size[-_ ]limit/i);
});

test('contract approvals workflow requires one authorized collaborator approval', async () => {
  const approvals = await read('contract-approvals.yml');
  assert.match(approvals, /Require an authorized contract approval/);
  assert.match(approvals, /hasApproval/);
  assert.match(approvals, /getCollaboratorPermissionLevel/);
  assert.doesNotMatch(approvals, /requiredApprovers/);
  assert.doesNotMatch(approvals, /yongjun925|junjieit/);
});
