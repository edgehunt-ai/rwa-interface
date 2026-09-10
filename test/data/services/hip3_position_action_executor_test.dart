import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/services/hip3_action_binding.dart';
import 'package:rwa_interface/data/services/hip3_position_action_executor.dart';
import 'package:rwa_interface/data/services/hip3_position_action_service.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/hip3_action_pending.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';

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
      intent: _action().intent,
      operation: api.Hip3Operation.setLeverage,
      productId: 'xyz:TSLA',
      environment: api.Hip3Environment.testnet,
    ),
    confirm: (_, _) async => accepted,
  );
  test('signs once and submits signature only', () async {
    expect((await run()).status, api.Hip3ActionStatus.succeeded);
    expect(signer.calls, 1);
    expect(service.submits, 1);
    expect(service.key, 'hip3-action-action-1-step-1');
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
  test(
    'each released step requires its own confirmation and signature',
    () async {
      service.multiStep = true;
      final confirmed = <String>[];
      await executor.resume(
        actionId: 'action-1',
        binding: Hip3ActionBinding(
          intent: _action().intent,
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
    'status': done ? 'succeeded' : 'awaiting_signature',
    'current_step_id': done ? null : 'step-1',
    'steps': <Object?>[
      {
        'step_id': 'step-1',
        'sequence': 1,
        'kind': 'set_leverage',
        'status': done ? 'succeeded' : 'prepared',
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
      },
    ],
    'affected_order_ids': <String>[],
    'effects_applied': done,
    'created_at': '2026-09-09T00:00:00Z',
    'updated_at': '2026-09-09T00:00:00Z',
  },
)!;

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
  String? key;
  api.Hip3ActionSubmissionRequest? request;
  @override
  Future<api.Hip3Action> get(String actionId) async {
    reads++;
    if (reads > 1 && failRecovery) throw const TimeoutFailure();
    final result = _action(done: submits > 0);
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
