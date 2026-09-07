import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every traceability link names a real executable test', () {
    expect(_scenarios, hasLength(greaterThanOrEqualTo(50)));
    expect(
      _scenarios
          .map((scenario) => '${scenario.file}|${scenario.testName}')
          .toSet(),
      hasLength(_scenarios.length),
    );
    for (final scenario in _scenarios) {
      final source = File(scenario.file).readAsStringSync();
      expect(
        source,
        contains(scenario.testName),
        reason: '${scenario.file}: ${scenario.testName}',
      );
    }
  });

  test(
    'all stories, requirements, and success criteria have executable links',
    () {
      final covered = _scenarios.expand((scenario) => scenario.refs).toSet();
      expect(covered, containsAll(_requiredRefs));
    },
  );
}

final class _ScenarioLink {
  const _ScenarioLink(this.file, this.testName, this.refs);
  final String file;
  final String testName;
  final Set<String> refs;
}

const _requiredRefs = {
  'US1/AC1',
  'US1/AC2',
  'US1/AC3',
  'US2/AC1',
  'US2/AC2',
  'US2/AC3',
  'US3/AC1',
  'US3/AC2',
  'US3/AC3',
  'US4/AC1',
  'US4/AC2',
  'US4/AC3',
  'US5/AC1',
  'US5/AC2',
  'US5/AC3',
  'FR-001',
  'FR-002',
  'FR-003',
  'FR-004',
  'FR-005',
  'FR-006',
  'FR-007',
  'FR-008',
  'FR-009',
  'FR-010',
  'FR-011',
  'FR-012',
  'FR-013',
  'FR-014',
  'FR-015',
  'FR-016',
  'FR-017',
  'FR-018',
  'FR-019',
  'FR-020',
  'FR-021',
  'FR-022',
  'FR-023',
  'SC-001',
  'SC-002',
  'SC-003',
  'SC-004',
  'SC-005',
};

const _scenarios = <_ScenarioLink>[
  _ScenarioLink(
    'test/acceptance/session_account_flow_test.dart',
    'creates, logs out, and restores an isolated account session',
    {'US1/AC1', 'US1/AC3', 'FR-001', 'FR-002', 'FR-003', 'SC-001'},
  ),
  _ScenarioLink(
    'test/acceptance/session_account_flow_test.dart',
    'maps a rejected credential without exposing account data',
    {'US1/AC2', 'FR-003', 'FR-019', 'SC-005'},
  ),
  _ScenarioLink(
    'test/acceptance/session_account_flow_test.dart',
    'drops a delayed response from an obsolete session generation',
    {'FR-001', 'FR-018', 'SC-004'},
  ),
  _ScenarioLink(
    'test/acceptance/order_position_flow_test.dart',
    'order and position commands traverse the complete controlled boundary',
    {
      'US3/AC1',
      'US3/AC2',
      'US3/AC3',
      'FR-008',
      'FR-009',
      'FR-011',
      'FR-012',
      'FR-021',
      'SC-001',
    },
  ),
  _ScenarioLink(
    'test/acceptance/funding_flow_test.dart',
    'funding commands traverse the complete controlled boundary',
    {
      'US4/AC1',
      'US4/AC2',
      'US4/AC3',
      'FR-013',
      'FR-014',
      'FR-015',
      'FR-021',
      'SC-001',
    },
  ),
  _ScenarioLink(
    'test/ui/features/positions/providers/position_providers_test.dart',
    'position list forwards filters through repository boundary',
    {'FR-011'},
  ),
  _ScenarioLink(
    'test/ui/features/positions/providers/position_providers_test.dart',
    'same position command merges concurrency and preserves retry key',
    {'FR-010', 'FR-011', 'SC-002'},
  ),
  _ScenarioLink(
    'test/ui/features/positions/providers/position_providers_test.dart',
    'close retry reuses key while a changed economic intent gets a new key',
    {'FR-010', 'FR-011', 'SC-002'},
  ),
  _ScenarioLink(
    'test/ui/features/positions/providers/position_providers_test.dart',
    'successful command invalidates only its detail and position lists',
    {'FR-011', 'FR-022'},
  ),
  _ScenarioLink(
    'test/ui/features/positions/providers/position_providers_test.dart',
    'failed command preserves the last confirmed detail',
    {'FR-019', 'FR-022', 'SC-005'},
  ),
  _ScenarioLink(
    'test/ui/features/funding/providers/deposit_providers_test.dart',
    'funding transfer capability always waits for feature',
    {'FR-014', 'FR-022'},
  ),
  _ScenarioLink(
    'test/ui/features/funding/providers/deposit_providers_test.dart',
    'same deposit intent merges concurrency and preserves retry key',
    {'FR-010', 'FR-013', 'SC-002'},
  ),
  _ScenarioLink(
    'test/ui/features/funding/providers/deposit_providers_test.dart',
    'catalog, list, and detail are isolated by session generation',
    {'FR-003', 'FR-013'},
  ),
  _ScenarioLink(
    'test/ui/features/funding/providers/deposit_providers_test.dart',
    'query exposes a stable domain failure',
    {'FR-019', 'FR-022', 'SC-005'},
  ),
  _ScenarioLink(
    'test/ui/features/funding/providers/withdrawal_providers_test.dart',
    'withdrawal command lifecycle uses stable keys and validates authorization',
    {'FR-010', 'FR-015', 'SC-002'},
  ),
  _ScenarioLink(
    'test/ui/features/funding/providers/withdrawal_providers_test.dart',
    'withdrawal list and detail refresh on session generation',
    {'FR-003', 'FR-015', 'FR-018'},
  ),
  _ScenarioLink(
    'test/ui/features/orders/providers/order_providers_test.dart',
    '20 concurrent submits share one request and one idempotency key',
    {'FR-009', 'FR-010', 'SC-002'},
  ),
  _ScenarioLink(
    'test/data/repositories/orders_repository_test.dart',
    'pending signature is a non-retryable wait capability',
    {'FR-012'},
  ),
  _ScenarioLink(
    'test/data/repositories/positions_repository_test.dart',
    'TP/SL direction uses decimal comparisons without precision loss',
    {'FR-011', 'FR-020', 'SC-003'},
  ),
  _ScenarioLink(
    'test/data/repositories/positions_repository_test.dart',
    'leverage range and mutually exclusive close inputs are validated',
    {'FR-011', 'FR-019'},
  ),
  _ScenarioLink(
    'test/data/repositories/funding_repository_test.dart',
    'requires transfer is represented as non-retryable capability',
    {'FR-014'},
  ),
  _ScenarioLink(
    'test/data/repositories/wallets_repository_test.dart',
    'expired withdrawal authorization is not usable',
    {'FR-015', 'FR-019'},
  ),
  _ScenarioLink(
    'test/data/repositories/market_catalog_repository_test.dart',
    'maps product union, pagination, favorite, and decimal text',
    {'US2/AC1', 'US2/AC3', 'FR-004', 'FR-005', 'FR-007', 'FR-020'},
  ),
  _ScenarioLink(
    'test/data/repositories/portfolio_repository_test.dart',
    'maps account kind and preserves token precision',
    {'US2/AC2', 'FR-006', 'FR-007', 'FR-020', 'SC-003'},
  ),
  _ScenarioLink(
    'test/data/repositories/account_repository_test.dart',
    'maps settings patch and device pagination without push token',
    {'FR-002', 'FR-003'},
  ),
  _ScenarioLink(
    'test/data/repositories/activity_repository_test.dart',
    'maps activity amount with asset and resource reference',
    {'FR-016', 'FR-020', 'FR-021'},
  ),
  _ScenarioLink(
    'test/data/repositories/session_repository_test.dart',
    'maps generated session and user into domain values',
    {'FR-001', 'FR-002'},
  ),
  _ScenarioLink(
    'test/data/repositories/realtime_repository_test.dart',
    'maps envelope to typed entity and sequence',
    {'US5/AC1', 'FR-017'},
  ),
  _ScenarioLink(
    'test/data/api/api_failure_mapper_test.dart',
    'maps declared server error and request ID',
    {'FR-019', 'FR-021'},
  ),
  _ScenarioLink(
    'test/data/api/api_failure_mapper_test.dart',
    'maps timeout and cancellation',
    {'FR-019', 'SC-005'},
  ),
  _ScenarioLink(
    'test/data/api/api_failure_mapper_test.dart',
    'maps stable server categories and removes sensitive details',
    {'FR-019', 'SC-005'},
  ),
  _ScenarioLink(
    'test/data/api/api_failure_mapper_test.dart',
    'distinguishes unauthorized, network, and unknown failures',
    {'FR-019', 'SC-005'},
  ),
  _ScenarioLink(
    'test/data/api/privy_auth_interceptor_test.dart',
    'public operation 不附加 bearer token',
    {'FR-001', 'FR-003'},
  ),
  _ScenarioLink(
    'test/data/api/privy_auth_interceptor_test.dart',
    'adds bearer token and retries one 401 after Privy refresh',
    {'FR-001', 'FR-018'},
  ),
  _ScenarioLink(
    'test/data/api/privy_auth_interceptor_test.dart',
    'returns 401 and expires session when Privy cannot refresh',
    {'FR-001', 'FR-019'},
  ),
  _ScenarioLink(
    'test/data/api/privy_auth_interceptor_test.dart',
    '20 个并发 401 共享一次 refresh 且每个最多重试一次',
    {'FR-001', 'FR-010', 'SC-002'},
  ),
  _ScenarioLink(
    'test/domain/models/decimal_value_test.dart',
    'preserves the supplied decimal text and scale',
    {'FR-020', 'SC-003'},
  ),
  _ScenarioLink(
    'test/domain/models/decimal_value_test.dart',
    'rejects exponent, non-finite, and malformed values',
    {'FR-019', 'FR-020'},
  ),
  _ScenarioLink(
    'test/domain/models/decimal_value_test.dart',
    'only compares values with matching asset and unit',
    {'FR-007', 'FR-020', 'SC-003'},
  ),
  _ScenarioLink(
    'test/domain/models/application_state_test.dart',
    'represents loading, empty, refresh, failure, and capability',
    {'FR-022'},
  ),
  _ScenarioLink(
    'test/domain/models/application_state_test.dart',
    'represents the complete command transition vocabulary',
    {'FR-021', 'FR-022'},
  ),
  _ScenarioLink(
    'test/domain/models/unsupported_capability_test.dart',
    'only exposes the two stable non-retryable capabilities',
    {'FR-012', 'FR-014'},
  ),
  _ScenarioLink(
    'test/domain/models/resource_result_test.dart',
    'returns a resource with an optional capability, not a failure',
    {'FR-012', 'FR-014', 'FR-022'},
  ),
  _ScenarioLink(
    'test/app/providers/realtime_coordinator_test.dart',
    'deduplicates and rejects entity sequence regression',
    {'US5/AC2', 'FR-017', 'FR-018', 'SC-004'},
  ),
  _ScenarioLink(
    'test/app/providers/realtime_coordinator_test.dart',
    'buffers during refresh and applies in order',
    {'US5/AC3', 'FR-018', 'SC-004'},
  ),
  _ScenarioLink(
    'test/app/providers/realtime_coordinator_test.dart',
    'applies one thousand unique ordered events once',
    {'FR-017', 'FR-018', 'SC-004'},
  ),
  _ScenarioLink(
    'test/app/providers/realtime_providers_test.dart',
    'canonical channel key prevents order-dependent state',
    {'FR-017'},
  ),
  _ScenarioLink(
    'test/app/providers/realtime_providers_test.dart',
    'stream provider can be overridden without network',
    {'FR-017', 'FR-023'},
  ),
  _ScenarioLink(
    'test/app/providers/realtime_providers_test.dart',
    '实体 provider 只交付匹配实体的最小更新',
    {'FR-003', 'FR-017'},
  ),
  _ScenarioLink(
    'test/acceptance/security_diagnostics_test.dart',
    'diagnostic failure representation excludes sensitive payloads',
    {'FR-019', 'SC-005'},
  ),
  _ScenarioLink(
    'test/acceptance/scope_guard_test.dart',
    'application ports and providers exclude deferred command entrypoints',
    {'FR-023'},
  ),
  _ScenarioLink(
    'test/ui/features/markets/providers/market_providers_test.dart',
    'isolates complete query parameters',
    {'FR-004', 'FR-005'},
  ),
  _ScenarioLink(
    'test/ui/features/portfolio/providers/portfolio_providers_test.dart',
    'summary is session-scoped and independent from accounts',
    {'FR-003', 'FR-006', 'FR-007'},
  ),
  _ScenarioLink(
    'test/ui/features/account/providers/account_provider_test.dart',
    'account state reloads when the session generation changes',
    {'FR-002', 'FR-003', 'FR-018'},
  ),
  _ScenarioLink(
    'test/ui/features/activity/providers/activity_provider_test.dart',
    'activity provider keeps filter isolated',
    {'FR-016'},
  ),
  _ScenarioLink(
    'test/ui/features/session/providers/session_provider_test.dart',
    'creates once and discards an old generation result',
    {'FR-001', 'FR-018'},
  ),
  _ScenarioLink(
    'test/data/api/sse_parser_test.dart',
    'parses fragmented CRLF frames, multiline data, and ignores comments',
    {'FR-017', 'FR-018'},
  ),
  _ScenarioLink(
    'test/data/api/sse_parser_test.dart',
    '1,000 个任意分片 frame 保持完整顺序',
    {'FR-017', 'SC-004'},
  ),
  _ScenarioLink(
    'test/data/api/request_replay_policy_test.dart',
    'GET is replayable',
    {'FR-018'},
  ),
  _ScenarioLink(
    'test/data/api/request_replay_policy_test.dart',
    'mutation requires idempotency key',
    {'FR-010'},
  ),
  _ScenarioLink(
    'test/data/api/request_replay_policy_test.dart',
    'idempotent mutation with buffered body is replayable',
    {'FR-010', 'SC-002'},
  ),
  _ScenarioLink(
    'test/data/api/request_replay_policy_test.dart',
    'stream body is never replayed',
    {'FR-010', 'FR-019'},
  ),
  _ScenarioLink(
    'test/data/api/api_environment_test.dart',
    'rejects missing and relative URLs',
    {'FR-023'},
  ),
];
