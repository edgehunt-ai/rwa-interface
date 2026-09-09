import '../../domain/models/hip3_order_action.dart';
import '../../domain/repositories/hip3_order_execution_repository.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../services/hip3_order_action_service.dart';

final class Hip3OrderExecutionRepositoryImpl
    implements Hip3OrderExecutionRepository {
  Hip3OrderExecutionRepositoryImpl(
    this._signer,
    this._service, {
    DateTime Function()? now,
    Future<void> Function(Duration)? delay,
  }) : _now = now ?? DateTime.now,
       _delay = delay ?? Future<void>.delayed;

  final Hip3TypedDataSigner _signer;
  final Hip3OrderActionService _service;
  final DateTime Function() _now;
  final Future<void> Function(Duration) _delay;

  @override
  Future<Hip3SubmissionResult> awaitActionAndSubmit({
    required String orderId,
    required String idempotencyKey,
  }) async {
    Object? lastError;
    for (var attempt = 0; attempt < 30; attempt++) {
      try {
        final action = await _service.getAction(orderId);
        return signAndSubmit(action, idempotencyKey: idempotencyKey);
      } on FormatException catch (error) {
        lastError = error;
        await _delay(const Duration(milliseconds: 500));
      }
    }
    throw StateError('HIP-3 action was not ready: $lastError');
  }

  @override
  Future<Hip3SubmissionResult> signAndSubmit(
    Hip3OrderAction action, {
    required String idempotencyKey,
  }) async {
    if (action.isExpiredAt(_now())) {
      throw StateError('HIP-3 action has expired; reload the order');
    }
    final compact = await _signer.signTypedDataV4(
      expectedSigner: action.expectedSigner,
      typedData: action.typedData,
    );
    final signature = Hip3RsvSignature.fromCompactHex(compact);
    return _service.submit(action, signature, idempotencyKey: idempotencyKey);
  }
}
