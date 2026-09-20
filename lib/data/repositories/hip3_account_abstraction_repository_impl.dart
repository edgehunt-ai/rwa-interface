import 'dart:convert';

import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/hip3_account_abstraction.dart';
import '../../domain/models/api_failure.dart';
import '../../domain/repositories/hip3_account_abstraction_repository.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../services/hip3_account_abstraction_service.dart';

final class Hip3AccountAbstractionRepositoryImpl
    implements Hip3AccountAbstractionRepository {
  Hip3AccountAbstractionRepositoryImpl(this._service, this._signer);

  final Hip3AccountAbstractionService _service;
  final Hip3TypedDataSigner _signer;

  @override
  Future<Hip3AccountAbstractionStatus> getStatus() async =>
      _mapStatus(await _service.getStatus());

  @override
  Future<Hip3AccountAbstractionStatus> switchToUnifiedAccount({
    required String prepareIdempotencyKey,
    required String executeIdempotencyKey,
  }) async {
    final prepared = await _service.prepare(
      idempotencyKey: prepareIdempotencyKey,
    );
    String? signature;
    if (prepared.executionMethod ==
        api.Hip3AccountAbstractionExecutionMethod.user) {
      final raw = prepared.typedDataJson;
      if (raw == null) throw const FormatException('Missing account payload');
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        throw const FormatException('Invalid account payload');
      }
      signature = await _signer.signTypedDataV4(
        expectedSigner: prepared.ownerAddress,
        typedData: decoded.map(
          (key, value) => MapEntry(key.toString(), value as Object?),
        ),
      );
    }
    late final api.Hip3AccountAbstraction result;
    try {
      result = await _service.execute(
        idempotencyKey: executeIdempotencyKey,
        request: api.Hip3AccountAbstractionExecuteRequest(
          (b) => b
            ..targetMode = api
                .Hip3AccountAbstractionExecuteRequestTargetModeEnum
                .unifiedAccount
            ..executionMethod = prepared.executionMethod
            ..nonce = prepared.nonce
            ..payloadHash = prepared.payloadHash
            ..signature = signature,
        ),
      );
    } on ServerFailure catch (failure) {
      // A provider submission can complete while the API request returns a
      // lifecycle conflict. Reconcile the authoritative account state before
      // asking the user to retry, which could create a second prepare action.
      if (failure.statusCode != 409) rethrow;
      try {
        final reconciled = _mapStatus(await _service.getStatus());
        if (reconciled.isUnifiedAccount) return reconciled;
      } on Object {
        // Preserve the original execute conflict when reconciliation fails.
      }
      rethrow;
    }
    final status = _mapStatus(result);
    if (!status.isUnifiedAccount) {
      throw const FormatException('Unified Account switch was not confirmed');
    }
    return status;
  }

  Hip3AccountAbstractionStatus _mapStatus(api.Hip3AccountAbstraction value) =>
      Hip3AccountAbstractionStatus(
        ownerAddress: value.ownerAddress,
        currentMode: switch (value.currentMode) {
          api.Hip3AccountAbstractionMode.default_ =>
            Hip3AccountAbstractionMode.defaultMode,
          api.Hip3AccountAbstractionMode.unifiedAccount =>
            Hip3AccountAbstractionMode.unifiedAccount,
          api.Hip3AccountAbstractionMode.portfolioMargin =>
            Hip3AccountAbstractionMode.portfolioMargin,
          _ => Hip3AccountAbstractionMode.unknown,
        },
        switchAvailable: value.switchAvailable,
      );
}
