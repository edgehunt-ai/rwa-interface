import 'package:nobell/data/services/hip3_step_confirmation_mapper.dart';
import 'package:nobell/data/services/hip3_action_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:nobell/data/api/idempotency_key.dart';
import 'package:nobell/data/services/hip3_action_binding.dart';
import 'package:nobell/data/services/hip3_position_action_executor.dart';
import 'package:nobell/data/services/hip3_position_action_service.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/hip3_action_pending.dart';
import 'package:nobell/domain/services/hip3_typed_data_signer.dart';

void main() {
  late _Service service;
  late _Signer signer;
  late Hip3PositionActionExecutor executor;
  var active = true;
  setUp(() {
    active = true;
    service = _Service();
    signer = _Signer();
    executor = Hip3PositionActionExecutor(
      service,
      signer,
      now: () => DateTime.utc(2026, 9, 9),
      delay: (_) async {},
      isActive: () => active,
    );
  });
  Future<api.Hip3Action> run({bool accepted = true}) => executor.resume(
    actionId: 'action-1',
    binding: Hip3ActionBinding(
      intent: hip3CurrentIntent(_action()),
      operation: api.Hip3Operation.setLeverage,
      productId: 'xyz:TSLA',
      environment: api.Hip3Environment.testnet,
    ),
    confirm: (_, _) async => accepted,
  );
  Future<api.Hip3Action> runBatch() => executor.resume(
    actionId: 'action-1',
    binding: Hip3ActionBinding(
      intent: hip3CurrentIntent(_batch()),
      operation: api.Hip3Operation.manageTpsl,
      productId: 'xyz:TSLA',
      environment: api.Hip3Environment.testnet,
      positionId: 'p1',
    ),
    confirm: (action, step) async {
      final summary = mapHip3StepConfirmation(action, step);
      expect(summary.protectionOrders.map((order) => order.protection.role), [
        'takeProfit',
        'stopLoss',
      ]);
      expect(
        summary.protectionOrders.map(
          (order) => order.protection.quantity?.value,
        ),
        ['0.25', '0.25'],
      );
      return true;
    },
  );
  test('a batch reviews both normalized orders and signs only once', () async {
    service.initialAction = _batch();
    service.afterSubmit = _batch(done: true);
    final result = await runBatch();
    expect(mapHip3ActionSummary(result).isSuccessful, isTrue);
    expect(signer.calls, 1);
    expect(service.submits, 1);
  });
  test('an acknowledged order never counts as confirmed success', () async {
    service.initialAction = _batch();
    service.afterSubmit = _batch(done: true, acknowledged: true);
    await expectLater(runBatch(), throwsA(isA<Hip3ActionPending>()));
    expect(signer.calls, 1);
    expect(service.submits, 1);
  });
  test('batch signing rejects missing per-order parameters', () async {
    service.initialAction = _batch(omitOrders: true);
    await expectLater(runBatch(), throwsA(isA<Hip3SigningFailure>()));
    expect(signer.calls, 0);
    expect(service.submits, 0);
  });
  test('missing one batch result cannot be reported as success', () async {
    service.initialAction = _batch();
    service.afterSubmit = _batch(done: true).rebuild((b) {
      b.steps[0] = b.steps[0].rebuild(
        (step) => step.protectionOrders.removeLast(),
      );
    });
    await expectLater(runBatch(), throwsA(isA<Hip3ActionPending>()));
    expect(mapHip3ActionSummary(service.afterSubmit!).isSuccessful, isFalse);
    expect(signer.calls, 1);
  });
  test(
    'an unrequested change index is rejected before batch signing',
    () async {
      service.initialAction = _batch().rebuild((b) {
        b.steps[0] = b.steps[0].rebuild((step) {
          step.protectionOrders[0] = step.protectionOrders[0].rebuild(
            (order) => order.changeIndex = 3,
          );
        });
      });
      await expectLater(runBatch(), throwsA(isA<Hip3SigningFailure>()));
      expect(signer.calls, 0);
      expect(service.submits, 0);
    },
  );
  test('signs once and submits signature only', () async {
    expect((await run()).status, api.Hip3ActionStatus.succeeded);
    expect(signer.calls, 1);
    expect(service.submits, 1);
    expect(service.key, scopedIdempotencyKey('hip3-action-action-1-step-1'));
    expect(
      service.request!.signature.v,
      api.HyperliquidSignatureVEnum.number27,
    );
  });

  test(
    'logout while wallet signs prevents submission and preserves action ID',
    () async {
      signer.onSign = () => active = false;
      await expectLater(
        run(),
        throwsA(
          isA<Hip3ActionPending>().having(
            (e) => e.actionId,
            'action ID',
            'action-1',
          ),
        ),
      );
      expect(signer.calls, 1);
      expect(service.submits, 0);
    },
  );

  test('inactive session never fetches or invokes the wallet', () async {
    active = false;
    await expectLater(run(), throwsA(isA<Hip3ActionPending>()));
    expect(service.reads, 0);
    expect(signer.calls, 0);
  });
  test(
    'lost submission response queries success without signing again',
    () async {
      service.loseResponse = true;
      expect((await run()).status, api.Hip3ActionStatus.succeeded);
      expect(service.reads, 2);
      expect(service.submits, 1);
      expect(signer.calls, 1);
    },
  );
  test('failed recovery reads preserve action ID and never resubmit', () async {
    service
      ..loseResponse = true
      ..failRecovery = true;
    await expectLater(
      run(),
      throwsA(
        isA<Hip3ActionPending>().having(
          (e) => e.actionId,
          'action ID',
          'action-1',
        ),
      ),
    );
    expect(service.submits, 1);
    expect(signer.calls, 1);
  });
  test('declined confirmation never invokes wallet or submits', () async {
    await expectLater(run(accepted: false), throwsA(isA<Hip3SigningFailure>()));
    expect(signer.calls, 0);
    expect(service.submits, 0);
  });
  test('wrong product fails before confirmation and signature', () async {
    service.wrongProduct = true;
    await expectLater(run(), throwsA(isA<Hip3SigningFailure>()));
    expect(signer.calls, 0);
    expect(service.submits, 0);
  });
  test('terminal failure preserves structured recovery metadata', () async {
    service.initialAction = _action(
      status: 'failed',
      stepStatus: 'failed',
      stepFailureCode:
          Hip3ActionFailureCodes.marginModeChangeRequiresFlatPosition,
      actionFailureCode: 'less_specific_action_code',
      userAction: Hip3ActionUserActions.keepMarginModeOrClosePosition,
    );

    await expectLater(
      run(),
      throwsA(
        isA<Hip3SigningFailure>()
            .having(
              (failure) => failure.failureCode,
              'failure code',
              Hip3ActionFailureCodes.marginModeChangeRequiresFlatPosition,
            )
            .having(
              (failure) => failure.userAction,
              'user action',
              Hip3ActionUserActions.keepMarginModeOrClosePosition,
            ),
      ),
    );
    expect(signer.calls, 0);
    expect(service.submits, 0);
  });
  test('polls 50 times at one-second intervals before pending', () async {
    final delays = <Duration>[];
    service.stayPending = true;
    executor = Hip3PositionActionExecutor(
      service,
      signer,
      now: () => DateTime.utc(2026, 9, 9),
      delay: (duration) async => delays.add(duration),
      isActive: () => active,
    );

    await expectLater(run(), throwsA(isA<Hip3ActionPending>()));

    expect(service.reads, 51);
    expect(delays, List.filled(50, const Duration(seconds: 1)));
    expect(signer.calls, 0);
    expect(service.submits, 0);
  });
  test(
    'each released step requires its own confirmation and signature',
    () async {
      service.multiStep = true;
      final confirmed = <String>[];
      await executor.resume(
        actionId: 'action-1',
        binding: Hip3ActionBinding(
          intent: hip3CurrentIntent(_action()),
          operation: api.Hip3Operation.setLeverage,
          productId: 'xyz:TSLA',
          environment: api.Hip3Environment.testnet,
        ),
        confirm: (_, step) async {
          confirmed.add(step.stepId);
          return true;
        },
      );
      expect(confirmed, ['step-1', 'step-2']);
      expect(signer.calls, 2);
      expect(service.submits, 2);
    },
  );
}

api.Hip3Action _action({
  bool done = false,
  String? status,
  String? stepStatus,
  String? stepFailureCode,
  String? actionFailureCode,
  String? userAction,
}) => api.standardSerializers.deserializeWith(
  api.Hip3Action.serializer,
  <String, Object?>{
    'intent': {
      'operation': 'set_leverage',
      'context_id': 'ctx-1',
      'leverage': '2',
      'margin_mode': 'cross',
    },
    'action_id': 'action-1',
    'operation': 'set_leverage',
    'environment': 'testnet',
    'product_id': 'xyz:TSLA',
    'status': status ?? (done ? 'succeeded' : 'awaiting_signature'),
    'current_step_id': done ? null : 'step-1',
    'steps': <Object?>[
      {
        'step_id': 'step-1',
        'sequence': 1,
        'kind': 'set_leverage',
        'status': stepStatus ?? (done ? 'succeeded' : 'prepared'),
        'signing': done
            ? null
            : {
                'expected_signer': '0x0000000000000000000000000000000000000001',
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
                  'message': {'source': 'b', 'connectionId': '0x${'ab' * 32}'},
                },
                'signing_digest': '0x${'cd' * 32}',
                'nonce': 1000,
                'expires_after': 2000,
                'valid_until': '2026-09-10T00:00:00Z',
              },
        'failure_code': stepFailureCode,
      },
    ],
    'affected_order_ids': <String>[],
    'effects_applied': done,
    'failure_code': actionFailureCode,
    'user_action': userAction,
    'created_at': '2026-09-09T00:00:00Z',
    'updated_at': '2026-09-09T00:00:00Z',
  },
)!;

api.Hip3Action _batch({
  bool done = false,
  bool acknowledged = false,
  bool omitOrders = false,
}) {
  final raw = Map<String, Object?>.from(
    api.standardSerializers.serializeWith(
          api.Hip3Action.serializer,
          _action(done: done),
        )!
        as Map,
  );
  raw['operation'] = 'manage_tpsl';
  raw['position_id'] = 'p1';
  final protections = [
    for (final role in ['take_profit', 'stop_loss'])
      {
        'size_mode': 'quantity',
        'quantity': '0.25',
        role: {
          'trigger_price': role == 'take_profit' ? '130' : '90',
          'trigger_reference': 'mark',
          'execution_type': 'market',
        },
      },
  ];
  raw['intent'] = {
    'operation': 'manage_tpsl',
    'position_id': 'p1',
    'position_version': 'v1',
    'changes': [
      for (final protection in protections)
        {'operation': 'create', 'protection': protection},
    ],
  };
  final step = Map<String, Object?>.from((raw['steps'] as List).single as Map);
  step['kind'] = 'place_protection';
  if (!omitOrders) {
    step['protection_orders'] = [
      for (var i = 0; i < 2; i++)
        {
          'change_index': i,
          'order_id': 'child-$i',
          'replaced_order_id': null,
          'role': i == 0 ? 'take_profit' : 'stop_loss',
          'protection': protections[i],
          'status': done
              ? acknowledged && i == 1
                    ? 'acknowledged'
                    : 'confirmed'
              : 'prepared',
          'failure_reason': null,
        },
    ];
  }
  raw['steps'] = [step];
  return api.standardSerializers.deserializeWith(
    api.Hip3Action.serializer,
    raw,
  )!;
}

final class _Signer implements Hip3TypedDataSigner {
  int calls = 0;
  void Function()? onSign;
  @override
  Future<String> signTypedDataV4({
    required String expectedSigner,
    required Map<String, Object?> typedData,
  }) async {
    calls++;
    onSign?.call();
    return '0x${'11' * 32}${'22' * 32}00';
  }
}

final class _Service implements Hip3PositionActionService {
  int reads = 0;
  int submits = 0;
  bool loseResponse = false;
  bool failRecovery = false;
  bool wrongProduct = false;
  bool multiStep = false;
  bool stayPending = false;
  api.Hip3Action? initialAction;
  api.Hip3Action? afterSubmit;
  String? key;
  api.Hip3ActionSubmissionRequest? request;
  @override
  Future<api.Hip3Action> get(String actionId) async {
    reads++;
    if (reads > 1 && failRecovery) throw const TimeoutFailure();
    if (initialAction != null && submits == 0) return initialAction!;
    if (afterSubmit != null && submits > 0) return afterSubmit!;
    final result = stayPending
        ? _action().rebuild(
            (b) => b
              ..status = api.Hip3ActionStatus.reconciling
              ..currentStepId = null
              ..steps[0] = b.steps[0].rebuild(
                (step) => step
                  ..status = api.Hip3ActionStepStatusEnum.reconciling
                  ..signing = null,
              ),
          )
        : _action(done: submits > 0);
    return wrongProduct
        ? result.rebuild((b) => b.productId = 'xyz:NVDA')
        : result;
  }

  @override
  Future<api.Hip3Action> submit(
    String actionId,
    String stepId,
    api.Hip3ActionSubmissionRequest request,
    String idempotencyKey,
  ) async {
    submits++;
    this.request = request;
    key = idempotencyKey;
    if (loseResponse) throw const TimeoutFailure();
    if (afterSubmit != null) return afterSubmit!;
    if (multiStep && submits == 1) {
      return _action().rebuild((b) {
        b.currentStepId = 'step-2';
        b.steps[0] = b.steps[0].rebuild(
          (s) => s
            ..stepId = 'step-2'
            ..sequence = 2,
        );
      });
    }
    return _action(done: true);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
