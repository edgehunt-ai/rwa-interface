import 'dart:convert';

import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/hip3_withdrawal.dart' as domain;
import '../../domain/repositories/hip3_withdrawal_repository.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../services/hip3_withdrawal_service.dart';

final class Hip3WithdrawalRepositoryImpl implements Hip3WithdrawalRepository {
  Hip3WithdrawalRepositoryImpl(
    this._service,
    this._signer, {
    bool Function()? isActive,
  }) : _isActive = isActive ?? (() => true);

  final Hip3WithdrawalService _service;
  final Hip3TypedDataSigner _signer;
  final bool Function() _isActive;

  @override
  Future<domain.Hip3Withdrawal> create({
    required String amount,
    required String idempotencyKey,
  }) async => _map(
    await _service.create(
      api.Hip3WithdrawalCreateRequest(
        (b) => b
          ..amount = amount
          ..rail = api.Hip3WithdrawalCreateRequestRailEnum.float,
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<domain.Hip3Withdrawal> signAndSubmit(
    domain.Hip3Withdrawal prepared, {
    required String idempotencyKey,
  }) async {
    if (prepared.status != 'awaiting_signature' ||
        !prepared.expiresAt.isAfter(DateTime.now())) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.actionExpired);
    }
    if (prepared.ownerAddress.toLowerCase() !=
        prepared.destinationAddress.toLowerCase()) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    final raw = prepared.typedDataJson;
    final hash = prepared.payloadHash;
    if (raw == null || hash == null || hash.isEmpty) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    if (decoded is! Map<String, dynamic>) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    final signature = await _signer.signTypedDataV4(
      expectedSigner: prepared.ownerAddress,
      typedData: decoded.cast<String, Object?>(),
    );
    if (!_isActive()) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.rejected);
    }
    return _map(
      await _service.submit(
        prepared.id,
        api.Hip3WithdrawalSubmissionRequest(
          (b) => b
            ..signature = signature
            ..payloadHash = hash,
        ),
        idempotencyKey: idempotencyKey,
      ),
    );
  }

  @override
  Future<domain.Hip3Withdrawal> get(String id) async =>
      _map(await _service.get(id));

  domain.Hip3Withdrawal _map(api.Hip3Withdrawal value) => domain.Hip3Withdrawal(
    id: value.withdrawalId,
    ownerAddress: value.ownerAddress,
    destinationAddress: value.destinationAddress,
    amount: value.amount,
    fee: value.fee,
    minimumReceived: value.minimumReceived,
    status: value.status == api.Hip3WithdrawalStatus.awaitingSignature
        ? 'awaiting_signature'
        : value.status.name,
    rail: value.rail.name,
    expiresAt: value.expiresAt.toUtc(),
    failureReason: value.failureReason,
    typedDataJson: value.typedDataJson,
    payloadHash: value.payloadHash,
  );
}
