const defaultBaseUrl = 'https://rwa-api-staging.dxd.ink';
const publicReadOperations = [
  ['auth.config', '/v1/auth/config'],
  ['system.version', '/v1/system/app-version'],
  ['system.disclosures', '/v1/system/disclosures?locale=zh-CN'],
];

const proofDefinitions = [
  ['asset_isolation_approved', 'isolationApproved'],
  ['command_limits_defined', 'commandLimitsDefined'],
  ['reset_teardown_verified', 'resetTeardownVerified'],
  ['resource_readback_verified', 'resourceReadbackVerified'],
  ['idempotency_verified', 'idempotencyVerified'],
  ['sse_verified', 'sseVerified'],
  ['diagnostics_redacted', 'diagnosticsRedacted'],
];

export async function checkStagingReadiness({
  baseUrl = process.env.RWA_STAGING_BASE_URL || defaultBaseUrl,
  accessToken,
  proofs = {},
  fetchImpl = fetch,
} = {}) {
  const results = [];
  for (const [operation, path] of publicReadOperations) {
    results.push(await checkRead({baseUrl, operation, path, fetchImpl}));
  }

  const publicReadReady = results.every((result) => result.passed);
  let authorizedRead;
  if (accessToken) {
    authorizedRead = await checkRead({
      baseUrl,
      operation: 'account.me',
      path: '/v1/me',
      headers: {authorization: `Bearer ${accessToken}`},
      fetchImpl,
    });
    results.push(authorizedRead);
  }

  const gates = [
    {
      gate: 'controlled_identity',
      passed: Boolean(accessToken) && authorizedRead?.passed === true,
    },
    ...proofDefinitions.map(([gate, key]) => ({
      gate,
      passed: proofs[key] === true,
    })),
  ];
  const failedGates = gates.filter((gate) => !gate.passed).map((gate) => gate.gate);
  const commandReady = publicReadReady && failedGates.length === 0;

  return {
    environment: 'staging',
    readReady: publicReadReady,
    authorizedReadReady: authorizedRead?.passed === true,
    commandMode: commandReady ? 'ready' : 'blocked',
    commandReason: commandReady
      ? 'all_preflight_gates_passed'
      : publicReadReady
        ? 'command_gates_incomplete'
        : 'read_preflight_failed',
    failedGates,
    gates,
    results,
  };
}

async function checkRead({baseUrl, operation, path, headers = {}, fetchImpl}) {
  try {
    const response = await fetchImpl(new URL(path, baseUrl), {
      headers: {accept: 'application/json', ...headers},
      signal: AbortSignal.timeout(15_000),
    });
    let code;
    try {
      const body = await response.json();
      code = typeof body?.code === 'string' ? body.code : undefined;
    } catch {}
    return {
      operation,
      status: response.status,
      requestId: response.headers.get('x-request-id') || undefined,
      code,
      passed: response.ok,
    };
  } catch (error) {
    return {
      operation,
      status: 0,
      code: error?.name || 'network_error',
      passed: false,
    };
  }
}

function proofConfigurationFromEnvironment(environment) {
  return {
    isolationApproved: environment.RWA_STAGING_ISOLATION_APPROVED === 'true',
    commandLimitsDefined: environment.RWA_STAGING_COMMAND_LIMITS_DEFINED === 'true',
    resetTeardownVerified: environment.RWA_STAGING_RESET_VERIFIED === 'true',
    resourceReadbackVerified: environment.RWA_STAGING_READBACK_VERIFIED === 'true',
    idempotencyVerified: environment.RWA_STAGING_IDEMPOTENCY_VERIFIED === 'true',
    sseVerified: environment.RWA_STAGING_SSE_VERIFIED === 'true',
    diagnosticsRedacted: environment.RWA_STAGING_REDACTION_VERIFIED === 'true',
  };
}

if (import.meta.url === `file://${process.argv[1]}`) {
  const result = await checkStagingReadiness({
    accessToken: process.env.RWA_STAGING_ACCESS_TOKEN,
    proofs: proofConfigurationFromEnvironment(process.env),
  });
  process.stdout.write(`${JSON.stringify(result, null, 2)}\n`);
  process.exitCode = result.readReady ? 0 : 2;
}
