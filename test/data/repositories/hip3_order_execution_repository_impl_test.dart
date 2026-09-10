import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/hip3_order_execution_repository_impl.dart';
import 'package:rwa_interface/data/services/hip3_order_action_service.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/repositories/hip3_order_execution_repository.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';

void main() {
  test('cancel uses an independently signed cancellation workflow', () async {
    final service = _Service(
      createdAction: _action(signable: true, operation: 'cancel_order'),
      submittedActions: [
        _action(status: 'succeeded', operation: 'cancel_order'),
      ],
    );
    final signer = _Signer();
    await Hip3OrderExecutionRepositoryImpl(
      signer,
      service,
      now: () => DateTime.utc(2026, 9, 9),
      delay: (_) async {},
    ).cancelOrder('order-1', idempotencyKey: 'cancel-key');
    expect(service.createIdempotencyKey, 'cancel-key');
    expect(service.submitCalls, 1);
    expect(signer.calls, 1);
  });
  test(
    'unresolved broadcast reports pending with the original order identity',
    () async {
      final service = _Service(
        createdAction: _action(status: 'ambiguous'),
        fetchedActions: [_action(status: 'ambiguous')],
      );
      final signer = _Signer();
      await expectLater(
        Hip3OrderExecutionRepositoryImpl(
          signer,
          service,
          now: () => DateTime.utc(2026, 9, 9),
          delay: (_) async {},
        ).awaitActionAndSubmit('order-1'),
        throwsA(
          isA<Hip3ExecutionPending>().having(
            (e) => e.orderId,
            'order',
            'order-1',
          ),
        ),
      );
      expect(service.submitCalls, 0);
      expect(signer.calls, 0);
    },
  );
  test(
    'retries only preparation-not-ready with the same creation key',
    () async {
      final service = _Service(
        createdAction: _action(signable: true),
        submittedActions: [_action(status: 'succeeded')],
        notReadyAttempts: 2,
      );
      final signer = _Signer();
      await Hip3OrderExecutionRepositoryImpl(
        signer,
        service,
        now: () => DateTime.utc(2026, 9, 9),
        delay: (_) async {},
      ).awaitActionAndSubmit('order-1');
      expect(service.createCalls, 3);
      expect(signer.calls, 1);
    },
  );

  test(
    'ambiguous broadcast is polled without signing or submitting again',
    () async {
      final service = _Service(
        createdAction: _action(signable: true),
        submittedActions: [_action(status: 'ambiguous')],
        fetchedActions: [_action(status: 'succeeded')],
      );
      final signer = _Signer();
      final result = await Hip3OrderExecutionRepositoryImpl(
        signer,
        service,
        now: () => DateTime.utc(2026, 9, 9),
        delay: (_) async {},
      ).awaitActionAndSubmit('order-1');
      expect(result.resource.status, TradingOrderStatus.open);
      expect(service.submitCalls, 1);
      expect(signer.calls, 1);
    },
  );

  test('lost submission response is reconciled by action query', () async {
    final service = _Service(
      createdAction: _action(signable: true),
      submitTimeout: true,
      fetchedActions: [_action(status: 'succeeded')],
    );
    final signer = _Signer();
    await Hip3OrderExecutionRepositoryImpl(
      signer,
      service,
      now: () => DateTime.utc(2026, 9, 9),
      delay: (_) async {},
    ).awaitActionAndSubmit('order-1');
    expect(service.submitCalls, 1);
    expect(signer.calls, 1);
  });
  test(
    'signs the current action step and fetches the completed order',
    () async {
      final signer = _Signer();
      final service = _Service(
        createdAction: _action(signable: true),
        submittedActions: [_action(status: 'succeeded')],
      );
      final repository = Hip3OrderExecutionRepositoryImpl(
        signer,
        service,
        now: () => DateTime.utc(2026, 9, 9),
        delay: (_) async {},
      );

      final result = await repository.awaitActionAndSubmit('order-1');

      expect(service.createIdempotencyKey, 'hip3-action-create-order-1');
      expect(signer.expectedSigner, _wallet);
      expect(signer.typedData?['primaryType'], 'Agent');
      expect(result.resource.status, TradingOrderStatus.open);
      expect(service.idempotencyKey, 'hip3-action-action-1-step-1');
      expect(service.request?.signature.r, '0x${List.filled(32, '11').join()}');
      expect(service.request?.signature.s, '0x${List.filled(32, '22').join()}');
      expect(
        service.request?.signature.v,
        api.HyperliquidSignatureVEnum.number27,
      );
      expect(service.getOrderCalls, 1);
    },
  );

  test('waits for the server to release a signable step', () async {
    final signer = _Signer();
    final service = _Service(
      createdAction: _action(),
      fetchedActions: [_action(signable: true)],
      submittedActions: [_action(status: 'succeeded')],
    );
    final repository = Hip3OrderExecutionRepositoryImpl(
      signer,
      service,
      now: () => DateTime.utc(2026, 9, 9),
      delay: (_) async {},
    );

    await repository.awaitActionAndSubmit('order-1');

    expect(service.getActionCalls, 1);
    expect(signer.calls, 1);
  });

  test('does not ask the wallet to sign an expired step', () async {
    final signer = _Signer();
    final service = _Service(
      createdAction: _action(
        signable: true,
        validUntil: '2026-09-08T00:00:00Z',
      ),
    );
    final repository = Hip3OrderExecutionRepositoryImpl(
      signer,
      service,
      now: () => DateTime.utc(2026, 9, 9),
      delay: (_) async {},
    );

    await expectLater(
      repository.awaitActionAndSubmit('order-1'),
      throwsA(
        isA<Hip3SigningFailure>().having(
          (failure) => failure.code,
          'code',
          Hip3SigningFailureCode.actionExpired,
        ),
      ),
    );
    expect(signer.calls, 0);
    expect(service.submitCalls, 0);
  });

  test('coalesces concurrent execution for the same order', () async {
    final signer = _Signer();
    final service = _Service(
      createdAction: _action(signable: true),
      submittedActions: [_action(status: 'succeeded')],
    );
    final repository = Hip3OrderExecutionRepositoryImpl(
      signer,
      service,
      now: () => DateTime.utc(2026, 9, 9),
      delay: (_) async {},
    );

    final results = await Future.wait([
      repository.awaitActionAndSubmit('order-1'),
      repository.awaitActionAndSubmit('order-1'),
    ]);

    expect(results, hasLength(2));
    expect(service.createCalls, 1);
    expect(signer.calls, 1);
    expect(service.submitCalls, 1);
  });
}

const _wallet = '0x0000000000000000000000000000000000000001';

api.Hip3Action _action({
  String operation = 'place_order',
  String status = 'awaiting_signature',
  bool signable = false,
  String validUntil = '2026-09-10T00:00:00Z',
}) {
  final json = <String, Object?>{
    'intent': {'operation': operation, 'order_id': 'order-1'},
    'action_id': 'action-1',
    'operation': operation,
    'environment': 'testnet',
    'product_id': 'xyz:NVDA',
    'status': status,
    'order_id': 'order-1',
    'position_id': null,
    'current_step_id': signable ? 'step-1' : null,
    'steps': [
      {
        'step_id': 'step-1',
        'sequence': 1,
        'kind': operation,
        'status': signable ? 'prepared' : 'waiting',
        'signing': signable
            ? {
                'expected_signer': _wallet,
                'signing_method': 'eth_signTypedData_v4',
                'signature_format': 'r_s_v',
                'signing_typed_data': {
                  'domain': {
                    'name': 'Exchange',
                    'version': '1',
                    'chainId': 1337,
                    'verifyingContract':
                        '0x0000000000000000000000000000000000000000',
                  },
                  'types': {
                    'Agent': [
                      {'name': 'source', 'type': 'string'},
                      {'name': 'connectionId', 'type': 'bytes32'},
                    ],
                  },
                  'primaryType': 'Agent',
                  'message': {
                    'source': 'b',
                    'connectionId': '0x${List.filled(32, 'ab').join()}',
                  },
                },
                'signing_digest': '0x${List.filled(32, 'cd').join()}',
                'nonce': 1000,
                'expires_after': 2000,
                'valid_until': validUntil,
              }
            : null,
        'failure_reason': null,
      },
    ],
    'affected_order_ids': ['order-1'],
    'effects_applied': status == 'succeeded',
    'failure_reason': null,
    'created_at': '2026-09-09T00:00:00Z',
    'updated_at': '2026-09-09T00:00:00Z',
  };
  return api.standardSerializers.deserializeWith(
    api.Hip3Action.serializer,
    json,
  )!;
}

api.Order _completedOrder() {
  final json = <String, Object?>{
    'order_id': 'order-1',
    'symbol': 'xyz:NVDA',
    'kind': 'perp',
    'side': 'long',
    'type': 'market',
    'status': 'open',
    'next_action': null,
    'wallet_action_blocker': 'not_applicable',
    'created_at': '2026-09-09T00:00:00Z',
  };
  return api.standardSerializers.deserializeWith(api.Order.serializer, json)!;
}

final class _Signer implements Hip3TypedDataSigner {
  int calls = 0;
  String? expectedSigner;
  Map<String, Object?>? typedData;

  @override
  Future<String> signTypedDataV4({
    required String expectedSigner,
    required Map<String, Object?> typedData,
  }) async {
    calls++;
    this.expectedSigner = expectedSigner;
    this.typedData = typedData;
    return '0x${List.filled(32, '11').join()}'
        '${List.filled(32, '22').join()}00';
  }
}

final class _Service implements Hip3OrderActionService {
  _Service({
    required this.createdAction,
    this._fetchedActions = const [],
    this._submittedActions = const [],
    this.notReadyAttempts = 0,
    this.submitTimeout = false,
  });

  final api.Hip3Action createdAction;
  final List<api.Hip3Action> _fetchedActions;
  final List<api.Hip3Action> _submittedActions;
  final int notReadyAttempts;
  final bool submitTimeout;
  @override
  Future<api.Hip3Action> createCancelOrderAction({
    required String orderId,
    required String idempotencyKey,
  }) =>
      createPlaceOrderAction(orderId: orderId, idempotencyKey: idempotencyKey);
  int createCalls = 0;
  int getActionCalls = 0;
  int getOrderCalls = 0;
  int submitCalls = 0;
  String? createIdempotencyKey;
  String? idempotencyKey;
  api.Hip3ActionSubmissionRequest? request;

  @override
  Future<api.Hip3Action> createPlaceOrderAction({
    required String orderId,
    required String idempotencyKey,
  }) async {
    createCalls++;
    createIdempotencyKey = idempotencyKey;
    if (createCalls <= notReadyAttempts) {
      throw const ServerFailure(
        statusCode: 503,
        code: 'hip3_action_not_ready',
        retryable: true,
      );
    }
    return createdAction;
  }

  @override
  Future<api.Hip3Action> getAction(String actionId) async {
    final index = getActionCalls.clamp(0, _fetchedActions.length - 1).toInt();
    getActionCalls++;
    return _fetchedActions[index];
  }

  @override
  Future<api.Order> getOrder(String orderId) async {
    getOrderCalls++;
    return _completedOrder();
  }

  @override
  Future<api.Hip3Action> submitStep({
    required String orderId,
    required String actionId,
    required String stepId,
    required api.Hip3ActionSubmissionRequest request,
    required String idempotencyKey,
  }) async {
    submitCalls++;
    if (submitTimeout) throw const TimeoutFailure();
    final index = (submitCalls - 1)
        .clamp(0, _submittedActions.length - 1)
        .toInt();
    this.request = request;
    this.idempotencyKey = idempotencyKey;
    return _submittedActions[index];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
