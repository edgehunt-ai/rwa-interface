import assert from 'node:assert/strict';
import test from 'node:test';

import {checkStagingReadiness} from './check-staging-readiness.mjs';

test('503 service_unconfigured blocks reads and command mode', async () => {
  const result = await checkStagingReadiness({
    fetchImpl: async () => new Response(
      JSON.stringify({code: 'service_unconfigured', message: 'secret must not be printed'}),
      {status: 503, headers: {'content-type': 'application/json', 'x-request-id': 'req-1'}},
    ),
  });
  assert.equal(result.readReady, false);
  assert.equal(result.commandMode, 'blocked');
  assert.equal(result.results[0].code, 'service_unconfigured');
  assert.equal(JSON.stringify(result).includes('secret must not be printed'), false);
});

test('successful public reads remain blocked without explicit proofs', async () => {
  const result = await checkStagingReadiness({
    fetchImpl: async () => new Response('{}', {status: 200}),
  });
  assert.equal(result.readReady, true);
  assert.equal(result.commandReason, 'command_gates_incomplete');
  assert.ok(result.failedGates.includes('controlled_identity'));
  assert.ok(result.failedGates.includes('reset_teardown_verified'));
});

test('authorized 401 fails the controlled identity gate without leaking token', async () => {
  const secret = 'staging-secret-token';
  const result = await checkStagingReadiness({
    accessToken: secret,
    fetchImpl: async (url) => new Response(
      JSON.stringify(url.pathname === '/v1/me' ? {code: 'access_token_invalid'} : {}),
      {status: url.pathname === '/v1/me' ? 401 : 200},
    ),
  });
  assert.equal(result.authorizedReadReady, false);
  assert.ok(result.failedGates.includes('controlled_identity'));
  assert.equal(JSON.stringify(result).includes(secret), false);
});

test('all explicit gates can make staging command-ready', async () => {
  const calls = [];
  const result = await checkStagingReadiness({
    accessToken: 'controlled-token',
    proofs: allProofs(),
    fetchImpl: async (url, options) => {
      calls.push({path: url.pathname, authorization: options.headers.authorization});
      return new Response('{}', {
        status: 200,
        headers: {'x-request-id': `req-${calls.length}`},
      });
    },
  });
  assert.equal(result.readReady, true);
  assert.equal(result.authorizedReadReady, true);
  assert.equal(result.commandMode, 'ready');
  assert.equal(result.commandReason, 'all_preflight_gates_passed');
  assert.deepEqual(result.failedGates, []);
  assert.equal(calls.length, 4);
  assert.equal(calls[3].authorization, 'Bearer controlled-token');
  assert.equal(JSON.stringify(result).includes('controlled-token'), false);
});

test('one missing operational proof keeps command mode fail-closed', async () => {
  const proofs = allProofs();
  proofs.sseVerified = false;
  const result = await checkStagingReadiness({
    accessToken: 'controlled-token',
    proofs,
    fetchImpl: async () => new Response('{}', {status: 200}),
  });
  assert.equal(result.commandMode, 'blocked');
  assert.deepEqual(result.failedGates, ['sse_verified']);
});

function allProofs() {
  return {
    isolationApproved: true,
    commandLimitsDefined: true,
    resetTeardownVerified: true,
    resourceReadbackVerified: true,
    idempotencyVerified: true,
    sseVerified: true,
    diagnosticsRedacted: true,
  };
}
