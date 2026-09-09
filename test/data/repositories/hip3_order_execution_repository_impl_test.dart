import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/hip3_order_execution_repository_impl.dart';
import 'package:rwa_interface/data/services/hip3_order_action_service.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';

void main() {
  test(
    'waits for action, signs exact typed data, and submits only r/s/v',
    () async {
      final signer = _Signer();
      final service = _Service([_order(), _order(withAction: true)]);
      final repository = Hip3OrderExecutionRepositoryImpl(
        signer,
        service,
        now: () => DateTime.utc(2026, 9, 9),
        delay: (_) async {},
      );

      final result = await repository.awaitActionAndSubmit('order-1');

      expect(service.getCalls, 2);
      expect(signer.expectedSigner, _wallet);
      expect(signer.typedData?['primaryType'], 'Agent');
      expect(result.resource.status, TradingOrderStatus.open);
      expect(service.idempotencyKey, 'hip3-action-action-1');
      expect(service.request?.signature.r, '0x${List.filled(32, '11').join()}');
      expect(service.request?.signature.s, '0x${List.filled(32, '22').join()}');
      expect(
        service.request?.signature.v,
        api.HyperliquidSignatureVEnum.number27,
      );
    },
  );

  test('does not ask wallet to sign an expired action', () async {
    final signer = _Signer();
    final service = _Service([
      _order(withAction: true, validUntil: '2026-09-08T00:00:00Z'),
    ]);
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
    final service = _Service([_order(withAction: true)]);
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
    expect(signer.calls, 1);
    expect(service.submitCalls, 1);
  });
}

const _wallet = '0x0000000000000000000000000000000000000001';

api.Order _order({
  bool withAction = false,
  String validUntil = '2026-09-10T00:00:00Z',
}) {
  final json = <String, Object?>{
    'order_id': 'order-1',
    'symbol': 'xyz:NVDA',
    'kind': 'perp',
    'side': 'long',
    'type': 'market',
    'status': 'pending_signature',
    'next_action': null,
    'wallet_action_blocker': 'not_applicable',
    'created_at': '2026-09-09T00:00:00Z',
    if (withAction)
      'hip3_action': {
        'action_id': 'action-1',
        'operation': 'place_order',
        'environment': 'testnet',
        'expected_signer': _wallet,
        'nonce': 1000,
        'expires_after': 2000,
        'signing_method': 'eth_signTypedData_v4',
        'signature_format': 'r_s_v',
        'signing_typed_data': {
          'domain': {
            'name': 'Exchange',
            'version': '1',
            'chainId': 1337,
            'verifyingContract': '0x0000000000000000000000000000000000000000',
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
        'valid_until': validUntil,
      },
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
  _Service(this.orders);

  final List<api.Order> orders;
  int getCalls = 0;
  int submitCalls = 0;
  String? idempotencyKey;
  api.Hip3ActionSubmissionRequest? request;

  @override
  Future<api.Order> getOrder(String orderId) async {
    final index = getCalls.clamp(0, orders.length - 1).toInt();
    getCalls++;
    return orders[index];
  }

  @override
  Future<api.Order> submit({
    required String orderId,
    required String actionId,
    required api.Hip3ActionSubmissionRequest request,
    required String idempotencyKey,
  }) async {
    submitCalls++;
    this.request = request;
    this.idempotencyKey = idempotencyKey;
    final submitted = _order(withAction: true).toBuilder()
      ..status = api.OrderStatus.open;
    return submitted.build();
  }
}
