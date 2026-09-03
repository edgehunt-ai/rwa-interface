import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import test from 'node:test';
import { parse } from 'yaml';

const workflow = parse(readFileSync('.github/workflows/contract-approvals.yml', 'utf8'));
const step = workflow.jobs['require-contract-approval'].steps[0];
const AsyncFunction = Object.getPrototypeOf(async function () {}).constructor;

async function checkApprovals(reviews, headSha = 'head-sha') {
  const listFiles = () => {};
  const listReviews = () => {};
  const failures = [];
  const github = {
    rest: {
      pulls: { listFiles, listReviews },
      repos: { getCollaboratorPermissionLevel: async ({ username }) => ({ data: { permission: username === 'unauthorized' ? 'read' : 'push' } }) },
    },
    paginate: async (method) => (
      method === listFiles ? [{ filename: 'openapi/main.yaml' }] : reviews
    ),
  };
  const context = {
    payload: { pull_request: { number: 7, head: { sha: headSha } } },
    repo: { owner: 'edgehunt-ai', repo: 'rwa-interface' },
  };
  const core = {
    info: () => {},
    setFailed: (message) => failures.push(message),
  };

  await new AsyncFunction('github', 'context', 'core', step.with.script)(
    github,
    context,
    core,
  );
  return failures;
}

function review(user, state, submittedAt, id, commitId = 'head-sha') {
  return {
    id,
    state,
    submitted_at: submittedAt,
    commit_id: commitId,
    user: { login: user },
  };
}

test('one authorized collaborator approval accepts the current head', async () => {
  const failures = await checkApprovals([
    review('yongjun925', 'APPROVED', '2026-09-03T01:00:00Z', 1),
  ]);
  assert.deepEqual(failures, []);
});

test('any authorized collaborator may approve the current head', async () => {
  const failures = await checkApprovals([
    review('junjieit', 'APPROVED', '2026-09-03T01:01:00Z', 2),
  ]);
  assert.deepEqual(failures, []);
});

test('an unauthorized reviewer does not satisfy the contract approval', async () => {
  const failures = await checkApprovals([
    review('unauthorized', 'APPROVED', '2026-09-03T01:01:00Z', 2),
  ]);
  assert.equal(failures.length, 1);
  assert.match(failures[0], /authorized repository collaborator/);
});

test('a later changes-requested review invalidates an earlier approval', async () => {
  const failures = await checkApprovals([
    review('yongjun925', 'APPROVED', '2026-09-03T01:00:00Z', 1),
    review('yongjun925', 'CHANGES_REQUESTED', '2026-09-03T01:02:00Z', 3),
  ]);
  assert.equal(failures.length, 1);
  assert.match(failures[0], /authorized repository collaborator/);
});

test('an approval for an older commit does not approve the current head', async () => {
  const failures = await checkApprovals([
    review('yongjun925', 'APPROVED', '2026-09-03T01:00:00Z', 1, 'old-sha'),
  ]);
  assert.equal(failures.length, 1);
  assert.match(failures[0], /authorized repository collaborator/);
});
