import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/repositories/hip3_order_execution_repository_impl.dart';
import 'package:rwa_interface/data/services/hip3_order_action_service.dart';
import 'package:rwa_interface/domain/models/hip3_order_action.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';

void main() {
  test('polls, signs typed data, and submits only normalized r/s/v', () async {
    final service = _Service();
    final signer = _Signer();
    final repository = Hip3OrderExecutionRepositoryImpl(
      signer,
      service,
      now: () => DateTime.utc(2026),
      delay: (_) async {},
    );

    final result = await repository.awaitActionAndSubmit(
      orderId: 'order-1',
      idempotencyKey: 'submit-1',
    );

    expect(result.status, 'open');
    expect(service.loads, 2);
    expect(signer.expectedSigner, _action.expectedSigner);
    expect(service.signature?.v, 28);
    expect(service.idempotencyKey, 'submit-1');
  });
}

final _action = Hip3OrderAction(
  orderId: 'order-1',
  actionId: 'action-1',
  expectedSigner: '0x1111111111111111111111111111111111111111',
  typedData: const {'primaryType': 'Agent'},
  signingDigest: '0x${List.filled(32, '00').join()}',
  validUntil: DateTime.utc(2027),
);

final class _Signer implements Hip3TypedDataSigner {
  String? expectedSigner;

  @override
  Future<String> signTypedDataV4({
    required String expectedSigner,
    required Map<String, Object?> typedData,
  }) async {
    this.expectedSigner = expectedSigner;
    return '0x${List.filled(64, '11').join()}01';
  }
}

final class _Service implements Hip3OrderActionService {
  int loads = 0;
  Hip3RsvSignature? signature;
  String? idempotencyKey;

  @override
  Future<Hip3OrderAction> getAction(String orderId) async {
    loads++;
    if (loads == 1) throw const FormatException('not ready');
    return _action;
  }

  @override
  Future<Hip3SubmissionResult> submit(
    Hip3OrderAction action,
    Hip3RsvSignature signature, {
    required String idempotencyKey,
  }) async {
    this.signature = signature;
    this.idempotencyKey = idempotencyKey;
    return Hip3SubmissionResult(orderId: action.orderId, status: 'open');
  }
}
